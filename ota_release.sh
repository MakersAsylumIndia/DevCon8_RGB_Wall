#!/usr/bin/env bash
# Publish Code/HexNode_01 as a new over-the-air release (ota_server.py must be running).
#
#   ./ota_release.sh              build a new version, send it to 5 test boards only
#   ./ota_release.sh --all        test boards look good: send the same version to everyone
#   ./ota_release.sh --skip-test  build and send straight to everyone (small, safe fixes)
#
# Watch progress on http://localhost:8266. TEST_COUNT=3 ./ota_release.sh picks 3 test boards.
set -eu
export LC_ALL=C

DIR="$(cd "$(dirname "$0")" && pwd)"
SKETCH="$DIR/Code/HexNode_01"
VFILE="$SKETCH/version.h"
OUT="$DIR/ota"
BUILD="$DIR/.build_ota"
API="http://localhost:8266/api/boards"
TEST_COUNT="${TEST_COUNT:-5}"
MODE="${1:-test}"

mkdir -p "$OUT"
case "$MODE" in
  --all)
    [ -f "$OUT/test_ids.txt" ] || { echo "Nothing to promote: the current release is already on all boards."; exit 0; }
    rm -f "$OUT/test_ids.txt"
    echo "v$(cat "$OUT/version.txt") released to ALL boards. They update 15 at a time (watch http://localhost:8266)."
    exit 0 ;;
  test|--skip-test) ;;
  *) sed -n '2,8p' "$0" | sed 's/^# \{0,1\}//'; exit 1 ;;
esac

[ -f "$SKETCH/secrets.h" ] || { echo "Missing $SKETCH/secrets.h: without Wi-Fi details the new firmware can't do OTA again."; exit 1; }
grep -q "PUT_VENUE_WIFI" "$SKETCH/secrets.h" && { echo "Fill in $SKETCH/secrets.h first."; exit 1; }
boards_json="$(curl -s --max-time 3 "$API")" || { echo "ota_server.py isn't running. Start it first:  python3 $DIR/ota_server.py"; exit 1; }

if [ "$MODE" = test ]; then
  # test batch = the first TEST_COUNT online boards (sorted by id, so it's the same boards each time)
  ids="$(echo "$boards_json" | python3 -I -c "
import json, sys
b = [x['id'] for x in json.load(sys.stdin)['boards'] if x['online']]
print(' '.join(sorted(b)[:int(sys.argv[1])]))" "$TEST_COUNT")"
  [ -n "$ids" ] || { echo "No boards online to test on. Check the status page."; exit 1; }
fi

old=$(sed -n 's/^#define FW_VERSION \([0-9]*\).*/\1/p' "$VFILE")
new=$((old + 1))
sed -i '' "s/^#define FW_VERSION .*/#define FW_VERSION $new/" "$VFILE"
echo "Building v$new (was v$old)..."
if ! arduino-cli compile --fqbn esp32:esp32:esp32 --output-dir "$BUILD" "$SKETCH" | grep "Sketch uses"; then
  sed -i '' "s/^#define FW_VERSION .*/#define FW_VERSION $old/" "$VFILE"
  echo "Compile failed, version left at v$old."
  exit 1
fi

# limit to the test batch BEFORE the new version goes live, so no other board grabs it
if [ "$MODE" = test ]; then echo "$ids" > "$OUT/test_ids.txt"; else rm -f "$OUT/test_ids.txt"; fi
cp "$BUILD/HexNode_01.ino.bin" "$OUT/firmware.bin.tmp" && mv "$OUT/firmware.bin.tmp" "$OUT/firmware.bin"
echo "$new" > "$OUT/version.txt"

if [ "$MODE" = test ]; then
  echo "v$new released to TEST boards only: $ids"
  echo "Watch them turn green on http://localhost:8266 and check them on the wall, then run:"
  echo "  ./ota_release.sh --all"
else
  echo "v$new released to ALL boards. They update 15 at a time (watch http://localhost:8266)."
fi
