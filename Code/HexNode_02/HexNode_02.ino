/*
  HexNode - one module of an interactive light wall
  Version 2 (20 Nov 2026): tested on ESP32 DevKit V1 boards with the CP2102 USB chip.
  CPU at 80 MHz + gentle radio start stop the brownout resets; touch sensitivity via 'sens' (default 60/30).
  Version 2.1 (24 Nov 2026): the touch direction (reading drops or rises) is learned from the first touch,
  so other chips/cores work without editing; 'cal' recalibrates.
  Version 2.3 (24 Nov 2026): core 4.0 bug - touchRead() returns 0 on the classic ESP32 (the core cannot
  map pins to touch channels on ESP-IDF 6.1). On core 4.x the sketch now starts the ESP-IDF touch driver
  itself. Tested on core 3.3.12 and 4.0.0. (2.2's register read is removed - it could not work there.)
  ---------------------------------------------------
  Hardware : ESP32 DevKit (classic), WS2812B ring x16, bare wire on a touch pin
  Core     : Arduino-ESP32 3.x or 4.x   (Boards Manager -> "esp32 by Espressif")
  Library  : Adafruit NeoPixel   (Library Manager)

  HOW IT WORKS
  * Every module broadcasts a small "hello" beacon about once a second (ESP-NOW, no router).
    From the beacons each module builds a neighbour table (id, position, signal strength).
  * A module is a LINKED neighbour if
        - both modules know their hex-grid position and are within MAX_LINK_HEX_DIST cells, or
        - (no positions set) the smoothed signal strength is stronger than NEIGHBOR_RSSI_MIN.
  * Touch (or hand-wave) -> the module creates a WAVE packet. Every module that receives a wave
    from a linked neighbour plays it, adds the hex distance travelled, and forwards it once.
    Duplicates are dropped via (origin, sequence). A module at distance d starts its ripple
    d * HOP_MS after the touch, so the ripple expands across the wall like a real wave.
  * With grid positions the light sweeps across the ring in the direction the wave is travelling.

  SETTING THE GRID POSITION (same sketch on every module)
  Axial hex coordinates (q = column, r = row), pointy-top layout:

            row 0:      (0,0)  (1,0)  (2,0)  (3,0)
            row 1:   (-1,1)  (0,1)  (1,1)  (2,1)  (3,1)
            row 2:      (-1,2) (0,2)  (1,2)  (2,2)

  Odd rows are shifted half a module to the right. Open the Serial Monitor (115200) and type:
      pos 2 1     set position q=2 r=1 (saved to flash)
      pos auto    forget position, use signal strength to find neighbours
      test        fire a wave from this module
      dbg         toggle live touch readings (use this to choose a sensitivity)
      sens 30     touch threshold: % change that counts as a touch (higher = less sensitive);
                  release at half of it. "sens 30 12" sets both. "sens" alone shows them (saved to flash)
      cal         recalibrate the touch baseline (hands off) and re-learn the touch direction
      info        print core version, touch settings, id, position and neighbour table
*/

#include <Arduino.h>
#include <WiFi.h>
#include <esp_now.h>
#include <esp_wifi.h>
#include <Preferences.h>
#include <Adafruit_NeoPixel.h>
#include <math.h>
#include <esp_arduino_version.h>
#include <esp_idf_version.h>
#include <string.h>
#include "soc/soc.h"
#include "soc/rtc_cntl_reg.h"
#if defined(CONFIG_IDF_TARGET_ESP32) && ESP_ARDUINO_VERSION_MAJOR >= 4
#include "driver/touch_sens.h"              // core 4.x workaround, see TOUCH_DIRECT below
#include "hal/touch_sensor_periph.h"
#endif

// ============================ USER SETTINGS ============================
// Brownout detector: 0 = on (normal). 1 = off, only for boards whose 3.3 V supply dips when the
// radio starts and reset in a loop with "Brownout detector was triggered" (seen on some CP2102
// DevKit V1 boards). A real power failure is then not caught; fix the supply where you can.
#ifndef DISABLE_BROWNOUT
#define DISABLE_BROWNOUT 0
#endif
// Gentle radio start: LEDs off and short pauses while the radio powers up, and an optional lower
// CPU clock (80 MHz instead of 240) to cut the total current. Helps boards with a weak 3.3 V supply.
#ifndef GENTLE_RADIO_START
#define GENTLE_RADIO_START 1
#endif
#ifndef CPU_MHZ
#define CPU_MHZ 80                    // 80 keeps weak boards from browning out when the radio starts
                                      // (fixed the CP2102 DevKit V1); 240 = ESP32 default. LEDs use the RMT.
#endif
#define LED_PIN          15     // D13: data to ring DIN (through 330 ohm), next to GND and VIN on the header
#define NUM_LEDS         16
#define TOUCH_PIN        13      // T0 on classic ESP32
#define BRIGHTNESS       30     // 0-255, keeps a USB power bank happy

constexpr int8_t  POS_UNKNOWN        = 127;
constexpr int8_t  DEFAULT_Q          = POS_UNKNOWN;  // used until you type "pos q r"
constexpr int8_t  DEFAULT_R          = POS_UNKNOWN;
constexpr int     MAX_LINK_HEX_DIST  = 2;     // 1 = strict neighbours; 2 = can hop over a missing module
constexpr int     NEIGHBOR_RSSI_MIN  = -55;   // dBm, only used when positions are unknown
constexpr int8_t  TX_POWER_QDBM      = 20;    // 20 = 5 dBm (units of 0.25 dBm); lower = better RSSI separation

constexpr uint8_t ESPNOW_CHANNEL     = 1;
constexpr uint32_t HELLO_MS          = 1000;
constexpr uint32_t NEIGHBOR_TIMEOUT  = 5000;

constexpr float   TOUCH_ON_PCT       = 60.0f; // default % change from baseline that counts as touch / hand nearby
constexpr float   TOUCH_OFF_PCT      = 30.0f; // default release level ("sens" command overrides both, saved to flash)
constexpr uint32_t TOUCH_COOLDOWN_MS = 250;   // min time between two waves from one module
constexpr uint32_t HOLD_REPEAT_MS    = 900;   // while held, fire again this often

constexpr uint8_t MAX_WAVE_DIST      = 12;    // how far (in hex cells) a wave travels
constexpr uint32_t HOP_MS            = 150;   // time for the wave to cross one cell
constexpr float   SWEEP_MS           = 100.0f;// time for the wave to cross one ring
constexpr float   PULSE_MS           = 650.0f;// lifetime of a light pulse on one LED
constexpr float   ATTACK_MS          = 35.0f;
constexpr uint8_t HUE_PER_HOP        = 7;     // colour drift per cell
constexpr float   RING_ROTATION_DEG  = 0.0f;  // angle of LED 0 clockwise from "up"
constexpr bool    RING_CLOCKWISE     = true;  // direction of increasing LED index seen from the front
// =======================================================================

constexpr uint8_t MAGIC = 0xA7;
enum : uint8_t { PKT_HELLO = 1, PKT_WAVE = 2 };

struct __attribute__((packed)) Packet {
  uint8_t  magic;
  uint8_t  type;
  uint32_t sender;
  int8_t   q, r;              // sender position
  uint32_t origin;            // module that was touched
  int8_t   originQ, originR;  // its position
  uint16_t seq;
  uint8_t  dist;              // accumulated hex distance from origin
  uint8_t  hue;               // base hue chosen by the origin
};

struct RxItem { Packet p; int8_t rssi; };

struct Neighbor {
  bool     used;
  uint32_t id;
  int8_t   q, r;
  float    rssi;
  uint32_t lastSeen;
};

struct Wave {
  bool     active;
  bool     radial;
  bool     self;
  uint32_t start;
  float    dx, dy;
  float    gain;
  uint8_t  hue;
};

struct TxSlot { bool used; uint32_t at; Packet p; };
struct Seen   { uint32_t origin; uint16_t seq; };

constexpr int MAX_NEIGHBORS = 16;
constexpr int MAX_WAVES     = 10;
constexpr int TX_SLOTS      = 16;
constexpr int SEEN_SLOTS    = 32;

Adafruit_NeoPixel ring(NUM_LEDS, LED_PIN, NEO_GRB + NEO_KHZ800);
Preferences prefs;
QueueHandle_t rxQueue;

Neighbor nbrs[MAX_NEIGHBORS];
Wave     waves[MAX_WAVES];
TxSlot   txq[TX_SLOTS];
Seen     seen[SEEN_SLOTS];
uint8_t  seenHead = 0;

uint32_t myId;
int8_t   myQ = POS_UNKNOWN, myR = POS_UNKNOWN;
bool     myPosKnown = false;
uint16_t mySeq;

float ledX[NUM_LEDS], ledY[NUM_LEDS];
float fr[NUM_LEDS], fg[NUM_LEDS], fb[NUM_LEDS];

// touch
float    baseline = 0, smoothed = 0;
bool     touched = false, dbg = false;
uint8_t  onCount = 0;
float    touchOnPct = TOUCH_ON_PCT, touchOffPct = TOUCH_OFF_PCT;   // set with "sens", kept in flash
uint32_t lastFire = 0, lastTouchSample = 0, lastDbg = 0;
// Which way the reading moves on a touch depends on the chip (classic ESP32 drops, S2/S3 rise).
// So the direction is learned at run time: the change is measured both ways and
// the first clear touch (>= touchOnPct in one direction) locks the direction in.
// touchDir: -1 = drops when touched, +1 = rises, 0 = not known yet (both directions count).
int8_t   touchDir = 0;
uint32_t lastCal = 0;

// Core 4.0 bug (classic ESP32): ESP-IDF 6.1 dropped SOC_TOUCH_SENSOR_NUM, and the core's
// digitalPinToTouchChannel() (esp32-hal-gpio.c) was not updated, so it says "Touch sensor not available
// on this chip" and touchRead() returns 0 for every pin without starting the sensor.
// Workaround: on core 4.x the sketch starts the ESP-IDF touch driver itself and reads the raw count.
// Core 3.x keeps using touchRead().
#if defined(CONFIG_IDF_TARGET_ESP32) && ESP_ARDUINO_VERSION_MAJOR >= 4
#define TOUCH_DIRECT 1
#else
#define TOUCH_DIRECT 0
#endif

#if TOUCH_DIRECT
static touch_sensor_handle_t  touchSens = NULL;
static touch_channel_handle_t touchChan = NULL;
static bool touchDirectFailed = false;

static bool touchDirectStart() {
  int ch = -1;
  for (int i = 0; i < 10; i++) if (touch_sensor_channel_io_map[i] == TOUCH_PIN) ch = i;
  if (ch < 0) { Serial.printf("Touch: GPIO%d is not a touch pin\n", TOUCH_PIN); return false; }
  touch_sensor_sample_config_t sc[1] = {TOUCH_SENSOR_V1_DEFAULT_SAMPLE_CONFIG(5.0f, TOUCH_VOLT_LIM_L_0V5, TOUCH_VOLT_LIM_H_1V7)};
  touch_sensor_config_t cfg = TOUCH_SENSOR_DEFAULT_BASIC_CONFIG(1, sc);
  cfg.meas_interval_us = 32.0f;                       // same timing the Arduino core uses
  touch_channel_config_t cc = {};
  cc.abs_active_thresh[0] = 1000;                     // unused here (no interrupts), must be set
  cc.charge_speed = TOUCH_CHARGE_SPEED_7;
  cc.init_charge_volt = TOUCH_INIT_CHARGE_VOLT_DEFAULT;
  cc.group = TOUCH_CHAN_TRIG_GROUP_BOTH;
  esp_err_t e = touch_sensor_new_controller(&cfg, &touchSens);
  if (e == ESP_OK) e = touch_sensor_new_channel(touchSens, ch, &cc, &touchChan);
  if (e == ESP_OK) e = touch_sensor_enable(touchSens);
  if (e == ESP_OK) e = touch_sensor_start_continuous_scanning(touchSens);
  if (e != ESP_OK) { Serial.printf("Touch: ESP-IDF touch driver failed to start (%s)\n", esp_err_to_name(e)); return false; }
  Serial.printf("Touch: core 4.x - ESP-IDF touch driver started directly on GPIO%d (channel T%d)\n", TOUCH_PIN, ch);
  delay(20);                                          // let the first measurements land
  return true;
}
#endif

static uint32_t readTouch() {
#if TOUCH_DIRECT
  if (!touchChan) {
    if (touchDirectFailed) return 0;
    if (!touchDirectStart()) { touchDirectFailed = true; return 0; }
  }
  uint32_t v = 0;
  touch_channel_read_data(touchChan, TOUCH_CHAN_DATA_TYPE_RAW, &v);
  return v;
#else
  return touchRead(TOUCH_PIN);
#endif
}

uint32_t lastHello = 0, lastFrame = 0, lastStatus = 0, statusUntil = 0;
int      lastLinked = -1, statusCount = 0;
char     cmdBuf[40];
uint8_t  cmdLen = 0;

const uint8_t BCAST[6] = {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF};

// ------------------------------ helpers ------------------------------
static int hexDist(int q1, int r1, int q2, int r2) {
  int dq = q1 - q2, dr = r1 - r2;
  return (abs(dq) + abs(dr) + abs(dq + dr)) / 2;
}

static void setPos(int q, int r) {
  myQ = (int8_t)q; myR = (int8_t)r;
  myPosKnown = (myQ != POS_UNKNOWN && myR != POS_UNKNOWN);
}

static void fillBase(Packet &p, uint8_t type) {
  memset(&p, 0, sizeof(p));
  p.magic = MAGIC;
  p.type = type;
  p.sender = myId;
  p.q = myQ; p.r = myR;
  p.originQ = POS_UNKNOWN; p.originR = POS_UNKNOWN;
}

static void sendNow(const Packet &p) {
  esp_now_send(BCAST, (const uint8_t *)&p, sizeof(p));
}

static void queueTx(const Packet &p, uint32_t delayMs) {
  for (int i = 0; i < TX_SLOTS; i++) {
    if (!txq[i].used) {
      txq[i].used = true;
      txq[i].at = millis() + delayMs;
      txq[i].p = p;
      return;
    }
  }
}

static void pumpTx(uint32_t now) {
  for (int i = 0; i < TX_SLOTS; i++) {
    if (txq[i].used && (int32_t)(now - txq[i].at) >= 0) {
      txq[i].used = false;
      sendNow(txq[i].p);
    }
  }
}

static bool seenBefore(uint32_t origin, uint16_t seq) {
  for (int i = 0; i < SEEN_SLOTS; i++)
    if (seen[i].origin == origin && seen[i].seq == seq) return true;
  return false;
}

static void markSeen(uint32_t origin, uint16_t seq) {
  seen[seenHead].origin = origin;
  seen[seenHead].seq = seq;
  seenHead = (seenHead + 1) % SEEN_SLOTS;
}

// --------------------------- neighbour table ---------------------------
static Neighbor *touchNeighbor(const Packet &p, int8_t rssi, uint32_t now) {
  Neighbor *slot = nullptr;
  for (int i = 0; i < MAX_NEIGHBORS; i++) {
    if (nbrs[i].used && nbrs[i].id == p.sender) {
      slot = &nbrs[i];
      slot->rssi = slot->rssi * 0.7f + rssi * 0.3f;
      break;
    }
  }
  if (!slot) {
    uint32_t oldest = 0xFFFFFFFF;
    for (int i = 0; i < MAX_NEIGHBORS; i++) {
      if (!nbrs[i].used) { slot = &nbrs[i]; break; }
      if (nbrs[i].lastSeen < oldest) { oldest = nbrs[i].lastSeen; slot = &nbrs[i]; }
    }
    slot->used = true;
    slot->id = p.sender;
    slot->rssi = rssi;
  }
  slot->q = p.q; slot->r = p.r;
  slot->lastSeen = now;
  return slot;
}

static bool isLinked(const Neighbor &n) {
  if (myPosKnown && n.q != POS_UNKNOWN && n.r != POS_UNKNOWN)
    return hexDist(myQ, myR, n.q, n.r) <= MAX_LINK_HEX_DIST;
  return n.rssi >= NEIGHBOR_RSSI_MIN;
}

static uint8_t stepCost(const Neighbor &n) {
  if (myPosKnown && n.q != POS_UNKNOWN && n.r != POS_UNKNOWN) {
    int d = hexDist(myQ, myR, n.q, n.r);
    return d < 1 ? 1 : d;
  }
  return 1;
}

static int countLinked(uint32_t now) {
  int c = 0;
  for (int i = 0; i < MAX_NEIGHBORS; i++) {
    if (!nbrs[i].used) continue;
    if (now - nbrs[i].lastSeen > NEIGHBOR_TIMEOUT) { nbrs[i].used = false; continue; }
    if (isLinked(nbrs[i])) c++;
  }
  return c;
}

// ------------------------------- waves -------------------------------
static void spawnWave(int8_t oq, int8_t orow, uint8_t dist, uint8_t hue, bool self) {
  Wave *w = nullptr;
  for (int i = 0; i < MAX_WAVES; i++) if (!waves[i].active) { w = &waves[i]; break; }
  if (!w) {
    w = &waves[0];
    for (int i = 1; i < MAX_WAVES; i++) if ((int32_t)(waves[i].start - w->start) < 0) w = &waves[i];
  }
  w->active = true;
  w->self = self;
  w->start = millis() + (uint32_t)dist * HOP_MS;
  w->gain = 1.0f - dist * 0.06f;
  if (w->gain < 0.25f) w->gain = 0.25f;
  w->hue = hue;
  w->radial = true;
  w->dx = w->dy = 0;
  if (!self && myPosKnown && oq != POS_UNKNOWN && orow != POS_UNKNOWN) {
    // direction from this module towards the origin (pointy-top axial layout, y points down)
    float dx = 1.7320508f * ((oq - myQ) + (orow - myR) * 0.5f);
    float dy = 1.5f * (orow - myR);
    float len = sqrtf(dx * dx + dy * dy);
    if (len > 0.01f) { w->radial = false; w->dx = dx / len; w->dy = dy / len; }
  }
}

static void handleWave(const Packet &p, const Neighbor &from) {
  if (seenBefore(p.origin, p.seq)) return;
  markSeen(p.origin, p.seq);
  uint16_t d = (uint16_t)p.dist + stepCost(from);
  if (d > MAX_WAVE_DIST) return;

  spawnWave(p.originQ, p.originR, (uint8_t)d, (uint8_t)(p.hue + d * HUE_PER_HOP), false);

  Packet f = p;
  f.sender = myId; f.q = myQ; f.r = myR;
  f.dist = (uint8_t)d;
  queueTx(f, 3 + (esp_random() % 9));      // small random delay avoids collisions
  queueTx(f, 18 + (esp_random() % 12));    // second copy: broadcasts have no ACK
}

static void triggerLocal() {
  Packet p;
  fillBase(p, PKT_WAVE);
  p.origin = myId;
  p.originQ = myQ; p.originR = myR;
  p.seq = ++mySeq;
  p.dist = 0;
  p.hue = (uint8_t)(millis() >> 5);        // hue drifts over time, so a sweep of waves looks like a gradient
  markSeen(p.origin, p.seq);
  spawnWave(myQ, myR, 0, p.hue, true);
  sendNow(p);
  queueTx(p, 15 + (esp_random() % 10));
}

static void handlePacket(const RxItem &it) {
  const Packet &p = it.p;
  if (p.sender == myId) return;
  Neighbor *n = touchNeighbor(p, it.rssi, millis());
  if (!isLinked(*n)) return;
  if (p.type == PKT_WAVE) handleWave(p, *n);
}

// ------------------------------ ESP-NOW ------------------------------
void onRecv(const esp_now_recv_info_t *info, const uint8_t *data, int len) {
  if (len != (int)sizeof(Packet)) return;
  RxItem it;
  memcpy(&it.p, data, sizeof(Packet));
  if (it.p.magic != MAGIC) return;
  it.rssi = info->rx_ctrl->rssi;
  xQueueSend(rxQueue, &it, 0);
}

static void radioStep(const char *s) {
  Serial.printf("radio: %s\n", s);
  Serial.flush();
  delay(GENTLE_RADIO_START ? 60 : 0);     // let the 3.3 V rail recover between steps
}

static void startRadio() {
  if (GENTLE_RADIO_START) {
    ring.clear(); ring.show();            // LEDs off while the radio powers up
    delay(50);
  }
  radioStep("wifi on");
  WiFi.mode(WIFI_STA);
  radioStep("tx power");
  esp_wifi_set_max_tx_power(TX_POWER_QDBM);   // as early as possible: lower TX bursts from here on
  WiFi.disconnect();
  esp_wifi_set_channel(ESPNOW_CHANNEL, WIFI_SECOND_CHAN_NONE);
  radioStep("esp-now");
  if (esp_now_init() != ESP_OK) {
    Serial.println("ESP-NOW init failed");
    return;
  }
  esp_now_register_recv_cb(onRecv);
  esp_now_peer_info_t peer;
  memset(&peer, 0, sizeof(peer));
  memcpy(peer.peer_addr, BCAST, 6);
  peer.channel = ESPNOW_CHANNEL;
  peer.encrypt = false;
  esp_now_add_peer(&peer);
  radioStep("ready");
}

static void sendHello(uint32_t now) {
  static uint32_t nextHello = 0;
  if ((int32_t)(now - nextHello) < 0) return;
  nextHello = now + HELLO_MS + (esp_random() % 300);
  Packet p;
  fillBase(p, PKT_HELLO);
  sendNow(p);
}

// -------------------------------- touch --------------------------------
static void calibrateTouch() {
  float sum = 0;
  const int N = 40;
  for (int i = 0; i < N; i++) {
    sum += readTouch();
    ring.clear();
    ring.setPixelColor(i % NUM_LEDS, ring.Color(60, 60, 60));
    ring.show();
    delay(25);
  }
  baseline = smoothed = sum / N;
  touched = false; onCount = 0;
  lastCal = millis();
  Serial.printf("Touch baseline: %.0f\n", baseline);
  if (baseline < 5) Serial.println("WARNING: touch reading near zero - check the wire is on the touch pin (will retry)");
}

static void pollTouch(uint32_t now) {
  if (now - lastTouchSample < 15) return;
  lastTouchSample = now;
  if (baseline < 5) {                       // no usable reading yet (driver still starting, or no wire)
    if (now - lastCal > 3000) calibrateTouch();
    return;
  }
  float raw = (float)readTouch();
  smoothed = smoothed * 0.5f + raw * 0.5f;
  float pct;                                 // % change in the "touched" direction
  if (touchDir < 0)      pct = 100.0f * (baseline - smoothed) / baseline;
  else if (touchDir > 0) pct = 100.0f * (smoothed - baseline) / baseline;
  else                   pct = 100.0f * fabsf(smoothed - baseline) / baseline;

  if (dbg && now - lastDbg > 150) {
    lastDbg = now;
    Serial.printf("raw=%.0f smooth=%.0f base=%.0f change=%.1f%% dir=%s %s\n", raw, smoothed, baseline, pct,
                  touchDir < 0 ? "drop" : touchDir > 0 ? "rise" : "?", touched ? "TOUCH" : "");
  }

  if (!touched) {
    if (pct >= touchOnPct) {
      if (++onCount >= 2 && now - lastFire >= TOUCH_COOLDOWN_MS) {
        touched = true; onCount = 0; lastFire = now;
        if (touchDir == 0) {
          touchDir = (smoothed < baseline) ? -1 : 1;
          Serial.printf("Touch direction learned: reading %s when touched\n", touchDir < 0 ? "drops" : "rises");
        }
        triggerLocal();
      }
    } else {
      onCount = 0;
      if (pct < touchOnPct * 0.5f) baseline += (smoothed - baseline) * 0.003f;  // slow drift tracking
    }
  } else {
    if (pct <= touchOffPct) touched = false;
    else if (now - lastFire >= HOLD_REPEAT_MS) { lastFire = now; triggerLocal(); }
  }
}

// ------------------------------ rendering ------------------------------
static inline float pulse(float t) {
  if (t < ATTACK_MS) return t / ATTACK_MS;
  float x = 1.0f - (t - ATTACK_MS) / (PULSE_MS - ATTACK_MS);
  return x * x;
}

static inline void addColor(int i, uint32_t c, float k) {
  fr[i] += ((c >> 16) & 0xFF) * k;
  fg[i] += ((c >> 8) & 0xFF) * k;
  fb[i] += (c & 0xFF) * k;
}

static void render(uint32_t now) {
  for (int i = 0; i < NUM_LEDS; i++) fr[i] = fg[i] = fb[i] = 0;

  // idle glow: slow, dim colour that depends on position
  uint16_t idleHue = (uint16_t)(((now / 40) + (myPosKnown ? myQ * 18 + myR * 11 : 0)) & 0xFF) << 8;
  uint32_t idleC = Adafruit_NeoPixel::ColorHSV(idleHue, 255, 255);
  for (int i = 0; i < NUM_LEDS; i++) {
    float v = 0.05f + 0.035f * sinf(now * 0.0011f + i * 0.4f);
    addColor(i, idleC, v);
  }

  // waves
  for (int k = 0; k < MAX_WAVES; k++) {
    Wave &w = waves[k];
    if (!w.active) continue;
    float tw = (float)(int32_t)(now - w.start);
    if (tw < 0) continue;
    if (tw > SWEEP_MS + PULSE_MS) { w.active = false; continue; }
    uint32_t c = Adafruit_NeoPixel::ColorHSV((uint16_t)w.hue << 8, 255, 255);
    for (int i = 0; i < NUM_LEDS; i++) {
      float delay = w.radial ? 0.0f : (1.0f - (ledX[i] * w.dx + ledY[i] * w.dy)) * 0.5f * SWEEP_MS;
      float t = tw - delay;
      if (t < 0 || t > PULSE_MS) continue;
      float v = pulse(t) * w.gain;
      addColor(i, c, v);
      if (w.self) { fr[i] += 255 * v * 0.35f; fg[i] += 255 * v * 0.35f; fb[i] += 255 * v * 0.35f; }
    }
  }

  // status overlay: after neighbour count changes, show that many green LEDs for 1.5 s
  bool status = (int32_t)(now - statusUntil) < 0;

  for (int i = 0; i < NUM_LEDS; i++) {
    if (status && i < statusCount) { ring.setPixelColor(i, ring.Color(0, 90, 0)); continue; }
    ring.setPixelColor(i, ring.Color(
      (uint8_t)min(255.0f, fr[i]), (uint8_t)min(255.0f, fg[i]), (uint8_t)min(255.0f, fb[i])));
  }
  ring.show();
}

static void updateStatus(uint32_t now) {
  if (now - lastStatus < 1000) return;
  lastStatus = now;
  int c = countLinked(now);
  if (c != lastLinked) {
    lastLinked = c;
    statusCount = c > NUM_LEDS ? NUM_LEDS : c;
    statusUntil = now + 1500;
    Serial.printf("Linked neighbours: %d\n", c);
  }
}

// ------------------------------- serial -------------------------------
static void printInfo() {
  uint32_t now = millis();
  Serial.printf("core: Arduino-ESP32 %d.%d.%d, ESP-IDF %s\n", ESP_ARDUINO_VERSION_MAJOR, ESP_ARDUINO_VERSION_MINOR,
                ESP_ARDUINO_VERSION_PATCH, esp_get_idf_version());
  Serial.printf("touch: on %.1f%%  off %.1f%%  baseline %.0f  direction %s\n", touchOnPct, touchOffPct, baseline,
                touchDir < 0 ? "drops" : touchDir > 0 ? "rises" : "not learned yet");
  Serial.printf("touch source: %s\n", TOUCH_DIRECT ? "ESP-IDF touch driver (core 4.x workaround)" : "touchRead()");
  Serial.printf("id=%08X  pos=", (unsigned)myId);
  if (myPosKnown) Serial.printf("(%d,%d)\n", myQ, myR); else Serial.println("unknown (RSSI mode)");
  for (int i = 0; i < MAX_NEIGHBORS; i++) {
    if (!nbrs[i].used) continue;
    Serial.printf("  %08X pos=(%d,%d) rssi=%.0f age=%lums %s\n", (unsigned)nbrs[i].id, nbrs[i].q, nbrs[i].r,
                  nbrs[i].rssi, (unsigned long)(now - nbrs[i].lastSeen), isLinked(nbrs[i]) ? "LINKED" : "");
  }
}

static void runCommand(char *s) {
  int q, r;
  if (sscanf(s, "pos %d %d", &q, &r) == 2) {
    setPos(q, r);
    prefs.putChar("q", myQ); prefs.putChar("r", myR);
    Serial.printf("Position set to (%d,%d)\n", myQ, myR);
  } else if (strncmp(s, "pos auto", 8) == 0) {
    setPos(POS_UNKNOWN, POS_UNKNOWN);
    prefs.putChar("q", POS_UNKNOWN); prefs.putChar("r", POS_UNKNOWN);
    Serial.println("Position cleared - using signal strength");
  } else if (strncmp(s, "sens", 4) == 0) {
    float on, off;
    int n = sscanf(s, "sens %f %f", &on, &off);
    if (n >= 1) {
      if (n < 2) off = on * 0.5f;
      if (on < 1.0f || on > 95.0f || off <= 0.0f || off >= on) {
        Serial.println("sens: use 1-95 for the touch level, release lower than touch (e.g. sens 30 or sens 30 12)");
        return;
      }
      touchOnPct = on; touchOffPct = off;
      prefs.putFloat("son", on); prefs.putFloat("soff", off);
      touched = false; onCount = 0;
    }
    Serial.printf("Touch: on at %.1f%% change, release at %.1f%% (higher = less sensitive)\n", touchOnPct, touchOffPct);
  } else if (strncmp(s, "cal", 3) == 0) {
    Serial.println("Recalibrating - hands off the touch wire");
    touchDir = 0;
    calibrateTouch();
  } else if (strncmp(s, "dbg", 3) == 0) {
    dbg = !dbg;
  } else if (strncmp(s, "test", 4) == 0) {
    triggerLocal();
  } else if (strncmp(s, "info", 4) == 0) {
    printInfo();
  } else {
    Serial.println("Commands: pos <q> <r> | pos auto | sens <on%> [off%] | cal | test | dbg | info");
  }
}

static void readSerial() {
  while (Serial.available()) {
    char c = (char)Serial.read();
    if (c == '\n' || c == '\r') {
      if (cmdLen) { cmdBuf[cmdLen] = 0; runCommand(cmdBuf); cmdLen = 0; }
    } else if (cmdLen < sizeof(cmdBuf) - 1) {
      cmdBuf[cmdLen++] = c;
    }
  }
}

// -------------------------------- setup --------------------------------
void setup() {
#if DISABLE_BROWNOUT
  WRITE_PERI_REG(RTC_CNTL_BROWN_OUT_REG, 0);   // must run before the radio starts
#endif
  Serial.begin(115200);
  delay(200);
  if (CPU_MHZ != 240) setCpuFrequencyMhz(CPU_MHZ);
  if (DISABLE_BROWNOUT) Serial.println("\nNOTE: brownout detector disabled (DISABLE_BROWNOUT = 1)");
  Serial.printf("CPU %lu MHz, gentle radio start %s\n", (unsigned long)getCpuFrequencyMhz(), GENTLE_RADIO_START ? "on" : "off");

  uint64_t mac = ESP.getEfuseMac();
  myId = (uint32_t)(mac >> 16) ^ (uint32_t)(mac << 16);
  mySeq = (uint16_t)(esp_random() & 0xFFFF);

  prefs.begin("hexnode", false);
  setPos(prefs.getChar("q", DEFAULT_Q), prefs.getChar("r", DEFAULT_R));
  touchOnPct = prefs.getFloat("son", TOUCH_ON_PCT);
  touchOffPct = prefs.getFloat("soff", TOUCH_OFF_PCT);

  for (int i = 0; i < NUM_LEDS; i++) {
    float a = (RING_ROTATION_DEG + 360.0f * i / NUM_LEDS * (RING_CLOCKWISE ? 1.0f : -1.0f)) * DEG_TO_RAD;
    ledX[i] = sinf(a);
    ledY[i] = -cosf(a);       // y points down the wall, LED 0 at the top
  }

  ring.begin();
  ring.setBrightness(BRIGHTNESS);
  ring.clear();
  ring.show();

  Serial.println("\nHexNode starting - keep hands off the touch wire for calibration");
  calibrateTouch();

  rxQueue = xQueueCreate(24, sizeof(RxItem));
  startRadio();
  printInfo();
  Serial.println("Commands: pos <q> <r> | pos auto | sens <on%> [off%] | cal | test | dbg | info");
}

void loop() {
  uint32_t now = millis();

  RxItem it;
  while (xQueueReceive(rxQueue, &it, 0) == pdTRUE) handlePacket(it);

  pollTouch(now);
  sendHello(now);
  pumpTx(now);
  updateStatus(now);
  readSerial();

  if (now - lastFrame >= 16) {
    lastFrame = now;
    render(now);
  }
  delay(1);
}
