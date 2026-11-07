/*
  wall_net.h - Wi-Fi, status reports, remote commands and over-the-air updates for HexNode.

  The laptop server (ota_server.py) broadcasts "HEXNODE ver=<N> port=<P>[ only=<ids>]"
  on UDP 4211 every 2 s; "only=" limits a new release to its test batch. A board whose
  FW_VERSION is lower (and is in the batch, if any) waits a random 0.5-20 s (so 100 boards
  don't hit the laptop at once), downloads http://<server>:<P>/firmware.bin, installs
  it into the spare app slot and reboots. Every 5 s each board sends a one-line status
  to the server on UDP 4212 for the status page.

  Remote commands arrive on the same port as "HEXCMD <id|all> <cmd>"; only the harmless
  commands in REMOTE_CMDS are passed on to the sketch.

  A board that can't join at power-on keeps running offline (ESP-NOW only) and tries the
  Wi-Fi again every RETRY_MS. Wi-Fi details come from secrets.h (gitignored); without it
  the board stays offline exactly as before.
*/
#pragma once
#include <WiFi.h>
#include <WiFiUdp.h>
#include <HTTPUpdate.h>
#include <esp_now.h>
#include <esp_wifi.h>
#include "version.h"
#if __has_include("secrets.h")
#include "secrets.h"
#endif
#ifndef WIFI_SSID
#define WIFI_SSID ""
#define WIFI_PASS ""
#endif

namespace wallnet {

constexpr uint16_t BEACON_PORT     = 4211;   // server -> boards (beacons and commands)
constexpr uint16_t REPORT_PORT     = 4212;   // boards -> server
constexpr uint32_t JOIN_TIMEOUT_MS = 12000;
constexpr uint32_t RETRY_MS        = 60000;  // offline: try the Wi-Fi again this often
constexpr uint32_t REPORT_MS       = 5000;
constexpr uint32_t MAX_SPREAD_MS   = 20000;  // random delay before downloading an update
constexpr int      HTTP_TIMEOUT_MS = 30000;  // per read; the library default (8 s) is too short on busy Wi-Fi
constexpr int8_t   WIFI_TX_QDBM    = 60;     // 15 dBm on Wi-Fi, so the router hears every board
static const char *const REMOTE_CMDS[] = { "blink", "ring", "test", "white", "normal" };

static WiFiUDP    udp;
static HTTPUpdate updater(HTTP_TIMEOUT_MS);
static IPAddress  server;
static uint16_t   httpPort       = 0;
static bool       haveServer     = false;
static bool       connected      = false;   // connection set up (udp socket, power)
static bool       joining        = false;   // background retry in progress
static uint8_t    offlineChannel = 1;
static uint32_t   updateAt       = 0;       // 0 = no update scheduled
static uint32_t   lastReport     = 0;
static uint32_t   joinStart      = 0;
static uint32_t   lastTry        = 0;
static uint16_t   cmdCount       = 0;      // remote commands run, reported to the server

inline bool configured() { return WIFI_SSID[0] != 0; }
inline bool online() { return WiFi.status() == WL_CONNECTED; }

// Set up everything that depends on being on the Wi-Fi; runs on every (re)join.
inline void onJoined() {
  WiFi.setSleep(false);   // modem power-save makes a 1 MB download crawl and time out
  esp_wifi_set_max_tx_power(WIFI_TX_QDBM);
  udp.stop();
  udp.begin(BEACON_PORT);
  connected = true;
  Serial.printf("Wi-Fi: \"%s\" ip %s channel %d signal %d dBm, firmware v%d\n", WIFI_SSID,
                WiFi.localIP().toString().c_str(), WiFi.channel(), WiFi.RSSI(), FW_VERSION);
}

// Stop trying for now: no channel hopping, so ESP-NOW keeps working offline.
inline void giveUp() {
  WiFi.setAutoReconnect(false);
  WiFi.disconnect();
  esp_wifi_set_channel(offlineChannel, WIFI_SECOND_CHAN_NONE);
  joining = false;
}

// Joins the Wi-Fi in secrets.h. Returns its channel, or 0 when running offline (then
// ESP-NOW uses `fallbackChannel`, and loop() retries the Wi-Fi every RETRY_MS).
inline uint8_t begin(uint8_t fallbackChannel) {
  offlineChannel = fallbackChannel;
  if (!configured()) {
    Serial.println("Wi-Fi: no secrets.h, running offline");
    return 0;
  }
  WiFi.setAutoReconnect(true);
  WiFi.begin(WIFI_SSID, WIFI_PASS);
  uint32_t t0 = millis();
  while (!online() && millis() - t0 < JOIN_TIMEOUT_MS) delay(100);
  lastTry = millis();
  if (!online()) {
    giveUp();
    Serial.printf("Wi-Fi: could not join \"%s\", running offline (retry every %lu s)\n",
                  WIFI_SSID, (unsigned long)(RETRY_MS / 1000));
    return 0;
  }
  onJoined();
  return WiFi.channel();
}

// Call every loop. `id` is this board's id (test-batch list and command target),
// `status` is sent to the server, `showUpdating` paints the ring before the blocking
// (up to ~1 min) download starts, `onCommand` runs a remote command.
inline void loop(uint32_t now, uint32_t id, const char *status, void (*showUpdating)(),
                 void (*onCommand)(const char *)) {
  if (!online()) {
    connected = false;
    if (!configured()) return;
    if (!joining && now - lastTry >= RETRY_MS) {
      Serial.println("Wi-Fi: retrying");
      lastTry = now;
      joinStart = now;
      joining = true;
      WiFi.setAutoReconnect(true);
      WiFi.begin(WIFI_SSID, WIFI_PASS);
    } else if (joining && now - joinStart >= JOIN_TIMEOUT_MS) {
      giveUp();
      Serial.println("Wi-Fi: still can't join, staying offline");
    }
    return;
  }
  if (!connected) {
    joining = false;
    onJoined();
  }

  char me[9];
  snprintf(me, sizeof(me), "%08X", (unsigned)id);
  for (int n = udp.parsePacket(); n > 0; n = udp.parsePacket()) {
    char buf[200];
    int len = udp.read(buf, sizeof(buf) - 1);
    buf[len > 0 ? len : 0] = 0;

    char target[12], cmd[12];
    if (sscanf(buf, "HEXCMD %11s %11s", target, cmd) == 2) {
      if (strcmp(target, "all") && strcmp(target, me)) continue;
      for (const char *ok : REMOTE_CMDS)
        if (!strcmp(cmd, ok)) { Serial.printf("Remote command: %s\n", cmd); cmdCount++; onCommand(cmd); }
      continue;
    }

    int ver, port;
    if (sscanf(buf, "HEXNODE ver=%d port=%d", &ver, &port) != 2) continue;
    if (!haveServer) Serial.printf("Update server found at %s\n", udp.remoteIP().toString().c_str());
    server = udp.remoteIP();
    httpPort = (uint16_t)port;
    haveServer = true;
    // "only=ID1,ID2,..." = release is still on its test batch; everyone else waits
    const char *only = strstr(buf, "only=");
    if (only && !strstr(only, me)) continue;
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
