This folder will contain all of your Arduino & other code files.
- `HexNode_01/` - main HexNode sketch (v9: Wi-Fi retry, white mode, remote commands and OTA; see `TOOLS.md`).
- `HexNode_02/` - v2.2: tested on the CP2102 ESP32 DevKit V1 boards (80 MHz CPU, gentle radio start, `sens` and `cal` commands). Works on Arduino-ESP32 core 3.x and 4.x: touch direction learned from the first touch, and on core 4.x (where touchRead() returns ~0) the touch register is read directly.
- v3 (planned) - for the CH340 ESP32 boards.
