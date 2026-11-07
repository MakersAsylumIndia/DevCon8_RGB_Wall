#!/usr/bin/env bash
# Tests whether HexNodes can use the venue Wi-Fi, on ONE plugged-in board.
#   1. Put the Wi-Fi name and password in Code/WifiCheck/secrets.h
#   2. Connect this laptop to the same venue Wi-Fi
#   3. Plug in one ESP32 and run: ./wifi_check.sh
# Checks: board can join, which channel, internet open or captive portal, and
# whether this laptop can reach the board (client isolation).
# Afterwards reflash the board with flash_fast.sh to get HexNode back.
set -u
export LC_ALL=C

DIR="$(cd "$(dirname "$0")" && pwd)"
SKETCH="$DIR/Code/WifiCheck"
BUILD="$DIR/.build_wifi"
PORT="$(ls /dev/cu.usbserial-* /dev/cu.SLAB_USBtoUART* /dev/cu.wchusbserial* 2>/dev/null | head -1)"

grep -q "PUT_VENUE_WIFI" "$SKETCH/secrets.h" && { echo "Fill in the Wi-Fi name and password in $SKETCH/secrets.h first."; exit 1; }
[ -n "$PORT" ] || { echo "No ESP32 found. Plug one in."; exit 1; }

echo "Laptop Wi-Fi: $(ipconfig getsummary en0 2>/dev/null | awk -F' SSID : ' '/ SSID : /{print $2; exit}') (should be the venue network)"
echo "Compiling and flashing $PORT ..."
arduino-cli compile --fqbn esp32:esp32:esp32 --output-dir "$BUILD" "$SKETCH" | grep "Sketch uses" || exit 1
arduino-cli upload -p "$PORT" --fqbn esp32:esp32:esp32 --input-dir "$BUILD" 2>&1 | grep -q "Hard resetting" || { echo "Flash failed. Replug holding BOOT and retry."; exit 1; }

echo "Board is testing the Wi-Fi (up to 40 s)..."
res="$(python3 -I - "$DIR" "$PORT" <<'PY'
import sys
sys.path.insert(0, sys.argv[1])
from hexnode_serial import Port
p = Port(sys.argv[2])
for line in p.lines(40):
    if line.startswith("RESULT"):
        print(line, flush=True)
        if line == "RESULT done":
            break
PY
)"
echo "$res" | sed 's/^RESULT /    /'

ip="$(echo "$res" | sed -n 's/^RESULT ip *\([0-9.]*\).*/\1/p' | head -1)"
reach=""
if [ -n "$ip" ]; then
  if ping -c 3 -t 6 "$ip" >/dev/null 2>&1; then reach=yes; echo "    laptop -> board: reachable ($ip)"
  else reach=no; echo "    laptop -> board: NOT reachable ($ip) - client isolation, or laptop on another network"
  fi
fi

echo
echo "Verdict:"
if ! echo "$res" | grep -qE "join     ok|^RESULT ip"; then
  echo "  ❌ Board can't join. Check the name/password, that it's 2.4 GHz, and not WPA2-Enterprise."
elif echo "$res" | grep -q "CAPTIVE PORTAL"; then
  echo "  ⚠️  Captive portal: ask the venue to whitelist the boards' MAC addresses, or bring a router."
elif echo "$res" | grep -q "internet open" && [ "$reach" = yes ]; then
  echo "  ✅ All good: boards can reach the internet AND this laptop. Server can run on the laptop or online."
elif echo "$res" | grep -q "internet open"; then
  echo "  ⚠️  Internet works but laptop can't reach the board: run the update/design server online, not on the laptop."
else
  echo "  ⚠️  Joined but no internet: server must run on the laptop (only works if 'reachable' above)."
fi
echo "  Channel: $(echo "$res" | grep "^RESULT ip.*channel" | sed -n 's/.*channel \([0-9]*\).*/\1/p' | head -1) (the firmware's ESP-NOW has to use this same channel)"
