"""Lay out the v03 laser DXFs (R12 polylines, mm) as LightBurn projects (.lbrn2).

Run with the system python:  python3 scripts/lightburn.py
Writes export/laser/HexNode_v03_strips_1.8mm.lbrn2 and export/laser/HexNode_v03_rail_gauge.lbrn2.
Power and speed are placeholders: no laser is set up in LightBurn on this machine yet.
"""
import os

HERE = os.path.dirname(os.path.abspath(__file__))
LASER = os.path.join(HERE, "..", "export", "laser")
BED = (900, 600)
GAP = 3.0                                     # between parts


def read_dxf(path):
    """Closed polylines from our minimal R12 writer: list of (layer, [(x, y), ...])."""
    t = [l.strip() for l in open(path)]
    loops, i = [], 0
    while i < len(t):
        if t[i] == "POLYLINE":
            layer, pts = t[i + 2], []
            i += 1
            while t[i] != "SEQEND":
                if t[i] == "VERTEX":
                    j = t.index("10", i)
                    pts.append((float(t[j + 1]), float(t[j + 3])))
                i += 1
            if len(pts) > 1 and abs(pts[0][0] - pts[-1][0]) < 1e-6 and abs(pts[0][1] - pts[-1][1]) < 1e-6:
                pts = pts[:-1]
            loops.append((layer, _simplify(pts)))
        i += 1
    return loops


def _simplify(pts):
    """Drop points on straight runs (the DXF writer discretizes edges)."""
    out = []
    n = len(pts)
    for k in range(n):
        a, b, c = pts[k - 1], pts[k], pts[(k + 1) % n]
        cross = (b[0] - a[0]) * (c[1] - b[1]) - (b[1] - a[1]) * (c[0] - b[0])
        if abs(cross) > 1e-6:
            out.append(b)
    return out


def bbox(loops):
    xs = [x for _, p in loops for x, _ in p]
    ys = [y for _, p in loops for _, y in p]
    return min(xs), min(ys), max(xs), max(ys)


def shape_xml(pts, cut_index, dx, dy):
    v = "".join(f"V{x + dx:.4f} {y + dy:.4f}c0x1c1x1" for x, y in pts)
    return (f'    <Shape Type="Path" CutIndex="{cut_index}">\n'
            f'        <XForm>1 0 0 1 0 0</XForm>\n'
            f'        <VertList>{v}</VertList>\n'
            f'        <PrimList>LineClosed</PrimList>\n'
            f'    </Shape>\n')


def cut_xml(index, name, power, speed, priority, kind="Cut"):
    extra = '        <interval Value="0.1"/>\n' if kind == "Scan" else ""
    return (f'    <CutSetting type="{kind}">\n'
            f'        <index Value="{index}"/>\n        <name Value="{name}"/>\n'
            f'        <maxPower Value="{power}"/>\n        <maxPower2 Value="{power}"/>\n'
            f'        <speed Value="{speed}"/>\n        <priority Value="{priority}"/>\n'
            + extra + f'    </CutSetting>\n')


def project(path, parts, note):
    """parts: list of (loops, dx, dy). Layer 0 = inner cuts (pockets, holes) first, layer 1 = outlines,
    layer 2 = ENGRAVE loops as a fill (done before any cutting)."""
    shapes, engrave = [], False
    for loops, dx, dy in parts:
        x0, y0, x1, y1 = bbox(loops)
        area = (x1 - x0) * (y1 - y0)
        for _, pts in loops:
            bx = bbox([("", pts)])
            outer = (bx[2] - bx[0]) * (bx[3] - bx[1]) > 0.9 * area
            idx = 2 if _ == "ENGRAVE" else (1 if outer else 0)
            engrave |= idx == 2
            shapes.append(shape_xml(pts, idx, dx - x0, dy - y0))
    xml = ('<?xml version="1.0" encoding="UTF-8"?>\n'
           '<LightBurnProject AppVersion="1.7.01" DeviceName="No Machine" FormatVersion="1" MaterialHeight="0" MirrorX="False" MirrorY="False">\n'
           '    <UIPrefs>\n        <Optimize_ByLayer Value="1"/>\n        <Optimize_InnerToOuter Value="1"/>\n'
           '        <Optimize_ReduceTravel Value="1"/>\n    </UIPrefs>\n'
           + (cut_xml(2, "Engrave labels (fill) - SET POWER/SPEED", 15, 200, 0, "Scan") if engrave else "")
           + cut_xml(0, "Inner cuts (pockets, holes) - SET POWER/SPEED", 20, 10, 1 if engrave else 0)
           + cut_xml(1, "Outlines - SET POWER/SPEED", 20, 10, 2 if engrave else 1)
           + "".join(shapes)
           + f'    <Notes ShowOnLoad="1" Notes="{note}"/>\n</LightBurnProject>\n')
    open(path, "w").write(xml)
    return path


def stack(items, x=GAP, y=GAP):
    """Stack parts up the bed (y), each given as loops. Returns (loops, dx, dy) list."""
    out = []
    for loops in items:
        x0, y0, x1, y1 = bbox(loops)
        assert x + (x1 - x0) <= BED[0] and y + (y1 - y0) <= BED[1], "does not fit the bed"
        out.append((loops, x, y))
        y += (y1 - y0) + GAP
    return out


def main(n_pairs=4, n_gauges=2):
    plus = read_dxf(os.path.join(LASER, "Plus_strip_1.8mm_x570.dxf"))
    gnd = read_dxf(os.path.join(LASER, "Gnd_strip_1.8mm_x570.dxf"))
    gauge = read_dxf(os.path.join(LASER, "Rail_gauge_any_sheet.dxf"))
    a = project(os.path.join(LASER, "HexNode_v03_strips_1.8mm.lbrn2"),
                stack([plus] * n_pairs + [gnd] * n_pairs),
                f"HexNode v03 rail strips, 1.8 mm acrylic: {n_pairs} x +5V (14 mm) and {n_pairs} x GND (20 mm), 570 mm long. "
                "Set power and speed for your laser on both layers. Layer C00 (magnet pockets) cuts first. "
                "Test one pocket: a 10x10x2 magnet should be a tight push fit.")
    gx = gauge
    b = project(os.path.join(LASER, "HexNode_v03_rail_gauge.lbrn2"),
                [(gx, GAP + k * (bbox(gx)[2] - bbox(gx)[0] + GAP), GAP) for k in range(n_gauges)],
                f"HexNode v03 rail gauge x{n_gauges}, any sheet. Set power and speed for your material.")
    return a, b


def proto(n_sets=1, n_gauges=2):
    """One-node prototype: +5V strip, GND strip and rail gauges, all on one 1.8 mm sheet."""
    plus = read_dxf(os.path.join(LASER, "Proto_plus_strip_1.8mm.dxf"))
    gnd = read_dxf(os.path.join(LASER, "Proto_gnd_strip_1.8mm.dxf"))
    gauge = read_dxf(os.path.join(LASER, "Proto_rail_gauge.dxf"))
    parts = stack([plus, gnd] * n_sets)
    y = max(dy + bbox(l)[3] - bbox(l)[1] for l, _, dy in parts) + GAP
    x = GAP
    for k in range(n_gauges):
        gx0, gy0, gx1, gy1 = bbox(gauge)
        parts.append((gauge, x, GAP))
        x += 0
    # gauges go to the right of the strips
    sx = max(dx + bbox(l)[2] - bbox(l)[0] for l, dx, _ in parts[:-n_gauges]) + GAP
    gw = bbox(gauge)[2] - bbox(gauge)[0]
    parts = parts[:-n_gauges] + [(gauge, sx + k * (gw + GAP), GAP) for k in range(n_gauges)]
    return project(os.path.join(LASER, "HexNode_v03_proto_1.8mm.lbrn2"), parts,
                   f"HexNode v03 one-node prototype, 1.8 mm acrylic: +5V strip, GND strip ({n_sets} set), {n_gauges} rail gauges. "
                   "Layer order: engrave labels (fill), inner cuts (magnet pockets, M3 terminal holes), outlines. "
                   "Set power and speed for your laser on all three layers.")


def rows(rows=(3, 2), n_gauges=2):
    """Small wall: one +5V and one GND strip per row, plus rail gauges, all on one 1.8 mm sheet."""
    T = "1.8mm"
    items = []
    for r, n in enumerate(rows, 1):
        for which in ("plus", "gnd"):
            items.append(read_dxf(os.path.join(LASER, f"Row{r}_{'odd' if r % 2 else 'even'}_{n}nodes_{which}_strip_{T}.dxf")))
    parts = stack(items)
    gauge = read_dxf(os.path.join(LASER, f"Rows{len(rows)}_rail_gauge.dxf"))
    sx = max(dx + bbox(l)[2] - bbox(l)[0] for l, dx, _ in parts) + GAP
    gw = bbox(gauge)[2] - bbox(gauge)[0]
    parts += [(gauge, sx + k * (gw + GAP), GAP) for k in range(n_gauges)]
    desc = ", ".join(f"row {r}: {n} nodes" for r, n in enumerate(rows, 1))
    name = "+".join(str(n) for n in rows)
    return project(os.path.join(LASER, f"HexNode_v03_rows_{name}_1.8mm.lbrn2"), parts,
                   f"HexNode v03 small wall ({desc}), 1.8 mm acrylic: a +5V strip (14 mm) and a GND strip (20 mm) per row, "
                   f"stacked bottom to top as row 1 +5V, row 1 GND, row 2 +5V, row 2 GND; {n_gauges} rail gauges for {len(rows)} rows. "
                   "Odd rows (1, 3, ...) and even rows (2, 4, ...) are different strips: even-row nodes sit half a node pitch (38 mm) along. "
                   "All strips share the LEFT end: line the rows up on a straight edge at the left, then space them with the rail gauges. "
                   "Each end has a 3.2 mm hole for an M3 screw + ring lug (run the copper tape over both holes) and the polarity engraved beyond it. "
                   "Layer order: engrave labels (fill), inner cuts (magnet pockets, terminal holes), outlines. "
                   "Set power and speed for your laser on all three layers.")


if __name__ == "__main__":
    import sys
    if "--proto" in sys.argv:
        print(proto())
    elif "--rows" in sys.argv:
        print(rows())
    else:
        for p in main():
            print(p)
