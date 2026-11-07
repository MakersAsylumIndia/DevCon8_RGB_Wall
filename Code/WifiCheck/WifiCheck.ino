/*
  WifiCheck - can a HexNode live on this Wi-Fi?
  Joins the network in secrets.h and prints one RESULT line per check:
    RESULT join      ok / FAIL (+ reason, and whether the network was seen in a scan)
    RESULT ip        address, gateway, channel, signal
    RESULT internet  open / CAPTIVE PORTAL / none
  Ring (if attached): green = all good, yellow = joined but no open internet, red = can't join.
  Run it with wifi_check.sh, which also tests whether the laptop can reach the board.
*/
#include <WiFi.h>
#include <HTTPClient.h>
#include <Adafruit_NeoPixel.h>
#include "secrets.h"

#define LED_PIN 15
Adafruit_NeoPixel ring(16, LED_PIN, NEO_GRB + NEO_KHZ800);

static void ringColor(uint8_t r, uint8_t g, uint8_t b) {
  ring.fill(ring.Color(r, g, b));
  ring.show();
}

static const char *authName(wifi_auth_mode_t a) {
  switch (a) {
    case WIFI_AUTH_OPEN: return "open";
    case WIFI_AUTH_WEP: return "WEP";
    case WIFI_AUTH_WPA_PSK: return "WPA";
    case WIFI_AUTH_WPA2_PSK: return "WPA2";
    case WIFI_AUTH_WPA_WPA2_PSK: return "WPA/WPA2";
    case WIFI_AUTH_WPA2_ENTERPRISE: return "WPA2-ENTERPRISE (needs username login)";
    case WIFI_AUTH_WPA3_PSK: return "WPA3";
    case WIFI_AUTH_WPA2_WPA3_PSK: return "WPA2/WPA3";
    default: return "other";
  }
}

static void scanFor(const char *ssid) {
  int n = WiFi.scanNetworks();
  for (int i = 0; i < n; i++) {
    if (WiFi.SSID(i) == ssid) {
      Serial.printf("RESULT scan     seen: channel %d, signal %d dBm, security %s\n",
                    WiFi.channel(i), WiFi.RSSI(i), authName(WiFi.encryptionType(i)));
      return;
    }
  }
  Serial.printf("RESULT scan     NOT SEEN (%d networks around, check the name; ESP32 only sees 2.4 GHz)\n", n);
  for (int i = 0; i < n; i++) {
    String s = WiFi.SSID(i);
    bool close = s.equalsIgnoreCase(ssid) || s.indexOf("DEV") >= 0 || s.indexOf("Dev") >= 0 || s.indexOf("dev") >= 0;
    Serial.printf("RESULT seen     %s\"%s\" channel %d, %d dBm, %s\n", close ? "<-- " : "    ",
                  s.c_str(), WiFi.channel(i), WiFi.RSSI(i), authName(WiFi.encryptionType(i)));
  }
}

void setup() {
  Serial.begin(115200);
  delay(300);
  ring.begin();
  ring.setBrightness(40);
  ringColor(0, 0, 60);  // blue = working on it
  Serial.printf("\nWifiCheck: joining \"%s\"\n", WIFI_SSID);

  WiFi.mode(WIFI_STA);
  WiFi.begin(WIFI_SSID, WIFI_PASS);
  uint32_t t0 = millis();
  while (WiFi.status() != WL_CONNECTED && millis() - t0 < 20000) delay(250);

  if (WiFi.status() != WL_CONNECTED) {
    Serial.printf("RESULT join     FAIL (status %d: 1 = network not found, 4 = wrong password or rejected)\n",
                  (int)WiFi.status());
    WiFi.disconnect();
    scanFor(WIFI_SSID);
    ringColor(255, 0, 0);
    Serial.println("RESULT done");
    return;
  }
  Serial.println("RESULT join     ok");
  Serial.printf("RESULT ip       %s gateway %s channel %d signal %d dBm mac %s\n",
                WiFi.localIP().toString().c_str(), WiFi.gatewayIP().toString().c_str(),
                WiFi.channel(), WiFi.RSSI(), WiFi.macAddress().c_str());

  // generate_204 answers 204 on open internet; a captive portal answers 200/302 with its login page
  HTTPClient http;
  http.setTimeout(8000);
  http.begin("http://connectivitycheck.gstatic.com/generate_204");
  int code = http.GET();
  http.end();
  bool open = code == 204;
  if (open) Serial.println("RESULT internet open");
  else if (code > 0) Serial.printf("RESULT internet CAPTIVE PORTAL (got HTTP %d instead of 204)\n", code);
  else Serial.printf("RESULT internet none (%s)\n", HTTPClient::errorToString(code).c_str());

  ringColor(open ? 0 : 255, open ? 255 : 160, 0);
  Serial.println("RESULT done");
}

void loop() {
  // keep reporting the address so the laptop can find the board later
  static uint32_t last = 0;
  if (WiFi.status() == WL_CONNECTED && millis() - last > 5000) {
    last = millis();
    Serial.printf("RESULT ip       %s\n", WiFi.localIP().toString().c_str());
  }
}
