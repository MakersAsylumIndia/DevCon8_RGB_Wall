/*
  HexNode - one module of an interactive light wall
  ---------------------------------------------------
  Hardware : ESP32 DevKit (classic), WS2812B ring x16, bare wire on a touch pin
  Core     : Arduino-ESP32 3.x   (Boards Manager -> "esp32 by Espressif" 3.0.0 or newer)
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
      ring        flash the whole ring red, green, blue (wiring check)
      dbg         toggle live touch readings (use this to tune TOUCH_ON_PCT)
      info        print id, position and neighbour table
*/

#include <Arduino.h>
#include <WiFi.h>
#include <esp_now.h>
#include <esp_wifi.h>
#include <Preferences.h>
#include <Adafruit_NeoPixel.h>
#include <math.h>
#include <string.h>
#include "wall_net.h"   // Wi-Fi + over-the-air updates (offline without secrets.h)

// ============================ USER SETTINGS ============================
#define LED_PIN          15     // D13: data to ring DIN (through 330 ohm), next to GND and VIN on the header
#define NUM_LEDS         16
#define TOUCH_PIN        13      // T0 on classic ESP32
#define STATUS_LED       2      // onboard blue LED on DevKit V1: on while touched (tests boards with no ring)
#define BRIGHTNESS       90     // 0-255, keeps a USB power bank happy

constexpr int8_t  POS_UNKNOWN        = 127;
constexpr int8_t  DEFAULT_Q          = POS_UNKNOWN;  // used until you type "pos q r"
constexpr int8_t  DEFAULT_R          = POS_UNKNOWN;
constexpr int     MAX_LINK_HEX_DIST  = 2;     // 1 = strict neighbours; 2 = can hop over a missing module
constexpr int     NEIGHBOR_RSSI_MIN  = -55;   // dBm, only used when positions are unknown
constexpr int8_t  TX_POWER_QDBM      = 20;    // 20 = 5 dBm (units of 0.25 dBm); lower = better RSSI separation
constexpr int8_t  TX_POWER_WIFI_QDBM = 60;    // 15 dBm when on Wi-Fi, so the router hears every board

constexpr uint8_t ESPNOW_CHANNEL     = 1;
constexpr uint32_t HELLO_MS          = 1000;
constexpr uint32_t NEIGHBOR_TIMEOUT  = 5000;

constexpr float   TOUCH_ON_PCT       = 18.0f; // % change from baseline that counts as touch / hand nearby
constexpr float   TOUCH_OFF_PCT      = 9.0f;
constexpr uint32_t TOUCH_COOLDOWN_MS = 250;   // min time between two waves from one module
constexpr uint32_t HOLD_REPEAT_MS    = 0;     // while held, fire again this often (0 = one wave per touch)
constexpr uint32_t TOUCH_STUCK_MS    = 3000;  // "touched" longer than this = stuck reading, re-baseline

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
uint32_t lastFire = 0, lastTouchSample = 0, lastDbg = 0;
#if defined(CONFIG_IDF_TARGET_ESP32)
constexpr bool TOUCH_RISES = false;   // classic ESP32: reading drops when touched
#else
constexpr bool TOUCH_RISES = true;    // S2/S3: reading rises (re-tune TOUCH_ON_PCT, usually much smaller)
#endif

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

static void startRadio() {
  WiFi.mode(WIFI_STA);
  // On Wi-Fi the radio is locked to the router's channel; ESP-NOW then shares it.
  uint8_t wifiChannel = wallnet::begin();
  if (!wifiChannel) {
    WiFi.disconnect();
    esp_wifi_set_channel(ESPNOW_CHANNEL, WIFI_SECOND_CHAN_NONE);
  }
  esp_wifi_set_max_tx_power(wifiChannel ? TX_POWER_WIFI_QDBM : TX_POWER_QDBM);
  if (esp_now_init() != ESP_OK) {
    Serial.println("ESP-NOW init failed");
    return;
  }
  esp_now_register_recv_cb(onRecv);
  esp_now_peer_info_t peer;
  memset(&peer, 0, sizeof(peer));
  memcpy(peer.peer_addr, BCAST, 6);
  peer.channel = 0;   // 0 = whatever channel the radio is on (Wi-Fi's, or ESPNOW_CHANNEL offline)
  peer.encrypt = false;
  esp_now_add_peer(&peer);
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
// whole ring red, green, blue - quick check that the ring is wired (harmless with no ring)
static void ringSelfTest() {
  const uint32_t colors[] = { ring.Color(255, 0, 0), ring.Color(0, 255, 0), ring.Color(0, 0, 255) };
  for (uint32_t c : colors) {
    ring.fill(c);
    ring.show();
    delay(400);
  }
  ring.clear();
  ring.show();
}

// solid dim blue while an over-the-air update downloads (the loop is blocked meanwhile)
static void showUpdating() {
  ring.fill(ring.Color(0, 0, 80));
  ring.show();
}

static void calibrateTouch() {
  float sum = 0;
  const int N = 40;
  for (int i = 0; i < N; i++) {
    sum += touchRead(TOUCH_PIN);
    ring.clear();
    ring.setPixelColor(i % NUM_LEDS, ring.Color(60, 60, 60));
    ring.show();
    delay(25);
  }
  baseline = smoothed = sum / N;
  Serial.printf("Touch baseline: %.0f\n", baseline);
  if (baseline < 5) Serial.println("WARNING: touch reading near zero - check the wire is on the touch pin");
}

static void pollTouch(uint32_t now) {
  if (now - lastTouchSample < 15) return;
  lastTouchSample = now;
  float raw = (float)touchRead(TOUCH_PIN);
  smoothed = smoothed * 0.5f + raw * 0.5f;
  float delta = TOUCH_RISES ? (smoothed - baseline) : (baseline - smoothed);
  float pct = 100.0f * delta / baseline;

  if (dbg && now - lastDbg > 150) {
    lastDbg = now;
    Serial.printf("raw=%.0f smooth=%.0f base=%.0f change=%.1f%% %s\n", raw, smoothed, baseline, pct, touched ? "TOUCH" : "");
  }

  if (!touched) {
    if (pct >= TOUCH_ON_PCT) {
      if (++onCount >= 2 && now - lastFire >= TOUCH_COOLDOWN_MS) {
        touched = true; onCount = 0; lastFire = now;
        triggerLocal();
      }
    } else {
      onCount = 0;
      if (pct < TOUCH_ON_PCT * 0.5f) baseline += (smoothed - baseline) * 0.003f;  // slow drift tracking
    }
  } else {
    if (pct <= TOUCH_OFF_PCT) touched = false;
    else if (now - lastFire >= TOUCH_STUCK_MS) { baseline = smoothed; touched = false; }
    else if (HOLD_REPEAT_MS && now - lastFire >= HOLD_REPEAT_MS) { lastFire = now; triggerLocal(); }
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

  // whole ring glows white while D13 is touched, goes away on release
  if (touched)
    for (int i = 0; i < NUM_LEDS; i++) { fr[i] += 160; fg[i] += 160; fb[i] += 160; }

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
  Serial.printf("id=%08X  pos=", (unsigned)myId);
  if (myPosKnown) Serial.printf("(%d,%d)\n", myQ, myR); else Serial.println("unknown (RSSI mode)");
  if (wallnet::online())
    Serial.printf("  firmware v%d  wifi ip %s channel %d signal %d dBm\n", FW_VERSION,
                  WiFi.localIP().toString().c_str(), WiFi.channel(), WiFi.RSSI());
  else
    Serial.printf("  firmware v%d  wifi offline\n", FW_VERSION);
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
  } else if (strncmp(s, "dbg", 3) == 0) {
    dbg = !dbg;
  } else if (strncmp(s, "test", 4) == 0) {
    triggerLocal();
  } else if (strncmp(s, "info", 4) == 0) {
    printInfo();
  } else if (strncmp(s, "ring", 4) == 0) {
    ringSelfTest();
  } else {
    Serial.println("Commands: pos <q> <r> | pos auto | test | ring | dbg | info");
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
  Serial.begin(115200);
  delay(200);
  pinMode(STATUS_LED, OUTPUT);
  digitalWrite(STATUS_LED, LOW);

  uint64_t mac = ESP.getEfuseMac();
  myId = (uint32_t)(mac >> 16) ^ (uint32_t)(mac << 16);
  mySeq = (uint16_t)(esp_random() & 0xFFFF);

  prefs.begin("hexnode", false);
  setPos(prefs.getChar("q", DEFAULT_Q), prefs.getChar("r", DEFAULT_R));

  for (int i = 0; i < NUM_LEDS; i++) {
    float a = (RING_ROTATION_DEG + 360.0f * i / NUM_LEDS * (RING_CLOCKWISE ? 1.0f : -1.0f)) * DEG_TO_RAD;
    ledX[i] = sinf(a);
    ledY[i] = -cosf(a);       // y points down the wall, LED 0 at the top
  }

  ring.begin();
  ring.setBrightness(BRIGHTNESS);
  ring.clear();
  ring.show();
  ringSelfTest();

  Serial.println("\nHexNode starting - keep hands off the touch wire for calibration");
  calibrateTouch();

  rxQueue = xQueueCreate(24, sizeof(RxItem));
  startRadio();
  printInfo();
  Serial.println("Commands: pos <q> <r> | pos auto | test | ring | dbg | info");
}

void loop() {
  uint32_t now = millis();

  RxItem it;
  while (xQueueReceive(rxQueue, &it, 0) == pdTRUE) handlePacket(it);

  pollTouch(now);
  digitalWrite(STATUS_LED, touched ? HIGH : LOW);
  sendHello(now);
  pumpTx(now);
  updateStatus(now);
  readSerial();

  static char netStatus[160];
  static uint32_t lastNetStatus = 0;
  if (now - lastNetStatus >= 1000) {
    lastNetStatus = now;
    char pos[16];
    if (myPosKnown) snprintf(pos, sizeof(pos), "%d,%d", myQ, myR); else strcpy(pos, "-");
    snprintf(netStatus, sizeof(netStatus), "id=%08X ver=%d pos=%s rssi=%d links=%d touch=%d up=%lu",
             (unsigned)myId, FW_VERSION, pos, (int)WiFi.RSSI(), countLinked(now), touched ? 1 : 0,
             (unsigned long)(now / 1000));
  }
  wallnet::loop(now, myId, netStatus, showUpdating);

  if (now - lastFrame >= 16) {
    lastFrame = now;
    render(now);
  }
  delay(1);
}
