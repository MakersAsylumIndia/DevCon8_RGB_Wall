#!/usr/bin/env bash
# Universal HexNode flasher. Compiles once, then flashes every ESP32 you plug in,
# one after another. Ctrl+C when done. Every result goes to hexnode_log.csv.
#
#   ./hexnode.sh                 flash + D13 touch test (ring glows if one is attached)
#   ./hexnode.sh --led           also ask "did the ring glow?" and log it
#   ./hexnode.sh --pos           also give each board the next Ethereum logo slot
#   ./hexnode.sh --no-touch      flash only, skip the touch test
#   (options combine, e.g. ./hexnode.sh --led --pos)
#
# On every board: the ring (if present) flashes red/green/blue at boot, the blue
# onboard LED lights while D13 is touched, and a touch fires a ripple on the ring.
# Boards with no ring or no wire are fine. Reflashing keeps a board's saved position.
set -u
export LC_ALL=C   # serial output starts with boot garbage; UTF-8 tools choke on it

TOUCH=1; LED=0; POS=0
for a in "$@"; do
  case "$a" in
    --led) LED=1 ;;
    --pos) POS=1 ;;
    --no-touch) TOUCH=0 ;;
    -h|--help) sed -n '2,13p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "Unknown option: $a (try --help)"; exit 1 ;;
  esac
done

DIR="$(cd "$(dirname "$0")" && pwd)"
SKETCH="$DIR/Code/HexNode_01"
FQBN="esp32:esp32:esp32"
BUILD="$DIR/.build"
LOG="$DIR/hexnode_log.csv"
OLD_LOG="$DIR/flash_log.csv"          # slots handed out by the earlier flash_all.sh
LAYOUT="$DIR/ethereum_layout.csv"
SERIAL="$DIR/hexnode_serial.py"
PORTS="/dev/cu.usbserial-* /dev/cu.SLAB_USBtoUART* /dev/cu.wchusbserial* /dev/cu.usbmodem*"
TOUCH_WINDOW=10   # seconds you get to touch D13

sound() { afplay "/System/Library/Sounds/$1.aiff" >/dev/null 2>&1 & }

command -v arduino-cli >/dev/null || { echo "arduino-cli not found: brew install arduino-cli"; exit 1; }
command -v python3 >/dev/null || { echo "python3 not found: xcode-select --install"; exit 1; }
echo "Compiling once..."
arduino-cli compile --fqbn "$FQBN" --output-dir "$BUILD" "$SKETCH" | grep "Sketch uses" || exit 1
[ -f "$LOG" ] || echo "time,port,flash,touch,led,slot,q,r,id" > "$LOG"
echo "Mode: touch test $([ $TOUCH = 1 ] && echo ON || echo OFF), ring question $([ $LED = 1 ] && echo ON || echo OFF), positions $([ $POS = 1 ] && echo ON || echo OFF)"

flash() {
  local out
  out="$(arduino-cli upload -p "$1" --fqbn "$FQBN" --input-dir "$BUILD" 2>&1)"
  echo "$out" | grep -q "Hard resetting" && return 0
  echo "    $(echo "$out" | grep -iE "error|fatal|failed" | tail -1)"
  return 1
}

used_slots() {
  cut -d, -f3,6 "$LOG" | grep "^ok," | cut -d, -f2
  [ -f "$OLD_LOG" ] && cut -d, -f3,4 "$OLD_LOG" | grep "^ok," | cut -d, -f2
}

next_slot() { # first layout slot not handed out yet
  local s used
  used=" $(used_slots | tr '\n' ' ') "
  for s in $(tail -n +2 "$LAYOUT" | cut -d, -f1); do
    case "$used" in *" $s "*) ;; *) echo "$s"; return ;; esac
  done
}

DONE=""; N=0; PASS=0; FAIL=0
echo "Ready. Plug in an ESP32 (Ctrl+C to stop)."
while true; do
  for p in $PORTS; do
    [ -e "$p" ] || continue
    case " $DONE " in *" $p "*) continue ;; esac
    DONE="$DONE $p"
    sleep 1   # let the USB port settle
    N=$((N + 1))
    echo "--- Board $N: flashing $p ..."
    if ! flash "$p"; then
      echo "    retrying once..."
      if ! flash "$p"; then
        sound Basso
        echo "    FLASH FAILED. Unplug, then replug while holding the BOOT button (or try another cable)."
        echo "$(date '+%H:%M:%S'),$p,FAILED,,,,,," >> "$LOG"
        continue
      fi
    fi
    echo "    Flashed OK. Hands off while it boots and calibrates..."

    slot=""; q=""; r=""; led=""; touch=""
    args=()
    [ $TOUCH = 1 ] && args+=(--touch "$TOUCH_WINDOW")
    [ $LED = 1 ] && args+=(--ring)
    if [ $POS = 1 ]; then
      slot="$(next_slot)"
      if [ -z "$slot" ]; then
        echo "    All logo slots used, no position given."
      else
        IFS=, read -r _ q r < <(grep "^$slot," "$LAYOUT")
        args+=(--pos "$q" "$r")
      fi
    fi

    res="$(python3 -I "$SERIAL" "$p" ${args[@]+"${args[@]}"})"
    id="$(echo "$res" | sed -n 's/^ID //p')"
    echo "    $id"
    echo "$res" | grep "^ERROR" | sed 's/^/    /'
    case "$(echo "$res" | sed -n 's/^TOUCH //p')" in
      PASS)  touch=PASS;  PASS=$((PASS + 1)); sound Glass; echo "    ✅ TOUCH PASS" ;;
      STUCK) touch=STUCK; FAIL=$((FAIL + 1)); sound Basso; echo "    ❌ TOUCH STUCK (reads touched with no finger: check D13 isn't shorted)" ;;
      FAIL)  touch=FAIL;  FAIL=$((FAIL + 1)); sound Basso; echo "    ❌ TOUCH FAIL (no touch seen on D13: check the pin / solder joint)" ;;
    esac

    if [ $LED = 1 ]; then
      read -r -p "    Did the ring just flash red/green/blue? [y = yes, n = no, Enter = no ring] " ans </dev/tty
      case "$ans" in y|Y) led=OK ;; n|N) led=FAIL; sound Basso ;; *) led=none ;; esac
    fi
    [ -n "$slot" ] && printf '\n    >>> WRITE  #%s  ON THIS BOARD  (pos %s %s) <<<\n\n' "$slot" "$q" "$r"

    echo "$(date '+%H:%M:%S'),$p,ok,$touch,$led,$slot,$q,$r,$(echo "$id" | grep -oE 'id=[0-9A-F]+')" >> "$LOG"
    [ $TOUCH = 1 ] && echo "    Totals: $N boards, $PASS touch pass, $FAIL touch fail."
    echo "    Unplug it and plug in the next one."
  done
  # forget ports gone for 3 checks in a row (a board reset can blip the port briefly)
  sleep 1
  still=""; for p in $DONE; do
    [ -e "$p" ] || { sleep 1; [ -e "$p" ] || { sleep 1; [ -e "$p" ]; }; } && still="$still $p"
  done
  DONE="$still"
done
