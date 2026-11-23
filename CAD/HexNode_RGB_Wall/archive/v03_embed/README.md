# v03 embedded-magnet bracket (archived 21 Nov 2026)

Variant of `Bracket_v03` with the four 10 x 10 x 2 mm magnets sealed in during the print, behind a
0.5 mm skin on the board side. It prints top face down, with a pause at **Z = 4.2 mm** to drop the
magnets in (all the same way up). The hold is a little weaker than the pocket bracket because of
the 0.5 mm gap. Archived in favour of `Bracket_v03_pocket`.

- `Bracket_v03_embed.stl`, `Bracket_v03_embed.step`: the part as last exported (2.0 mm rivet holes, 2.5 mm tab end gap, cut-through + and - signs).
- `HexNode_v03_bracket_embed_P1S.gcode.3mf` (and `.gcode`): Bambu P1S, PETG, 16 min, 6.8 g, with the pause inserted (`M400 U1`).
- `reslice_with_embed.sh`: the slicing script that also slices this bracket and inserts the pause. Run it from the project root with `Bracket_v03_embed.stl` copied back into `export/print/`.

To build it again: `v03.bracket(p, "embed")` in `scripts/v03.py` (the `EmbedSkin` parameter is still in the sheet).
