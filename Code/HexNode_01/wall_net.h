/*
  wall_net.h - Wi-Fi, status reports and over-the-air updates for HexNode.

  The laptop server (ota_server.py) broadcasts "HEXNODE ver=<N> port=<P>[ only=<ids>]"
  on UDP 4211 every 2 s; "only=" limits a new release to its test batch. A board whose
  FW_VERSION is lower (and is in the batch, if any) waits a random 0.5-20 s (so 100 boards
  don't hit the laptop at once), downloads http://<server>:<P>/firmware.bin, installs
  it into the spare app slot and reboots. Every 5 s each board sends a one-line status
  to the server on UDP 4212 for the status page.

  Wi-Fi details come from secrets.h (gitignored). Without it the board runs offline
  exactly as before: ESP-NOW only, no updates.
*/
#pragma once
#include <WiFi.h>
#include <WiFiUdp.h>
#include <HTTPUpdate.h>
#include <esp_now.h>
#include "version.h"
#if __has_include("secrets.h")
#include "secrets.h"
#endif
#ifndef WIFI_SSID
#define WIFI_SSID ""
#define WIFI_PASS ""
#endif

namespace wallnet {

constexpr uint16_t BEACON_PORT     = 4211;   // server -> boards
constexpr uint16_t REPORT_PORT     = 4212;   // boards -> server
constexpr uint32_t JOIN_TIMEOUT_MS = 12000;
constexpr uint32_t REPORT_MS       = 5000;
constexpr uint32_t MAX_SPREAD_MS   = 20000;  // random delay before downloading an update
constexpr int      HTTP_TIMEOUT_MS = 30000;  // per read; the library default (8 s) is too short on busy Wi-Fi

static WiFiUDP    udp;
static HTTPUpdate updater(HTTP_TIMEOUT_MS);
static IPAddress server;
static uint16_t  httpPort   = 0;
static bool      haveServer = false;
static uint32_t  updateAt   = 0;             // 0 = no update scheduled
static uint32_t  lastReport = 0;

inline bool online() { return WiFi.status() == WL_CONNECTED; }

// Joins the Wi-Fi in secrets.h. Returns its channel, or 0 when running offline.
inline uint8_t begin() {
  if (!WIFI_SSID[0]) {
    Serial.println("Wi-Fi: no secrets.h, running offline");
    return 0;
  }
  WiFi.setAutoReconnect(true);
  WiFi.begin(WIFI_SSID, WIFI_PASS);
  uint32_t t0 = millis();
  while (!online() && millis() - t0 < JOIN_TIMEOUT_MS) delay(100);
  if (!online()) {
    // stop it scanning other channels, which would break ESP-NOW
    WiFi.setAutoReconnect(false);
    WiFi.disconnect();
    Serial.printf("Wi-Fi: could not join \"%s\", running offline\n", WIFI_SSID);
    return 0;
  }
  WiFi.setSleep(false);   // modem power-save makes a 1 MB download crawl and time out
  udp.begin(BEACON_PORT);
  Serial.printf("Wi-Fi: \"%s\" ip %s channel %d signal %d dBm, firmware v%d\n", WIFI_SSID,
                WiFi.localIP().toString().c_str(), WiFi.channel(), WiFi.RSSI(), FW_VERSION);
  return WiFi.channel();
}

// Call every loop. `id` is this board's id (to match the test-batch list), `status`
// is sent to the server, `showUpdating` paints the ring before the blocking
// (up to ~1 min) download starts.
inline void loop(uint32_t now, uint32_t id, const char *status, void (*showUpdating)()) {
  if (!online()) return;

  for (int n = udp.parsePacket(); n > 0; n = udp.parsePacket()) {
    char buf[200];
    int len = udp.read(buf, sizeof(buf) - 1);
    buf[len > 0 ? len : 0] = 0;
    int ver, port;
    if (sscanf(buf, "HEXNODE ver=%d port=%d", &ver, &port) != 2) continue;
    if (!haveServer) Serial.printf("Update server found at %s\n", udp.remoteIP().toString().c_str());
    server = udp.remoteIP();
    httpPort = (uint16_t)port;
    haveServer = true;
    // "only=ID1,ID2,..." = release is still on its test batch; everyone else waits
    const char *only = strstr(buf, "only=");
    if (only) {
      char me[9];
      snprintf(me, sizeof(me), "%08X", (unsigned)id);
      if (!strstr(only, me)) continue;
    }
    if (ver > FW_VERSION && !updateAt) {
      uint32_t wait = 500 + esp_random() % MAX_SPREAD_MS;
      updateAt = now + wait;
      if (!updateAt) updateAt = 1;
      Serial.printf("Server has v%d (I'm v%d): updating in %lu s\n", ver, FW_VERSION, (unsigned long)(wait / 1000));
    }
  }

  if (haveServer && now - lastReport >= REPORT_MS) {
    lastReport = now;
    udp.beginPacket(server, REPORT_PORT);
    udp.print(status);
    udp.endPacket();
  }

  if (updateAt && (int32_t)(now - updateAt) >= 0) {
    updateAt = 0;
    showUpdating();
    String url = "http://" + server.toString() + ":" + String(httpPort) + "/firmware.bin";
    Serial.printf("Downloading %s\n", url.c_str());
    WiFiClient client;
    client.setTimeout(HTTP_TIMEOUT_MS / 1000);
    // Reboot ourselves after a clean radio shutdown, rather than mid-ESP-NOW.
    // A busy server (download queue full) answers 503; we just retry on a later beacon.
    updater.rebootOnUpdate(false);
    updater.onProgress([](int done, int total) {
      static int lastPct = -1;
      int pct = total > 0 ? done * 100 / total : 0;
      if (pct / 10 != lastPct / 10) { lastPct = pct; Serial.printf("  update %d%%\n", pct); }
    });
    uint32_t t0 = millis();
    if (updater.update(client, url) == HTTP_UPDATE_OK) {
      Serial.printf("Update installed in %lu ms, rebooting\n", (unsigned long)(millis() - t0));
      Serial.flush();
      esp_now_deinit();
      WiFi.disconnect(true);
      WiFi.mode(WIFI_OFF);
      delay(200);
      ESP.restart();
    }
    Serial.printf("Update failed after %lu ms: %s (will retry on the next beacon)\n",
                  (unsigned long)(millis() - t0), updater.getLastErrorString().c_str());
  }
}

}  // namespace wallnet
