This folder will contain all of your Arduino & other code files.
- `HexNode_01/` - main HexNode sketch (v9: Wi-Fi retry, white mode, remote commands and OTA; see `TOOLS.md`).
- `HexNode_02/` - v2.3: tested on the CP2102 ESP32 DevKit V1 boards (80 MHz CPU, gentle radio start, `sens` and `cal` commands). Works on Arduino-ESP32 core 3.x and 4.x. Core 4.0.0 has a bug where touchRead() returns 0 on the classic ESP32, so on core 4.x the sketch starts the ESP-IDF touch driver itself.
- v3 (planned) - for the CH340 ESP32 boards.
