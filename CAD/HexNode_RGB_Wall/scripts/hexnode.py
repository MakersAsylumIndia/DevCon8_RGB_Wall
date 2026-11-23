"""Parametric HexNode holder for FreeCAD 1.x, driven by a `Params` spreadsheet.

A rebuild of `Hex_Node_02` (Hex_Node_holder) from the DevCon8 RGB Wall repo. The holder is a
flat frame that sits on top of an ESP32 DevKit V1 (header pins through two slots) and snaps
into the 54 mm hole of a 16-LED WS2812B ring through a V-groove at each end.

Run inside FreeCAD (GUI console, MCP `execute_code`, or freecadcmd):

    exec(open("<project>/scripts/hexnode.py").read())
    doc = build("HexNode_RGB_Wall")          # holder + reference ESP32 and LED ring
    print(verify(doc))                        # compare with the original Hex_Node_02 holder
    export_stl(doc, "<project>/export")
    export_step(doc, "<project>/export")

Every feature is a Part primitive or boolean whose dimensions and placements are expressions
on the spreadsheet, so editing a cell and recomputing rebuilds the holder.

Frame: origin at the centre of the ring and of the ESP32 PCB, Z = 0 on the PCB top face
(the holder's underside), X along the ESP32's length, Y across it.
"""
import os
import tempfile
import zipfile

import FreeCAD as App
import Part

PROJECT = os.path.expanduser("~/Documents/AI/FreeCAD_AI/HexNode_RGB_Wall")

# ---------------------------------------------------------------- parameters
# (alias, value, note). Inputs first, then derived cells ("=..." formulas).
INPUTS = [
    ("PlateT", "3.6", "Holder thickness"),
    ("Pitch", "2.54", "Header pin pitch"),
    ("Pins", "15", "Pins per header row (ESP32 DevKit V1, 30-pin)"),
    ("RowSpan", "25.4", "Header row spacing, centre to centre"),
    ("SlotOffX", "-1.96", "Header slot centre from PCB centre along X"),
    ("Wall", "1.6", "Side wall outside the slots, and web between slot and window"),
    ("EndR", "26", "Radius of the end arcs"),
    ("EndWall", "3.5", "End wall thickness between window and end arcs"),
    ("RingID", "54", "LED ring inner diameter (WS2812B 16-pixel ring)"),
    ("RingT", "1.5", "LED ring PCB thickness = V-groove width at RingID"),
    ("RingGrip", "0.6", "Holder reach past the ring's inner edge, each end"),
    ("GrooveH", "1.24", "V-groove half-opening at the holder edge (90 deg V)"),
    ("BossPCD", "40", "Screw boss pitch circle diameter"),
    ("BossD", "5.85", "Screw boss outer diameter"),
    ("HoleD", "2.65", "Screw hole diameter (M3 self-tapping)"),
]
DERIVED = [
    ("EndOff", "=RingID / 2 + RingGrip - EndR", "End-arc centres offset from the middle along X"),
    ("HalfW", "=RowSpan / 2 + Pitch / 2 + Wall", "Half-width of the holder (Y)"),
    ("SlotLen", "=Pins * Pitch", "Header slot length"),
    ("SlotW", "=Pitch", "Header slot width"),
    ("WinHalfW", "=RowSpan / 2 - Pitch / 2 - Wall", "Half-width of the central window"),
    ("WinR", "=EndR - EndWall", "Radius of the window end arcs"),
    ("NotchX", "=SlotOffX + SlotLen / 2 + Wall", "Window widens past this X (+X end)"),
    ("NotchHalfW", "=WinHalfW + Pitch", "Half-width of the widened window end"),
    ("GrooveZ", "=PlateT / 2", "V-groove centre height"),
    ("GrooveTipR", "=RingID / 2 - RingT / 2", "V-groove tip radius"),
    ("BossY", "=WinHalfW - HoleD / 2", "Boss centre |Y| (hole tangent to window side)"),
    ("BossX", "=sqrt((BossPCD / 2) ^ 2 - BossY ^ 2)", "Boss centre |X| (on the pitch circle)"),
    ("Big", "=2 * (EndR + EndOff) + 10", "Size of helper boxes"),
]


def _params(doc, overrides=None):
    sh = doc.addObject("Spreadsheet::Sheet", "Params")
    sh.set("A1", "Parameter"); sh.set("B1", "Value"); sh.set("C1", "Notes")
    overrides = overrides or {}
    for i, (alias, val, note) in enumerate(INPUTS + DERIVED, start=2):
        sh.set(f"A{i}", alias)
        sh.set(f"B{i}", str(overrides.get(alias, val)))
        sh.set(f"C{i}", note)
        sh.setAlias(f"B{i}", alias)
    doc.recompute()
    return sh


def _ex(obj, exprs):
    for prop, e in exprs.items():
        obj.setExpression(prop, e.replace("$", "Params."))


def _box(doc, name, x0, x1, y0, y1, z0="0", z1="$PlateT"):
    """Axis-aligned box between expression bounds."""
    o = doc.addObject("Part::Box", name)
    _ex(o, {"Length": f"({x1}) - ({x0})", "Width": f"({y1}) - ({y0})", "Height": f"({z1}) - ({z0})",
            "Placement.Base.x": x0, "Placement.Base.y": y0, "Placement.Base.z": z0})
    return o


def _cyl(doc, name, cx, cy, r, z0="0", z1="$PlateT"):
    o = doc.addObject("Part::Cylinder", name)
    _ex(o, {"Radius": r, "Height": f"({z1}) - ({z0})",
            "Placement.Base.x": cx, "Placement.Base.y": cy, "Placement.Base.z": z0})
    return o


def _bool(doc, typ, name, *objs):
    o = doc.addObject(typ, name)
    if typ in ("Part::Cut", "Part::Fuse", "Part::Common"):
        o.Base, o.Tool = objs
    else:
        o.Shapes = list(objs)
    if "Refine" in o.PropertiesList:
        o.Refine = True
    for s in objs:
        if hasattr(s, "Visibility"):
            s.Visibility = False
    return o


def _cone(doc, name, r1, r2, z0, z1):
    o = doc.addObject("Part::Cone", name)
    _ex(o, {"Radius1": r1, "Radius2": r2, "Height": f"({z1}) - ({z0})", "Placement.Base.z": z0})
    return o


def build_holder(doc):
    """Holder = (outline - window - slots - groove) + bosses - holes."""
    g = doc.addObject("App::DocumentObjectGroup", "HolderParts")
    parts = []

    def add(o):
        parts.append(o); return o

    # outline: |Y| <= HalfW, ends bounded by R=EndR arcs centred at X = +-EndOff
    band = add(_box(doc, "OutlineBand", "-$Big/2", "$Big/2", "-$HalfW", "$HalfW"))
    endA = add(_cyl(doc, "EndArcPos", "$EndOff", "0", "$EndR"))
    endB = add(_cyl(doc, "EndArcNeg", "-$EndOff", "0", "$EndR"))
    ends = add(_bool(doc, "Part::Fuse", "EndArcs", endA, endB))
    outline = add(_bool(doc, "Part::Common", "Outline", band, ends))

    # central window: |Y| <= WinHalfW, ends bounded by R=WinR arcs; widened to NotchHalfW at +X end
    wband = add(_box(doc, "WindowBand", "-$Big/2", "$Big/2", "-$WinHalfW", "$WinHalfW", "-1", "$PlateT + 1"))
    wA = add(_cyl(doc, "WindowArcPos", "$EndOff", "0", "$WinR", "-1", "$PlateT + 1"))
    wB = add(_cyl(doc, "WindowArcNeg", "-$EndOff", "0", "$WinR", "-1", "$PlateT + 1"))
    warcs = add(_bool(doc, "Part::Fuse", "WindowArcs", wA, wB))
    wmain = add(_bool(doc, "Part::Common", "WindowMain", wband, warcs))
    nband = add(_box(doc, "NotchBand", "$NotchX", "$Big/2", "-$NotchHalfW", "$NotchHalfW", "-1", "$PlateT + 1"))
    nArc = add(_cyl(doc, "NotchArc", "$EndOff", "0", "$WinR", "-1", "$PlateT + 1"))
    notch = add(_bool(doc, "Part::Common", "WindowNotch", nband, nArc))

    # header slots
    sx0, sx1 = "$SlotOffX - $SlotLen/2", "$SlotOffX + $SlotLen/2"
    slotP = add(_box(doc, "SlotPos", sx0, sx1, "$RowSpan/2 - $SlotW/2", "$RowSpan/2 + $SlotW/2", "-1", "$PlateT + 1"))
    slotN = add(_box(doc, "SlotNeg", sx0, sx1, "-$RowSpan/2 - $SlotW/2", "-$RowSpan/2 + $SlotW/2", "-1", "$PlateT + 1"))

    # V-groove for the ring's inner edge: everything at r >= GrooveTipR + |z - GrooveZ|
    # within GrooveZ +- GrooveH (an annulus minus an hourglass of two 45 deg cones)
    gz0, gz1 = "$GrooveZ - $GrooveH", "$GrooveZ + $GrooveH"
    gdisk = add(_cyl(doc, "GrooveDisk", "0", "0", "$Big", gz0, gz1))
    coneLo = add(_cone(doc, "GrooveConeLo", "$GrooveTipR + $GrooveH", "$GrooveTipR", gz0, "$GrooveZ"))
    coneHi = add(_cone(doc, "GrooveConeHi", "$GrooveTipR", "$GrooveTipR + $GrooveH", "$GrooveZ", gz1))
    hour = add(_bool(doc, "Part::Fuse", "GrooveHourglass", coneLo, coneHi))
    groove = add(_bool(doc, "Part::Cut", "Groove", gdisk, hour))

    cutters = add(_bool(doc, "Part::MultiFuse", "Cutters", wmain, notch, slotP, slotN, groove))
    plate = add(_bool(doc, "Part::Cut", "Plate", outline, cutters))

    # screw bosses on the pitch circle, holes tangent to the window sides
    pos = [("PP", "$BossX", "$BossY"), ("NP", "-$BossX", "$BossY"),
           ("PN", "$BossX", "-$BossY"), ("NN", "-$BossX", "-$BossY")]
    bosses = [add(_cyl(doc, f"Boss{n}", x, y, "$BossD/2")) for n, x, y in pos]
    holes = [add(_cyl(doc, f"Hole{n}", x, y, "$HoleD/2", "-1", "$PlateT + 1")) for n, x, y in pos]
    withb = add(_bool(doc, "Part::MultiFuse", "PlateBosses", plate, *bosses))
    hall = add(_bool(doc, "Part::MultiFuse", "Holes", *holes))
    holder = _bool(doc, "Part::Cut", "Holder", withb, hall)
    holder.Label = "Hex_Node_holder"
    for o in parts:
        g.addObject(o)
    return holder


def add_refs(doc, zip_path=None):
    """Load the ESP32 DevKit V1 and 16-LED ring (display only, from the original model)."""
    zip_path = zip_path or os.path.join(PROJECT, "ref", "reference_parts.zip")
    g = doc.addObject("App::DocumentObjectGroup", "Reference")
    tmp = tempfile.mkdtemp()
    with zipfile.ZipFile(zip_path) as z:
        z.extractall(tmp)
    for fn, name, label in [("esp32_devkitv1.brep", "ESP32", "ESP32_DevKitV1"),
                            ("led_ring_16.brep", "LEDRing", "LED_ring_16")]:
        s = Part.Shape(); s.read(os.path.join(tmp, fn))
        o = doc.addObject("Part::Feature", name); o.Shape = s; o.Label = label
        g.addObject(o)
    return g


def fix_display(doc):
    if not App.GuiUp:
        return
    colors = {"Holder": (0.55, 0.60, 0.70), "ESP32": (0.10, 0.12, 0.15), "LEDRing": (0.05, 0.05, 0.05)}
    for n, c in colors.items():
        o = doc.getObject(n)
        if o:
            o.ViewObject.ShapeAppearance = [App.Material(DiffuseColor=c)]


def build(doc_name="HexNode_RGB_Wall", params=None, refs=True):
    doc = App.newDocument(doc_name)
    _params(doc, params)
    build_holder(doc)
    if refs:
        add_refs(doc)
    doc.recompute()
    fix_display(doc)
    return doc


def verify(doc, original=None):
    """Compare the holder with the original Hex_Node_02 holder and check basic fits."""
    h = doc.getObject("Holder").Shape
    sh = doc.getObject("Params")
    out = {"valid": h.isValid(), "solids": len(h.Solids), "volume": round(h.Volume, 1),
           "bbox": [round(v, 2) for v in (h.BoundBox.XLength, h.BoundBox.YLength, h.BoundBox.ZLength)]}
    original = original or os.path.join(PROJECT, "ref", "Hex_Node_02_holder_original.brep")
    if os.path.exists(original):
        # booleans against the imported original are unreliable (coplanar faces), so sample
        # points on a grid at three heights (below, in, and above the groove) instead
        o = Part.Shape(); o.read(original)
        out["original_volume"] = round(o.Volume, 1)
        step, n, miss = 0.5, 0, 0
        for z in (0.3, sh.PlateT / 2, sh.PlateT - 0.3):
            for i in range(-58, 59):
                for j in range(-34, 35):
                    p = App.Vector(i * step, j * step, z)
                    n += 1
                    miss += h.isInside(p, 1e-6, True) != o.isInside(p, 1e-6, True)
        out["grid_mismatch"] = f"{miss}/{n} points"
    # grip on the ring: ring inner edge (r = RingID/2) must lie inside the holder's reach
    reach = sh.EndR + sh.EndOff
    out["ring_grip_mm"] = round(reach - sh.RingID / 2, 2)
    out["groove_inside_reach"] = sh.GrooveTipR + sh.GrooveH <= reach
    out["groove_tip_depth_mm"] = round(sh.RingID / 2 - sh.GrooveTipR, 2)
    # thinnest parts
    out["side_wall_mm"] = round(sh.HalfW - sh.RowSpan / 2 - sh.SlotW / 2, 2)
    out["lip_mm"] = round(sh.PlateT / 2 - sh.GrooveH, 2)
    # 0 in the original too: the boss edge touches the header slot
    out["boss_to_slot_mm"] = round(sh.RowSpan / 2 - sh.SlotW / 2 - sh.BossY - sh.BossD / 2, 2)
    return out


def export_stl(doc, outdir, prefix="HexNode_holder"):
    """Print file: lies flat as modelled (either face down), no supports."""
    import Mesh, MeshPart
    os.makedirs(outdir, exist_ok=True)
    s = doc.getObject("Holder").Shape
    m = MeshPart.meshFromShape(Shape=s, LinearDeflection=0.02, AngularDeflection=0.15, Relative=False)
    path = os.path.join(outdir, f"{prefix}.stl")
    m.write(path)
    return path


def export_step(doc, outdir, prefix="HexNode_holder", assembly=False):
    """Holder STEP. assembly=True also writes holder + ESP32 + ring (about 70 MB)."""
    import Import
    os.makedirs(outdir, exist_ok=True)
    paths = [os.path.join(outdir, f"{prefix}.step")]
    Import.export([doc.getObject("Holder")], paths[0])
    refs = [doc.getObject(n) for n in ("ESP32", "LEDRing") if doc.getObject(n)]
    if assembly and refs:
        paths.append(os.path.join(outdir, "HexNode_assembly.step"))
        Import.export([doc.getObject("Holder")] + refs, paths[1])
    return paths
