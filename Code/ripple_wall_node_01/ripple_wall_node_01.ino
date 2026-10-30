/*
  Ripple Wall Node  --  ESP32 + 16x WS2812B ring + touch wire
  Same firmware on every module. Mesh = ESP-NOW broadcast (no router needed).

  Libraries: Adafruit NeoPixel.  Board package: esp32 by Espressif 3.x
  (the receive callback uses the 3.x signature, which also gives RSSI).

  Wiring: WS2812B DIN -> GPIO5 (330R in series), 5V/GND from the power bank
          Touch wire  -> GPIO4 (T0)
          ESP32 powered from the same bank (5V pin / USB)

  Position (hex grid, axial coords q,r) is stored in flash. Set it over serial
  (115200) so every node can run identical firmware:
     POS <q> <r> [rot]   e.g.  POS 2 -1 4   (rot = which LED faces +x, 0..15)
     NEIGH               list discovered neighbours
     CLEAR               forget position (falls back to RSSI distance)

  Axial hex coords: neighbours of (q,r) are
     (q+1,r) (q-1,r) (q,r+1) (q,r-1) (q+1,r-1) (q-1,r+1)
*/
#include <WiFi.h>
#include <esp_now.h>
#include <esp_wifi.h>
#include <Preferences.h>
#include <Adafruit_NeoPixel.h>

// ---------- config ----------
#define LED_PIN        5
#define NUM_LEDS       16
#define TOUCH_PIN      4
#define BRIGHTNESS     60        // keep low: 16 LEDs full white ~1 A
#define ESPNOW_CH      1
#define RADIUS         4         // ripple reaches this many hex steps
#define HOP_DELAY_MS   170       // wave speed: delay per hex step
#define SWEEP_MS       650       // time for the arc to cross a ring
#define RIPPLE_MS      1300      // total life of one ripple on a node
#define TOUCH_DROP     0.22f     // fractional drop vs baseline = touch
#define COOLDOWN_MS    220       // min time between triggers
#define DIR_SIGN       1         // set -1 if your ring winds the other way
#define RSSI_NEAR      -35.0f    // fallback mode: RSSI of "adjacent"
#define RSSI_PER_HOP   7.0f      // fallback mode: dB lost per hop (calibrate)
#define MAX_RIP        10
#define MAX_NEIGH      24
#define MAGIC          0xA7

enum { T_BEACON = 0, T_RIPPLE = 1 };

struct __attribute__((packed)) Pkt {
  uint8_t magic, type;
  uint16_t id, seq;
  int8_t q, r;
  uint8_t hasPos, hue, strength;
};

struct Neigh { bool used; uint16_t id; int8_t q, r; uint8_t hasPos; float rssi; uint32_t seen; };
struct Ripple { bool on; uint32_t t0; uint8_t hue; float amp; int face; };
struct Rx { Pkt p; int rssi; };

Adafruit_NeoPixel strip(NUM_LEDS, LED_PIN, NEO_GRB + NEO_KHZ800);
Preferences prefs;
const uint8_t BCAST[6] = {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF};

uint16_t myId, mySeq = 0;
bool havePos = false; int8_t myQ = 0, myR = 0; uint8_t myRot = 0;
Neigh neigh[MAX_NEIGH];
Ripple rip[MAX_RIP];

// RX queue filled in WiFi task, drained in loop()
#define RXQ 16
volatile uint8_t rxHead = 0, rxTail = 0;
Rx rxq[RXQ];

// ---------- mesh ----------
void onRecv(const esp_now_recv_info_t* info, const uint8_t* data, int len) {
  if (len != sizeof(Pkt)) return;
  uint8_t next = (rxHead + 1) % RXQ;
  if (next == rxTail) return;  // full, drop
  memcpy(&rxq[rxHead].p, data, sizeof(Pkt));
  rxq[rxHead].rssi = info->rx_ctrl->rssi;
  rxHead = next;
}

void sendPkt(uint8_t type, uint8_t hue = 0, uint8_t strength = 0) {
  Pkt p = { MAGIC, type, myId, mySeq++, myQ, myR, (uint8_t)havePos, hue, strength };
  esp_now_send(BCAST, (uint8_t*)&p, sizeof(p));
}

void updateNeighbor(const Pkt& p, int rssi) {
  int slot = -1, oldest = 0;
  for (int i = 0; i < MAX_NEIGH; i++) {
    if (neigh[i].used && neigh[i].id == p.id) { slot = i; break; }
    if (!neigh[i].used) { slot = i; break; }
    if (neigh[i].seen < neigh[oldest].seen) oldest = i;
  }
  if (slot < 0) slot = oldest;
  Neigh& n = neigh[slot];
  n.rssi = (n.used && n.id == p.id) ? 0.7f * n.rssi + 0.3f * rssi : (float)rssi;
  n.used = true; n.id = p.id; n.q = p.q; n.r = p.r; n.hasPos = p.hasPos; n.seen = millis();
}

float smoothedRssi(uint16_t id, int fallback) {
  for (int i = 0; i < MAX_NEIGH; i++) if (neigh[i].used && neigh[i].id == id) return neigh[i].rssi;
  return fallback;
}

int hexDist(int dq, int dr) { return (abs(dq) + abs(dq + dr) + abs(dr)) / 2; }

// ---------- ripples ----------
void addRipple(uint32_t delayMs, uint8_t hue, float amp, int face) {
  int slot = 0;
  for (int i = 0; i < MAX_RIP; i++) {
    if (!rip[i].on) { slot = i; break; }
    if (rip[i].t0 < rip[slot].t0) slot = i;
  }
  rip[slot] = { true, millis() + delayMs, hue, amp, face };
}

void handlePkt(const Pkt& p, int rssi) {
  if (p.magic != MAGIC || p.id == myId) return;
  updateNeighbor(p, rssi);
  if (p.type != T_RIPPLE) return;

  float dist; int face = -1;
  if (havePos && p.hasPos) {
    int dq = p.q - myQ, dr = p.r - myR;
    dist = hexDist(dq, dr);
    if (dist < 1) dist = 1;
    if (dist > RADIUS) return;
    float x = 1.7320508f * (dq + dr * 0.5f), y = 1.5f * dr;
    float ang = atan2f(y, x) * 180.0f / PI;
    if (ang < 0) ang += 360.0f;
    face = ((int)roundf(ang / (360.0f / NUM_LEDS)) * DIR_SIGN + myRot + NUM_LEDS * 2) % NUM_LEDS;
  } else {
    float rs = smoothedRssi(p.id, rssi);
    dist = constrain((RSSI_NEAR - rs) / RSSI_PER_HOP, 1.0f, RADIUS + 1.0f);
    if (dist > RADIUS) return;
  }
  float amp = (p.strength / 255.0f) * (1.0f - dist / (RADIUS + 1.0f));
  addRipple((uint32_t)(dist * HOP_DELAY_MS), p.hue, amp, face);
}

void render() {
  static float R[NUM_LEDS], G[NUM_LEDS], B[NUM_LEDS];
  uint32_t now = millis();
  float breath = 3.0f + 2.0f * sinf(now / 900.0f);  // faint idle glow
  for (int i = 0; i < NUM_LEDS; i++) { R[i] = 0; G[i] = breath * 0.3f; B[i] = breath; }

  for (int k = 0; k < MAX_RIP; k++) {
    Ripple& r = rip[k];
    if (!r.on || now < r.t0) continue;
    uint32_t age = now - r.t0;
    if (age > RIPPLE_MS) { r.on = false; continue; }
    float fade = 1.0f - (float)age / RIPPLE_MS;
    uint32_t c = strip.ColorHSV((uint16_t)r.hue << 8, 255, 255);
    float cr = (c >> 16) & 0xFF, cg = (c >> 8) & 0xFF, cb = c & 0xFF;
    float front = (float)age / SWEEP_MS * (NUM_LEDS / 2);
    for (int i = 0; i < NUM_LEDS; i++) {
      float v;
      if (r.face >= 0) {  // arc travels from the side facing the origin to the far side
        int d = abs(i - r.face); d = min(d, NUM_LEDS - d);
        float e = d - front;
        v = expf(-e * e / (2 * 1.6f * 1.6f)) * fade;
      } else {            // origin node: whole ring blooms
        float rise = age < 100 ? age / 100.0f : 1.0f;
        v = rise * fade * fade;
      }
      v *= r.amp;
      R[i] += cr * v; G[i] += cg * v; B[i] += cb * v;
    }
  }
  for (int i = 0; i < NUM_LEDS; i++)
    strip.setPixelColor(i, strip.gamma32(strip.Color(min(R[i], 255.f), min(G[i], 255.f), min(B[i], 255.f))));
  strip.show();
}

// ---------- touch ----------
void pollTouch() {
  static float base = 0; static uint8_t hits = 0; static uint32_t last = 0;
  float v = touchRead(TOUCH_PIN);  // classic ESP32: value DROPS when touched. (S2/S3 rises: flip logic.)
  if (base == 0) base = v;
  float drop = (base - v) / base;
  if (drop > TOUCH_DROP) {
    if (++hits >= 2 && millis() - last > COOLDOWN_MS) {
      last = millis(); hits = 0;
      uint8_t hue = esp_random() & 0xFF;
      float s = constrain(drop * 2.0f, 0.5f, 1.0f);
      addRipple(0, hue, s, -1);
      sendPkt(T_RIPPLE, hue, (uint8_t)(s * 255));
    }
  } else {
    hits = 0;
    base = base * 0.98f + v * 0.02f;  // track slow drift (power bank, humidity)
  }
}

// ---------- serial config ----------
void handleSerial() {
  if (!Serial.available()) return;
  String l = Serial.readStringUntil('\n'); l.trim();
  if (l.startsWith("POS ")) {
    int q, r, rot = 0;
    if (sscanf(l.c_str() + 4, "%d %d %d", &q, &r, &rot) >= 2) {
      myQ = q; myR = r; myRot = rot & 15; havePos = true;
      prefs.putChar("q", myQ); prefs.putChar("r", myR); prefs.putUChar("rot", myRot); prefs.putBool("pos", true);
      Serial.printf("pos set q=%d r=%d rot=%d\n", myQ, myR, myRot);
    }
  } else if (l == "CLEAR") {
    havePos = false; prefs.putBool("pos", false); Serial.println("pos cleared");
  } else if (l == "NEIGH") {
    Serial.printf("me id=%04x pos=%d (%d,%d)\n", myId, havePos, myQ, myR);
    for (int i = 0; i < MAX_NEIGH; i++) if (neigh[i].used)
      Serial.printf(" %04x (%d,%d) pos=%d rssi=%.0f age=%lums\n", neigh[i].id, neigh[i].q, neigh[i].r,
                    neigh[i].hasPos, neigh[i].rssi, millis() - neigh[i].seen);
  }
}

void setup() {
  Serial.begin(115200);
  strip.begin(); strip.setBrightness(BRIGHTNESS); strip.show();
  myId = (uint16_t)(ESP.getEfuseMac() >> 32);
  prefs.begin("wall", false);
  havePos = prefs.getBool("pos", false);
  myQ = prefs.getChar("q", 0); myR = prefs.getChar("r", 0); myRot = prefs.getUChar("rot", 0);

  WiFi.mode(WIFI_STA); WiFi.disconnect();
  esp_wifi_set_channel(ESPNOW_CH, WIFI_SECOND_CHAN_NONE);
  if (esp_now_init() != ESP_OK) { Serial.println("ESP-NOW init failed"); while (true) delay(1000); }
  esp_now_peer_info_t peer = {};
  memcpy(peer.peer_addr, BCAST, 6); peer.channel = 0; peer.encrypt = false;
  esp_now_add_peer(&peer);
  esp_now_register_recv_cb(onRecv);
  Serial.printf("node %04x ready, pos=%d\n", myId, havePos);
}

void loop() {
  static uint32_t lastBeacon = 0, nextBeaconIn = 1000, lastFrame = 0;
  uint32_t now = millis();

  while (rxTail != rxHead) {
    Rx m = rxq[rxTail]; rxTail = (rxTail + 1) % RXQ;
    handlePkt(m.p, m.rssi);
  }
  pollTouch();
  handleSerial();

  if (now - lastBeacon > nextBeaconIn) {
    lastBeacon = now; nextBeaconIn = 2000 + (esp_random() % 600);
    sendPkt(T_BEACON);
  }
  if (now - lastFrame >= 16) { lastFrame = now; render(); }
}
