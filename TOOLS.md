# Flashing and over-the-air tools

Scripts for flashing many HexNodes (ESP32 DevKit V1, ring on D15, touch on D13) and
updating them over Wi-Fi. macOS, needs `arduino-cli` with the esp32 core and the
Adafruit NeoPixel library (see the README for install steps).

## One-time setup

```bash
cp Code/HexNode_01/secrets.example.h Code/HexNode_01/secrets.h   # then fill in your 2.4 GHz Wi-Fi
```

`secrets.h` is gitignored. Without it the firmware runs offline (ESP-NOW only, no updates).

## Flash boards over USB

| Script | What it does |
|---|---|
| `./flash_fast.sh` | Compiles once, flashes every board you plug in, several at once through a hub. Fastest. Touch D13 to check: blue onboard LED + white ring glow. |
| `./hexnode.sh --led` | One board at a time, with a logged D13 touch test and ring check. `--pos` gives boards Ethereum logo positions. |
| `./wifi_check.sh` | Flashes a test sketch on one board: can it join the Wi-Fi, is there a captive portal, can the laptop reach it, which channel. |

## Update over Wi-Fi (no USB)

Boards flashed with `secrets.h` join the Wi-Fi and update themselves from your laptop.

```bash
python3 ota_server.py          # keep running; status page on http://localhost:8266
./ota_release.sh               # build the next version, send it to 5 test boards only
./ota_release.sh --all         # test boards look good: send it to every board
./ota_release.sh --skip-test   # small, safe change: send straight to everyone
```

At most 15 boards download at once; the others wait and retry. Every release must keep
`secrets.h` and `wall_net.h`, or boards lose the ability to update without USB.

Ports: UDP 4211 (server beacon), UDP 4212 (board status), TCP 8266 (firmware + page).

## Firmware changes in HexNode_01

- Works with Adafruit NeoPixel 1.12+ (1.10.x crashes on esp32 core 3.x).
- One ripple per touch, no hold-repeat; a stuck touch reading re-calibrates after 3 s.
- Blue onboard LED (GPIO2) on while touched; ring glows white while touched.
- Ring flashes red/green/blue at boot (`ring` serial command repeats it).
- Wi-Fi + over-the-air updates in `wall_net.h`; ESP-NOW follows the router's channel.
