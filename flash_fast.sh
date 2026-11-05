#!/usr/bin/env bash
# Fastest way to flash many ESP32s with HexNode_01.
# Flashes every board you plug in, several at the same time (use a USB hub).
# No questions asked: keep plugging boards in. Ctrl+C when done.
#
#   ./flash_fast.sh              compile once (if the source is here), then flash
#   ./flash_fast.sh --no-compile reuse the last build (skips the ~30 s compile)
#
# With a ready-made firmware/ folder next to this script (the shared package), it
# skips compiling and only needs esptool:  pip3 install esptool
#
# Check each board afterwards by touching D13: the blue onboard LED lights and,
# if a ring is attached, the whole ring glows white; let go and the glow goes away.
# Saved positions are kept (only the program area is written). Log: flash_fast_log.csv
set -u
export LC_ALL=C

DIR="$(cd "$(dirname "$0")" && pwd)"
SKETCH="$DIR/Code/HexNode_01"
LOG="$DIR/flash_fast_log.csv"
JOBS="$DIR/.flash_jobs"
PORTS="/dev/cu.usbserial-* /dev/cu.SLAB_USBtoUART* /dev/cu.wchusbserial* /dev/cu.usbmodem*"

# esptool: the copy inside the Arduino esp32 core, else a pip install
ESP=("$(ls -d ~/Library/Arduino15/packages/esp32/tools/esptool_py/*/esptool 2>/dev/null | tail -1)")
if [ ! -x "${ESP[0]}" ]; then
  if command -v esptool >/dev/null; then ESP=(esptool)
  elif command -v esptool.py >/dev/null; then ESP=(esptool.py)
  elif python3 -c "import esptool" 2>/dev/null; then ESP=(python3 -m esptool)
  else echo "esptool not found. Install it:  pip3 install esptool"; exit 1
  fi
fi

if [ -d "$SKETCH" ]; then
  FW="$DIR/.build"
  if [ "${1:-}" != "--no-compile" ]; then
    echo "Compiling once..."
    arduino-cli compile --fqbn esp32:esp32:esp32 --output-dir "$FW" "$SKETCH" | grep "Sketch uses" || exit 1
  fi
  cp "$(ls ~/Library/Arduino15/packages/esp32/hardware/esp32/*/tools/partitions/boot_app0.bin | tail -1)" "$FW/boot_app0.bin"
else
  FW="$DIR/firmware"   # shared package: prebuilt firmware
  echo "Using prebuilt firmware in $FW"
fi
for f in HexNode_01.ino.bootloader.bin HexNode_01.ino.partitions.bin boot_app0.bin HexNode_01.ino.bin; do
  [ -f "$FW/$f" ] || { echo "Missing $FW/$f"; exit 1; }
done

sound() { afplay "/System/Library/Sounds/$1.aiff" >/dev/null 2>&1 & }

write_fw() { # port, baud
  "${ESP[@]}" --chip esp32 --port "$1" --baud "$2" write_flash -z \
    --flash_mode dio --flash_freq 80m --flash_size 4MB \
    0x1000 "$FW/HexNode_01.ino.bootloader.bin" \
    0x8000 "$FW/HexNode_01.ino.partitions.bin" \
    0xe000 "$FW/boot_app0.bin" \
    0x10000 "$FW/HexNode_01.ino.bin"
}

flash_one() { # runs in the background, one per board; slow retry if the fast one fails
  local p="$1" name; name="$(basename "$p")"
  if write_fw "$p" 460800 > "$JOBS/$name.log" 2>&1 ||
     { sleep 1; write_fw "$p" 115200 >> "$JOBS/$name.log" 2>&1; }; then
    echo "$(date '+%H:%M:%S'),$p,ok" >> "$LOG"; echo ok > "$JOBS/$name.result"
  else
    echo "$(date '+%H:%M:%S'),$p,FAILED" >> "$LOG"; echo fail > "$JOBS/$name.result"
  fi
  rm -f "$JOBS/$name.busy"
}

mkdir -p "$JOBS"; rm -f "$JOBS"/*
[ -f "$LOG" ] || echo "time,port,flash" > "$LOG"
trap 'echo; echo "Done: $OK flashed, $BAD failed."; exit 0' INT

# A port is "handled" ($JOBS/<port>.seen) from the moment it is flashed until it has
# been missing for 3 s in a row; ports blink out during a flash or reset, so a short
# gap must not count as a new board.
OK=0; BAD=0
echo "Ready. Plug in ESP32s (several at once is fine). Ctrl+C to stop."
while true; do
  for p in $PORTS; do
    [ -e "$p" ] || continue
    name="$(basename "$p")"
    rm -f "$JOBS/$name.gone"
    [ -e "$JOBS/$name.seen" ] && continue
    touch "$JOBS/$name.seen" "$JOBS/$name.busy"
    echo "--> flashing $name"
    flash_one "$p" &
  done
  for r in "$JOBS"/*.result; do
    [ -e "$r" ] || continue
    name="$(basename "$r" .result)"
    if [ "$(cat "$r")" = ok ]; then
      OK=$((OK + 1)); sound Glass
      echo "    ✅ $name done ($OK flashed). Touch D13 to check, then unplug."
    else
      BAD=$((BAD + 1)); sound Basso
      echo "    ❌ $name FAILED: $(grep -iE "error|fatal" "$JOBS/$name.log" | grep -v "^Note" | tail -1)"
      echo "       Unplug, then replug while holding BOOT."
    fi
    rm -f "$r"
  done
  for s in "$JOBS"/*.seen; do
    [ -e "$s" ] || continue
    name="$(basename "$s" .seen)"
    [ -e "/dev/$name" ] && continue
    [ -e "$JOBS/$name.busy" ] && continue
    g=$(( $(cat "$JOBS/$name.gone" 2>/dev/null || echo 0) + 1 ))
    if [ $g -ge 3 ]; then rm -f "$s" "$JOBS/$name.gone"; else echo $g > "$JOBS/$name.gone"; fi
  done
  sleep 1
done
