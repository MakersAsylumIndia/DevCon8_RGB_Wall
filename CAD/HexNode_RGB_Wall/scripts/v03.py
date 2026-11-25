"""HexNode RGB Wall, version 03: magnetic whiteboard, acrylic power rails, one-piece magnetic bracket.

Frame (all parts, assembled): X along the row, Y up the wall, Z out of the wall towards the viewer.
The whiteboard face is at z = 0. The node centre (LED ring centre) is at x = y = 0.

Wall
  Each row has two laser-cut acrylic strips (RailT thick) held to the whiteboard by 10x10x2 magnets
  in pockets, with 10 mm copper tape along each strip. The +5V strip (top) is narrower than the GND
  strip (bottom), so a node only seats the right way up.

Node
  Bracket   one printed part. A tongue between the two strips carries four 10x10x2 magnets (pocket
            variant; the embedded variant is archived in archive/v03_embed/), lips outside the strips key the widths, and two sprung tabs carry
            copper tape (wire sandwiched between two layers) onto the rails.
  Carrier   one printed part, superglued on top of the bracket and located by two short pieces of
            1.75 mm filament (dowels). Holds the ESP32 by its header strips (press fit) and the
            LED ring at its ID and OD (four sprung clips, +/- RingTol).
"""
import math
import os

import FreeCAD as App
import Part

import wall
import v02
from wall import V, _box, _feature, _group, _link

V03_INPUTS = [
    # rails and wall
    ("NodePitch3", "76", "Node pitch along a row (rows are offset by half of it)"),
    ("RailT", "1.8", "Acrylic rail strip thickness"),
    ("PlusW", "14", "+5V strip width (top, narrow)"),
    ("GndW", "20", "GND strip width (bottom, wide): the width difference keys the polarity"),
    ("TapeW", "10", "Copper tape width"),
    ("TapeT", "0.1", "Copper tape thickness"),
    ("MagS", "10", "Magnet side (square)"),
    ("MagT", "2", "Magnet thickness"),
    ("AcrMagHole", "9.75", "Magnet pocket in the acrylic strip, as drawn: 10.0 drawn cut to 10.25, so 9.75 cuts to ~10.0 for a tight fit on 10 mm magnets"),
    ("ProtoX0", "-46", "Prototype strip: start, x from the node centre (room for the engraved label)"),
    ("ProtoX1", "57", "Prototype strip: end, x from the node centre"),
    ("ProtoHoleX", "50", "Prototype strip: 3 mm terminal hole, x (on the tape centre line)"),
    ("ProtoHoleD", "3", "Prototype strip terminal hole (M3 screw + spade lug)"),
    ("ProtoTextH", "6", "Engraved label height"),
    ("StripLen", "570", "Acrylic strip length (a whole number of magnet pitches; bed >= 600)"),
    ("RailClr", "0.3", "Clearance each side between bracket and strip"),
    # bracket
    ("TongueW", "13", "Bracket tongue (between the strips) width"),
    ("BrMagPitch", "13", "Bracket magnet pitch along the tongue"),
    ("BrWall", "1.5", "Bracket wall round the end magnets"),
    ("MagPocket", "10.15", "Printed magnet pocket (tight fit, dab of superglue)"),
    ("PryW", "4", "Pry notch width, in one side of each magnet pocket (pocket variant)"),
    ("PryD", "1.0", "Pry notch depth into the pocket wall (the tongue wall there is 1.4)"),
    ("EmbedSkin", "0.5", "Embedded variant: skin between magnet and whiteboard (pocket top lands on a 0.2 mm layer: pause at Z 4.2)"),
    ("LipT", "1.6", "Keying lip thickness (outside each strip)"),
    ("LipLift", "0.3", "Lips stop short of the board, so only the tongue sits on it"),
    ("PlateZ0", "2.5", "Bracket plate underside (clears tape over the magnets, 2.1)"),
    ("PlateT", "2.0", "Bracket plate thickness"),
    ("CtTabW", "10", "Contact tab width (= copper tape width)"),
    ("CtTabL", "14.5", "Contact tab length (cantilever along the rail)"),
    ("CtTabT", "1.2", "Contact tab thickness"),
    ("CtGap", "1.0", "Slot along the sides of the contact tab"),
    ("CtEndGap", "2.5", "Slot beyond the tab's free end (room to wrap the copper tape round it)"),
    ("CtRootX", "4.5", "Contact tab root (fixed end), x: the tab windows stay clear of the JST pockets"),
    ("CtPadL", "6", "Contact pad length at the free end"),
    ("CtPreload", "0.4", "Tab deflection when seated (pad bottom below the tape surface). Was 1.2: the pads stood 0.8 mm taller and the tabs flexed too far"),
    ("CtGrooveW", "1.8", "Wire groove along the tab top to the bracket edge (and under the base, same line)"),
    ("CtGrooveD", "0.7", "Wire groove depth (bracket top; the base underside has the same)"),
    ("RivetHole", "2.1", "Filament rivet holes: 1.75 filament pushed in by hand (2.0 printed too tight), through all three parts"),
    ("RivetCh", "0.3", "Small chamfer on print-bed faces (elephant foot)"),
    ("RivetHeadCh", "0.35", "Larger chamfer at the magnet end of the bracket holes (heat-formed rivet head)"),
    ("RivetHeadChDeck", "0.6", "Larger chamfer on the deck's flat face (heat-formed rivet head)"),
    ("KeyPlusW", "12", "+5V wall: one notch this wide (bracket); the +5V strip has matching tabs"),
    ("KeyGndW", "6", "GND wall: two notches this wide (bracket); the GND strip has matching tabs"),
    ("KeyGndGap", "10", "Gap between the two GND notches"),
    ("KeyClr", "0.3", "Rail tab clearance each side in its notch"),
    ("KeyP", "1.5", "Rail tab: how far it sticks out from the strip's outer edge"),
    ("SignL", "6", "Debossed + and - signs: bar length"),
    ("SignW", "1.2", "Sign bar width"),
    ("SignD", "0.4", "Sign depth (unused: the signs now cut right through)"),
    ("SignX", "-19", "x of the + and - signs, cut through the bracket and the base in line"),
    # carrier
    ("CarT", "2.0", "Carrier plate thickness"),
    ("DetentD", "2.4", "Locating detent cone base diameter (plate top; sockets in the post ends)"),
    ("DetentH", "0.8", "Locating detent height"),
    ("DetentClr", "0.15", "Detent socket clearance"),
    ("ChanW", "4.5", "Wire channels on the base top, from each JST pocket to the USB-end edge"),
    ("ChanD", "1.5", "Wire channel depth"),
    ("JstW", "9.8", "JST XH 3P housing: flange (lip at the wire end) length along the header (ref/XH_housing_3P.step)"),
    ("JstBodyW", "8.2", "JST housing body length along the header"),
    ("JstLatch", "2.33", "Pin line to the latch ribs (-y side on both housings)"),
    ("JstBodyL", "1.53", "Pin line to the body face on the latch side (the flange ends here too)"),
    ("JstBodyF", "2.57", "Pin line to the body face on the flange side (+y)"),
    ("JstFlange", "3.37", "Pin line to the flange edge on the flange side (+y)"),
    ("JstFlangeT", "0.6", "Flange (lip) thickness at the wire end"),
    ("JstH", "7.75", "JST housing height (mating face against the ESP32 header plastic, wire end down)"),
    ("JstClr", "0.1", "Clearance round the JST housing body and flange in its pocket (snug slide-in)"),
    ("JstGrooveClr", "0.25", "Clearance above and below the flange in the wall groove"),
    ("JstLipClr", "0.2", "Clearance round the flange (lip) edges in the wall groove"),
    ("JstWall", "2.0", "JST pocket wall thickness at the body (the flange groove takes 0.8 of it)"),
    ("JstWallTopClr", "0.2", "JST pocket walls stop this far below the ESP32 header plastic"),
    ("PinSlotW", "1.2", "Slot in a pocket wall where a neighbouring header pin passes down through it"),
    ("JstGap", "13.5", "Carrier plate top to ESP32 PCB back (header + JST housings)"),
    ("DeckT3", "2.0", "Deck under the ESP32 (header strips press into its slots)"),
    ("DeckR", "25.8", "Deck clipped to this radius, so the ring passes over it"),
    ("DeckHalfW3", "15.2", "Deck half-width"),
    ("DeckEdgeExtra", "1.6", "Extra width outside the header slots at the antenna end (stiffens the thin strip)"),
    ("DeckCornerR", "26.5", "Deck radius at the two thin corners by the header slot ends (antenna end)"),
    ("RingDrop", "2.0", "Ring LED face below the ESP32 PCB back (LED tops clear the board corners)"),
    ("HdrSlotW3", "2.6", "Header strip slot width"),
    ("LedRingID", "54", "LED ring PCB inner diameter: measure yours"),
    ("LedRingOD", "68", "LED ring PCB outer diameter: measure yours"),
    ("LedRingT", "1.6", "LED ring PCB thickness"),
    ("RingTol", "1.0", "Clips accept ID and OD within +/- this (diameter)"),
    ("LedCount", "16", "LEDs on the ring: clips sit in the gaps between them"),
    ("ClipAng", "56.25", "Clip seat angle from the ESP32 long axis (an LED gap)"),
    ("ClipPre", "0.3", "Hook preload at the largest OD"),
    ("SeatW", "5", "Clip seat width"),
    ("ArmW", "1.4", "Clip spring arm width"),
    ("ArmH", "3", "Clip spring arm height"),
    ("RingHookW", "4", "Clip hook width"),
    ("LipD", "1.0", "Hook lip overlap on the ring's LED face"),
    ("LipH", "1.2", "Hook lip thickness"),
    ("LipClr", "0.15", "Clearance under the hook lip"),
    # wiring (reference parts, not printed)
    ("RingTwist", "-90", "LED ring turned about the node axis (a multiple of 22.5) so its 4 pads sit in the clip gap at the USB end"),
    ("WireD", "1.2", "Hook-up wire outside diameter (JST XH pigtails, 26 AWG)"),
    ("WasherOD", "25", "Touch washer outside diameter"),
    ("WasherID", "10", "Touch washer hole"),
    ("WasherT", "1.5", "Touch washer thickness (assumed: measure yours)"),
    ("FoamT", "3", "Laser-cut foam disc between the ESP32 shield and the washer (diameter = WasherOD)"),
    ("LabelH", "3.2", "Raised PWR / LED letter (cap) height on the base top, beside the JST pockets"),
    ("LabelD", "0.6", "Raised (embossed) text height above the base top"),
]

SLOT_LEN, SLOT_OFF_X = 38.1, -1.96            # ESP32 header strips (15 pins), from the PCB centre
JST = [(13.25, -12.7), (13.25, 12.7)]        # power (VIN GND D13) row at the bottom, 3V3 GND D15 at the top
COLORS = {"BracketPocket": (0.15, 0.15, 0.15), "BracketEmbed": (0.30, 0.30, 0.30), "Carrier3": (0.92, 0.92, 0.92),
          "CarrierBase": (0.92, 0.92, 0.92), "CarrierDeck": (0.75, 0.85, 0.95)}


# ---------------------------------------------------------------- params
def _sheet(doc):
    sh = doc.getObject("V03Params") or doc.addObject("Spreadsheet::Sheet", "V03Params")
    sh.set("A1", "Parameter"); sh.set("B1", "Value"); sh.set("C1", "Notes")
    for i, (a, v, n) in enumerate(V03_INPUTS, start=2):
        sh.set(f"A{i}", a)
        if sh.getAlias(f"B{i}") != a:
            sh.set(f"B{i}", v)
            sh.setAlias(f"B{i}", a)
        sh.set(f"C{i}", n)
    doc.recompute()
    return sh


def params(doc=None):
    p = {}
    sh = doc.getObject("V03Params") if doc else None
    for a, v, _ in V03_INPUTS:
        if sh:
            x = sh.get(a)
            p[a] = float(getattr(x, "Value", x))
        else:
            p[a] = float(v)
    return derive(p)


def derive(p):
    p["RowPitch3"] = p["NodePitch3"] * math.sqrt(3) / 2
    p["MagPitch"] = p["NodePitch3"] / 2                    # rail magnets: same pattern under every node
    band = 2 * p["LipT"] + 4 * p["RailClr"] + p["PlusW"] + p["TongueW"] + p["GndW"]
    p["Band"] = band
    yt = band / 2
    p["PlusY1"] = yt - p["LipT"] - p["RailClr"]
    p["PlusY0"] = p["PlusY1"] - p["PlusW"]
    p["TongueY1"] = p["PlusY0"] - p["RailClr"]
    p["TongueY0"] = p["TongueY1"] - p["TongueW"]
    p["GndY1"] = p["TongueY0"] - p["RailClr"]
    p["GndY0"] = p["GndY1"] - p["GndW"]
    p["PlusYc"] = (p["PlusY0"] + p["PlusY1"]) / 2
    p["GndYc"] = (p["GndY0"] + p["GndY1"]) / 2
    p["TongueYc"] = (p["TongueY0"] + p["TongueY1"]) / 2
    p["TapeTop"] = p["RailT"] + p["TapeT"]
    p["BrTop"] = p["PlateZ0"] + p["PlateT"]
    p["BrHalfL"] = 1.5 * p["BrMagPitch"] + p["MagS"] / 2 + p["BrWall"]
    p["CarBed"] = p["BrTop"]
    p["CarTop"] = p["CarBed"] + p["CarT"]
    p["Zpcb"] = p["CarTop"] + p["JstGap"]                   # ESP32 PCB back
    p["RingFront"] = p["Zpcb"] - p["RingDrop"]              # ring LED face
    p["RingBack"] = p["RingFront"] - p["LedRingT"]
    return p


def ring_p(p):
    """Params for v02.ring_clip: it builds from zb upwards, 'RingZ0' = the ring face nearest the base."""
    q = dict(p)
    q["RingZ0"] = p["RingBack"]
    return q


def tabs(p):
    """(y centre, name) of the two contact tabs."""
    return [(p["PlusYc"], "plus"), (p["GndYc"], "gnd")]


def rivets(p):
    """Filament rivets: in the walls between the bracket magnets, on the tongue centre line (off the
    node centre, so the parts only line up one way)."""
    m = p["BrMagPitch"]
    return [(-m, p["TongueYc"]), (0.0, p["TongueYc"]), (m, p["TongueYc"])]


def rivet_hole(p, x, y, z0, z1, ch0=0.0, ch1=0.0):
    """Hole z0..z1 with optional chamfers (countersinks) at the z0 and z1 ends."""
    r = p["RivetHole"] / 2
    h = Part.makeCylinder(r, z1 - z0 + 2, V(x, y, z0 - 1))
    if ch0 > 0:
        h = h.fuse(Part.makeCone(r + ch0 + 1, r, ch0 + 1, V(x, y, z0 - 1)))
    if ch1 > 0:
        h = h.fuse(Part.makeCone(r, r + ch1 + 1, ch1 + 1, V(x, y, z1 - ch1)))
    return h


def sign_through(p, kind, x, y, z0, z1):
    """+ or - cut right through a part, from z0 to z1."""
    L, w = p["SignL"], p["SignW"]
    out = [_box(x - L / 2, x + L / 2, y - w / 2, y + w / 2, z0 - 1, z1 + 1)]
    if kind == "+":
        out.append(_box(x - w / 2, x + w / 2, y - L / 2, y + L / 2, z0 - 1, z1 + 1))
    return out


def sign(p, kind, x, y, z, into=-1):
    """Debossed + or - at (x, y) on a face at height z; into = -1 for a face looking up (+Z),
    +1 for a face looking down."""
    L, w, d = p["SignL"], p["SignW"], p["SignD"]
    z0, z1 = (z - d, z + 1) if into < 0 else (z - 1, z + d)
    out = [_box(x - L / 2, x + L / 2, y - w / 2, y + w / 2, z0, z1)]
    if kind == "+":
        out.append(_box(x - w / 2, x + w / 2, y - L / 2, y + L / 2, z0, z1))
    return out


def key_xs(p):
    """Notch / rail-tab centres relative to a node centre: (+5V list, GND list)."""
    g = (p["KeyGndGap"] + p["KeyGndW"]) / 2
    return [0.0], [-g, g]


def mag_xs(p):
    m = p["BrMagPitch"]
    return [-1.5 * m, -0.5 * m, 0.5 * m, 1.5 * m]


def _prism_xz(pts, y0, y1):
    w = Part.makePolygon([V(x, y0, z) for x, z in pts] + [V(pts[0][0], y0, pts[0][1])])
    return Part.Face(w).extrude(V(0, y1 - y0, 0))


def _rounded_rect(x0, x1, y0, y1, z0, z1, r):
    b = _box(x0, x1, y0, y1, z0, z1)
    for cx, sx in ((x0 + r, -1), (x1 - r, 1)):
        for cy, sy in ((y0 + r, -1), (y1 - r, 1)):
            corner = _box(min(cx, cx + sx * r), max(cx, cx + sx * r), min(cy, cy + sy * r), max(cy, cy + sy * r), z0 - 1, z1 + 1)
            b = b.cut(corner.cut(Part.makeCylinder(r, z1 - z0 + 2, V(cx, cy, z0 - 1))))
    return b


# ---------------------------------------------------------------- rails (wall)
def rail_parts(p, x0, x1, y_off=0.0):
    """Acrylic strips, copper tape and rail magnets for one row, x0..x1, row centre at y_off."""
    T, h = p["RailT"], p["AcrMagHole"] / 2
    out = {"acrylic": [], "tape": [], "magnets": []}
    n = int(round((x1 - x0) / p["MagPitch"]))
    xs = [x0 + p["MagPitch"] * (k + 0.5) for k in range(n)]
    for ya, yb in ((p["PlusY0"], p["PlusY1"]), (p["GndY0"], p["GndY1"])):
        yc = (ya + yb) / 2 + y_off
        s = _box(x0, x1, ya + y_off, yb + y_off, 0, T)
        plus = ya == p["PlusY0"]
        s = s.fuse(_rail_tabs(p, x0, x1, (yb if plus else ya) + y_off, 1 if plus else -1, 0, T))
        s = s.cut([_box(x - h, x + h, yc - h, yc + h, -1, T + 1) for x in xs])
        out["acrylic"].append(s)
        zt = max(T, p["MagT"])            # drawn flat over the magnet tops (it dips 0.2 between them)
        out["tape"].append(_box(x0, x1, yc - p["TapeW"] / 2, yc + p["TapeW"] / 2, zt, zt + p["TapeT"]))
        m = p["MagS"] / 2
        out["magnets"] += [_box(x - m, x + m, yc - m, yc + m, 0, p["MagT"]) for x in xs]
    return out


def _rail_tabs(p, x0, x1, y_edge, out, z0, z1, full_only=False):
    """Key tabs on a strip's outer edge (out = +1 up, -1 down), every MagPitch, clipped to x0..x1.
    Tab centres sit on node centres (x = 0 mod MagPitch), like the bracket's notches."""
    plus_x, gnd_x = key_xs(p)
    xs, w = (plus_x, p["KeyPlusW"]) if out > 0 else (gnd_x, p["KeyGndW"])
    w -= 2 * p["KeyClr"]
    m = p["MagPitch"]
    tabs_ = []
    for k in range(int(math.floor(x0 / m)) - 1, int(math.ceil(x1 / m)) + 2):
        for dx in xs:
            a, b = max(k * m + dx - w / 2, x0), min(k * m + dx + w / 2, x1)
            if b - a > 0.05 and (not full_only or b - a > w - 0.01):
                y0, y1 = sorted((y_edge - out * 0.01, y_edge + out * p["KeyP"]))
                tabs_.append(_box(a, b, y0, y1, z0, z1))
    return tabs_


def strip_2d(p, which):
    """Laser outline of one strip, as a flat solid at z 0..RailT (x 0..StripLen), key tabs on the
    outer edge (+5V: top, GND: bottom)."""
    L = p["StripLen"]
    w = p["PlusW"] if which == "plus" else p["GndW"]
    out = 1 if which == "plus" else -1
    s = _box(0, L, -w / 2, w / 2, 0, p["RailT"]).fuse(_rail_tabs(p, 0, L, out * w / 2, out, 0, p["RailT"]))
    n = int(round(L / p["MagPitch"]))
    h = p["AcrMagHole"] / 2
    return s.cut([_box(p["MagPitch"] * (k + 0.5) - h, p["MagPitch"] * (k + 0.5) + h, -h, h, -1, 5) for k in range(n)])


def rail_gauge(p, n_rows=2):
    """Laser-cut comb: lay it across the board, push the strips into its gaps, tape them down.
    Sets the gap between a row's strips (tongue) and the row pitch. 2D solid, x across, y up the wall."""
    yt = p["Band"] / 2 + 8
    yb = -p["Band"] / 2 - (n_rows - 1) * p["RowPitch3"] - 8
    g = _box(0, 22, yb, yt, 0, 2)          # fingers 10 wide: they fit between the strips' key tabs
    c = 0.1
    for r in range(n_rows):
        yo = -r * p["RowPitch3"]
        for ya, yb2 in ((p["PlusY0"], p["PlusY1"]), (p["GndY0"], p["GndY1"])):
            g = g.cut(_box(12, 23, ya + yo - c, yb2 + yo + c, -1, 3))
    return g


# ---------------------------------------------------------------- prototype rails (one node)
FONT = "/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf"


def proto_strip(p, which):
    """One-node strip, node centre at x = 0: magnet pockets, full key tabs only, M3 terminal hole at
    one end on the tape centre line. Flat solid z 0..RailT, strip centre line at y = 0."""
    x0, x1 = p["ProtoX0"], p["ProtoX1"]
    w = p["PlusW"] if which == "plus" else p["GndW"]
    out = 1 if which == "plus" else -1
    s = _box(x0, x1, -w / 2, w / 2, 0, p["RailT"]).fuse(_rail_tabs(p, x0, x1, out * w / 2, out, 0, p["RailT"], True))
    h, m = p["AcrMagHole"] / 2, p["MagPitch"]
    for k in range(int(math.floor(x0 / m)) - 1, int(math.ceil(x1 / m)) + 1):
        xc = (k + 0.5) * m
        if x0 + h + 2 <= xc - 0 and xc + h + 2 <= x1:
            s = s.cut(_box(xc - h, xc + h, -h, h, -1, 5))
    s = s.cut(Part.makeCylinder(p["ProtoHoleD"] / 2, 10, V(p["ProtoHoleX"], 0, -1)))
    return s.removeSplitter()


# ---------------------------------------------------------------- row rails (odd / even rows)
ROW_HOLE_D = 3.2      # wire terminal hole at each row end (M3 screw + ring lug)
ROW_HOLE_OUT = None   # hole centre beyond the outermost node centre; None = half a node pitch (38)
ROW_LUG_R = 3.5       # clearance radius kept free around a hole (lug / screw head)
ROW_LABEL_L = 20.0    # label zone beyond the hole


def row_nodes(p, row, n):
    """Node centres (wall x) of row `row` (1-based). Odd rows start at x = 0, even rows half a pitch along."""
    x0 = 0.0 if row % 2 else p["NodePitch3"] / 2
    return [x0 + k * p["NodePitch3"] for k in range(n)]


def row_ends(p, row, n, rows=None):
    """(left end, left hole, right hole, right end) in wall x. Every row's LEFT end is at the same x, so odd
    and even strips line up along the left edge. With `rows` (node count per row of the whole set) every
    strip also ends where the longest row ends, so all strips are the same length."""
    out = ROW_HOLE_OUT if ROW_HOLE_OUT is not None else p["NodePitch3"] / 2
    zone = ROW_LUG_R + 1.5 + ROW_LABEL_L + 1.0
    hl = -out                                          # odd row's first node is at 0
    rows = rows or {row: n}
    hr = max(row_nodes(p, r, k)[-1] for r, k in (rows.items() if isinstance(rows, dict) else enumerate(rows, 1))) + out
    return hl - zone, hl, hr, hr + zone


def row_label(p, which, xc):
    txt = "+5V" if which == "plus" else "GND"
    chars = Part.makeWireString(txt, FONT, p["ProtoTextH"], 0)
    wires = [w for c in chars for w in c]
    bb = Part.makeCompound(wires).BoundBox
    for w in wires:
        w.translate(V(xc - bb.Center.x, -bb.Center.y, 0))
    return wires


def row_strip(p, which, row, n, rows=None):
    """Rail strip for row `row` with n nodes, in wall x: magnet pockets every MagPitch between the end
    holes, full key tabs, a 3.2 mm terminal hole on the tape centre line at each end, and the polarity
    engraved beyond each hole. Returns (solid z 0..RailT with centre line y = 0, label wires)."""
    xl, hl, hr, xr = row_ends(p, row, n, rows)
    w = p["PlusW"] if which == "plus" else p["GndW"]
    out = 1 if which == "plus" else -1
    s = _box(xl, xr, -w / 2, w / 2, 0, p["RailT"]).fuse(_rail_tabs(p, xl, xr, out * w / 2, out, 0, p["RailT"], True))
    h, m = p["AcrMagHole"] / 2, p["MagPitch"]
    keep = ROW_HOLE_D / 2 + 2.0
    for k in range(int(math.floor(xl / m)) - 1, int(math.ceil(xr / m)) + 1):
        xc = (k + 0.5) * m
        if hl + keep <= xc - h and xc + h <= hr - keep:
            s = s.cut(_box(xc - h, xc + h, -h, h, -1, 5))
    for x in (hl, hr):
        s = s.cut(Part.makeCylinder(ROW_HOLE_D / 2, 10, V(x, 0, -1)))
    gap = ROW_LUG_R + 1.5 + ROW_LABEL_L / 2
    labels = row_label(p, which, hl - gap) + row_label(p, which, hr + gap)
    return s.removeSplitter(), labels


def proto_label(p, which):
    """Engraved label outlines (closed wires) at the strip's label end, beyond the tape."""
    txt = "+5V" if which == "plus" else "GND"
    chars = Part.makeWireString(txt, FONT, p["ProtoTextH"], 0)
    wires = [w for c in chars for w in c]
    bb = Part.makeCompound(wires).BoundBox
    xc = p["ProtoX0"] + 1.5 + bb.XLength / 2              # left end, clear of the tape (it starts at -26)
    for w in wires:
        w.translate(V(xc - bb.Center.x, -bb.Center.y, 0))
    return wires


def export_rows(doc, outdir, rows=(3, 2)):
    """Laser DXFs for a small wall: a +5V and a GND strip per row (rows[i] nodes in row i+1; odd and even
    rows differ by half a node pitch) and a rail gauge spanning all the rows. All strips start at the
    same wall x, so they line up along their left ends."""
    p = params(doc)
    ldir = os.path.join(outdir, "laser"); os.makedirs(ldir, exist_ok=True)
    for f in os.listdir(ldir):
        if f.startswith("Row") and f.endswith(".dxf"):
            os.remove(os.path.join(ldir, f))
    xy = lambda v: (v.x, v.y)
    paths = []
    for r, n in enumerate(rows, 1):
        kind = "odd" if r % 2 else "even"
        for which in ("plus", "gnd"):
            s, labels = row_strip(p, which, r, n, rows)
            loops = v02._loops(s, V(0, 0, 1), p["RailT"] / 2, xy)
            for w in labels:
                loops.append(("ENGRAVE", [xy(v) for v in w.discretize(Deflection=0.02)]))
            paths.append(v02._dxf(os.path.join(ldir, f"Row{r}_{kind}_{n}nodes_{which}_strip_{p['RailT']}mm.dxf"), loops))
    g = rail_gauge(p, len(rows))
    paths.append(v02._dxf(os.path.join(ldir, f"Rows{len(rows)}_rail_gauge.dxf"), v02._loops(g, V(0, 0, 1), 1, xy)))
    return paths


def export_proto(doc, outdir):
    """Laser DXFs for a one-node prototype: +5V strip, GND strip, rail gauge (one row)."""
    p = params(doc)
    ldir = os.path.join(outdir, "laser"); os.makedirs(ldir, exist_ok=True)
    xy = lambda v: (v.x, v.y)
    paths = []
    for which, n in (("plus", "Proto_plus_strip"), ("gnd", "Proto_gnd_strip")):
        s = proto_strip(p, which)
        loops = v02._loops(s, V(0, 0, 1), p["RailT"] / 2, xy)
        for w in proto_label(p, which):
            loops.append(("ENGRAVE", [xy(v) for v in w.discretize(Deflection=0.02)]))
        paths.append(v02._dxf(os.path.join(ldir, f"{n}_{p['RailT']}mm.dxf"), loops))
    g = rail_gauge(p, 1)
    paths.append(v02._dxf(os.path.join(ldir, "Proto_rail_gauge.dxf"), v02._loops(g, V(0, 0, 1), 1, xy)))
    return paths


# ---------------------------------------------------------------- bracket
def bracket(p, variant="pocket"):
    H, yt = p["BrHalfL"], p["Band"] / 2
    z0, zt = p["PlateZ0"], p["BrTop"]
    s = _rounded_rect(-H, H, -yt, yt, z0, zt, 2.0)
    s = s.fuse([_box(-H, H, p["TongueY0"], p["TongueY1"], 0, z0 + 0.01),
                _box(-H, H, yt - p["LipT"], yt, p["LipLift"], z0 + 0.01),
                _box(-H, H, -yt, -yt + p["LipT"], p["LipLift"], z0 + 0.01)])
    # lead-in chamfers on the lips' inner bottom edges and the tongue's bottom edges
    c = 0.6
    for y, d, zb in ((yt - p["LipT"], 1, p["LipLift"]), (-yt + p["LipT"], -1, p["LipLift"]),
                     (p["TongueY1"], -1, 0.0), (p["TongueY0"], 1, 0.0)):
        e = 0.01
        tri = Part.Face(Part.makePolygon([V(-H - 1, y - d * e, zb - e), V(-H - 1, y + d * c, zb - e),
                                          V(-H - 1, y - d * e, zb + c + e), V(-H - 1, y - d * e, zb - e)]))
        s = s.cut(tri.extrude(V(2 * H + 2, 0, 0)))
    # magnets in the tongue
    m = p["MagPocket"] / 2
    yc = p["TongueYc"]
    for x in mag_xs(p):
        if variant == "pocket":
            s = s.cut(_box(x - m, x + m, yc - m, yc + m, -1, p["MagT"] + 0.05))
            # pry notch in one side wall (GND side), full pocket depth: wedge a screwdriver in to lever it out
            w = p["PryW"] / 2
            s = s.cut(_box(x - w, x + w, yc - m - p["PryD"], yc - m + 0.01, -1, p["MagT"] + 0.05))
        else:
            s = s.cut(_box(x - m, x + m, yc - m, yc + m, p["EmbedSkin"], p["EmbedSkin"] + p["MagT"] + 0.1))
    # contact tabs: U slot, tab, pad with ramps, wire groove on top
    W, L, T, g = p["CtTabW"], p["CtTabL"], p["CtTabT"], p["CtGap"]
    xr = p["CtRootX"]
    xf = xr - L
    zpad = p["TapeTop"] - p["CtPreload"]
    for yc_t, _ in tabs(p):
        s = s.cut(_box(xf - p["CtEndGap"], xr, yc_t - W / 2 - g, yc_t + W / 2 + g, z0 - 1, zt + 1))
        tab = _box(xf, xr + 0.01, yc_t - W / 2, yc_t + W / 2, zt - T, zt)
        r = 1.6
        pad = _prism_xz([(xf, zt - T + 0.01), (xf + p["CtPadL"], zt - T + 0.01), (xf + p["CtPadL"] - r, zpad), (xf + r, zpad)],
                        yc_t - W / 2, yc_t + W / 2)
        s = s.fuse([tab, pad])
        s = s.cut(_box(xf + 2, H + 1, yc_t - p["CtGrooveW"] / 2, yc_t + p["CtGrooveW"] / 2, zt - p["CtGrooveD"], zt + 1))
    # polarity notches in the lips: one wide on +5V, two narrow on GND
    plus_x, gnd_x = key_xs(p)
    for xs, w, y0, y1 in ((plus_x, p["KeyPlusW"], yt - p["LipT"] - 0.01, yt + 1), (gnd_x, p["KeyGndW"], -yt - 1, -yt + p["LipT"] + 0.01)):
        s = s.cut([_box(x - w / 2, x + w / 2, y0, y1, -1, z0) for x in xs])
    # filament rivets: big chamfer at the magnet (board) end, small one on the bed face (top)
    for x, y in rivets(p):
        s = s.cut(rivet_hole(p, x, y, 0, zt, p["RivetHeadCh"], p["RivetCh"]))
    # + and - cut right through, in line with the same signs in the carrier base
    for (yc_t, name), k in zip(tabs(p), "+-"):
        s = s.cut(sign_through(p, k, p["SignX"], yc_t, z0, zt))
    return s.removeSplitter()


def magnets_node(p):
    m = p["MagS"] / 2
    yc = p["TongueYc"]
    return [_box(x - m, x + m, yc - m, yc + m, 0, p["MagT"]) for x in mag_xs(p)]


# ---------------------------------------------------------------- carrier
def deck(p):
    z1 = p["Zpcb"]; z0 = z1 - p["DeckT3"]
    hw = p["DeckHalfW3"]
    d = _box(-p["DeckR"], p["DeckR"], -hw, hw, z0, z1).common(Part.makeCylinder(p["DeckR"], z1 - z0, V(0, 0, z0)))
    # thicker round the header slot ends at the antenna end (the thin wall there broke)
    R = p["DeckCornerR"]
    for sy in (-1, 1):
        y0, y1 = sorted((sy * 9.0, sy * hw))
        d = d.fuse(_box(-R, -15, y0, y1, z0, z1).common(Part.makeCylinder(R, z1 - z0, V(0, 0, z0))))
        # and wider outside the slot there (the strip between slot and edge is the weak part)
        e0, e1 = sorted((sy * (hw - 0.01), sy * (hw + p["DeckEdgeExtra"])))
        d = d.fuse(_box(-R, -15, e0, e1, z0, z1).common(Part.makeCylinder(R, z1 - z0, V(0, 0, z0))))
    L = SLOT_LEN + 0.4
    for sy in (-1, 1):
        d = d.cut(_box(SLOT_OFF_X - L / 2, SLOT_OFF_X + L / 2, sy * 12.7 - p["HdrSlotW3"] / 2, sy * 12.7 + p["HdrSlotW3"] / 2, z0 - 1, z1 + 1))
    d = d.cut(_box(21.9, 24.5, -4.8, 4.8, z1 - 0.5, z1 + 1))      # USB socket through-tab relief
    return d


def _posts(p, z0, z1):
    """One block between the base and the deck: carries the three rivets, clear of the header pins,
    the JST pockets and the wire channels."""
    return [_box(-15.5, 21.5, -2.0, 8.0, z0, z1)]


def detents(p):
    """Base-to-deck locating detents (off centre): cones on the base top, sockets in the block end."""
    return [(-7.0, -0.5), (18.0, 1.0)]


def _cone(x, y, z, r0, r1, h):
    return Part.makeCone(r0, r1, h, V(x, y, z))


def windows(p):
    """Base windows over the contact tabs (room to flex, wires drop through): (x0, x1, y0, y1)."""
    W, L, g = p["CtTabW"], p["CtTabL"], p["CtGap"]
    xr = p["CtRootX"]
    return [(xr - L - p["CtEndGap"] - 0.5, xr + 1.5, yc - W / 2 - g - 0.5, yc + W / 2 + g + 0.5) for yc, _ in tabs(p)]


def channels(p):
    """Wire channels on the base top, each beside its tab window on the centre side: (y0, y1).
    They run in x from the JST pocket to the USB-end edge only (see chan_x)."""
    (_, _, py0, _), (_, _, _, gy1) = windows(p)
    return [(py0 - p["ChanW"], py0), (gy1, gy1 + p["ChanW"])]


def chan_x(p):
    """x extent of the wire channels: from the JST pocket's inner end wall face to the USB-end edge."""
    return JST[0][0] - p["JstW"] / 2 - p["JstClr"], p["BrHalfL"] + 1


JST_STEP = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "ref", "XH_housing_3P.step")
_JST_CACHE = {}


def jst_shape():
    """JST XH 3P crimp housing (with contacts) as supplied: pins along x at 0, 2.5, 5; pin line y = 0;
    mating face (pin entry) at z = 2.05, wire end with its flange at z = 9.8, latch bump on +y."""
    if "s" not in _JST_CACHE:
        sh = Part.Shape(); sh.read(JST_STEP)
        _JST_CACHE["s"] = sh
    return _JST_CACHE["s"].copy()


def jst_housings(p):
    """Both housings as fitted, the same way round: plugged onto the three header pins nearest the USB end,
    mating face up against the header plastic, wire end (flange) down, latch ribs towards -y, flange lip
    towards +y. Each slides into its pocket from the open side, the lip running in the wall groove."""
    out = []
    for x, y in JST:
        h = jst_shape()
        h.translate(V(-2.5, 0, -2.05))
        h.rotate(V(0, 0, 0), V(1, 0, 0), 180)      # mating face looks +Z, latch to -y
        h.translate(V(x, y, p["Zpcb"] - 2.5))
        out.append(h)
    return out


def jst_boxes(p):
    """Envelope of each fitted housing."""
    zt = p["Zpcb"] - 2.5                       # mating face meets the header plastic
    return [_box(x - p["JstW"] / 2, x + p["JstW"] / 2, y - p["JstLatch"], y + p["JstFlange"], zt - p["JstH"], zt) for x, y in JST]


def _jst_cavity(p, x, y, sy, reach=8.0):
    """Body slot plus flange groove, both run out through the open side (towards the node centre)."""
    c, gc = p["JstClr"], p["JstGrooveClr"]
    zt = p["Zpcb"] - 2.5
    zf0, zf1 = zt - p["JstH"], zt - p["JstH"] + p["JstFlangeT"]
    lc = p["JstLipClr"]
    bw, fw = p["JstBodyW"] / 2 + c, p["JstW"] / 2 + lc
    by0, by1 = y - p["JstLatch"] - c, y + p["JstBodyF"] + c          # body (with latch ribs)
    fy0, fy1 = y - p["JstBodyL"] - lc, y + p["JstFlange"] + lc       # flange
    if sy > 0:                                  # open side is -y
        by0, fy0 = by0 - reach, fy0 - reach
    else:                                       # open side is +y
        by1, fy1 = by1 + reach, fy1 + reach
    return (_box(x - bw, x + bw, by0, by1, p["CarTop"] - 1, zt + 5)
            .fuse(_box(x - fw, x + fw, fy0, fy1, zf0 - gc, zf1 + gc)))


def jst_pockets(p):
    """Three thick walls round each housing (both ends and the back), open on the side facing the node
    centre and the wire channel. A groove in the walls at flange height takes the housing's lip, so the
    housing slides in from the open side and is held up and down. Returns (walls, recesses)."""
    walls, rec = [], []
    c, T = p["JstClr"], p["JstWall"]
    z0, z1 = p["CarTop"] - 0.01, p["Zpcb"] - 2.5 - p["JstWallTopClr"]   # up to the header plastic
    pin_xs = [SLOT_OFF_X + (i - 7) * 2.54 for i in range(15)]
    pin_tip = p["Zpcb"] - 7.5
    chans = channels(p)
    for x, y in JST:
        sy = 1 if y > 0 else -1
        cy0, cy1 = [ch for ch in chans if (ch[0] + ch[1]) * sy > 0][0]
        ch_edge = cy1 if sy > 0 else cy0           # channel edge next to the pocket
        xo = p["JstBodyW"] / 2 + c + T             # end walls: outer faces
        if sy > 0:
            yo = y + p["JstBodyF"] + c + T          # back wall outer face (flange side)
            yi = y - p["JstLatch"] - c              # open side
        else:
            yo = y - p["JstLatch"] - c - T          # back wall outer face (latch side)
            yi = y + p["JstFlange"] + p["JstLipClr"]   # open side: the lip sticks out to here
        yend = ch_edge if sy * (ch_edge - yi) > 0 else yi   # walls stop at the channel
        w = _box(x - xo, x + xo, *sorted((yo, yend)), z0, z1).cut(_jst_cavity(p, x, y, sy))
        # slot where a header pin outside the housing comes down through an end wall
        for px in pin_xs:
            if abs(px - x) > p["JstBodyW"] / 2 + c and abs(px - x) < xo + 0.6:
                w = w.cut(_box(px - 0.6, px + 0.6, y - p["PinSlotW"] / 2, y + p["PinSlotW"] / 2, pin_tip - 0.5, z1 + 1))
        walls.append(w)
        # floor recess under the housing body and on to the channel: room for the wires to bend out
        yb = y + p["JstBodyF"] + c if sy > 0 else y - p["JstLatch"] - c
        far = ch_edge if sy * (yi - ch_edge) > 0 else yi
        bw = p["JstBodyW"] / 2 + c
        rec.append(_box(x - bw, x + bw, *sorted((yb, far)), p["CarTop"] - p["ChanD"], p["CarTop"] + 0.01))
    return walls, rec


def carrier_base(p):
    """Carrier part A (prints plate down): plate, ring clips, tab windows, wire channels, JST pockets,
    rivet holes, detent cones, + and - signs."""
    H, yt = p["BrHalfL"], p["Band"] / 2
    zb, zt = p["CarBed"], p["CarTop"]
    s = _rounded_rect(-H, H, -yt, yt, zb, zt, 3.0)
    q = ring_p(p)
    r_in = q["LedRingID"] / 2 - q["RingTol"] / 2 - 0.2 - 1.2
    s = s.fuse([v02.ring_clip(q, ts, th, zb, r_in, p["CarT"]) for ts, th in v02.stations(q)])
    walls, rec = jst_pockets(p)
    s = s.fuse(walls)
    for x0, x1, y0, y1 in windows(p):
        s = s.cut(_box(x0, x1, y0, y1, zb - 1, zt + 1))
    cx0, cx1 = chan_x(p)
    for y0, y1 in channels(p):
        s = s.cut(_box(cx0, cx1, y0, y1, zt - p["ChanD"], zt + 0.01))
    s = s.cut(rec)
    # underside wire channels on the tab lines, matching the bracket's grooves
    for yc_t, _ in tabs(p):
        s = s.cut(_box(-H - 1, H + 1, yc_t - p["CtGrooveW"] / 2, yc_t + p["CtGrooveW"] / 2, zb - 1, zb + p["CtGrooveD"]))
    for x, y in rivets(p):
        s = s.cut(rivet_hole(p, x, y, zb, zt, p["RivetCh"], 0))
    for (yc_t, _), k in zip(tabs(p), "+-"):
        s = s.cut(sign_through(p, k, p["SignX"], yc_t, zb, zt))
    s = s.fuse(labels(p))
    r, h = p["DetentD"] / 2, p["DetentH"]
    s = s.fuse([_cone(x, y, zt - 0.01, r, r - h * 0.7, h + 0.01) for x, y in detents(p)])
    return s.removeSplitter()


# Base top, in the strip between each JST pocket and the USB-end edge (x 19.8-25.6 is clear of features).
# PWR stops at y -17.2: the yellow touch wire crosses the strip at y -17.95, just above the base top.
LABEL_AREAS = {"LED": (19.8, 25.6, 10.6, 20.0), "PWR": (19.8, 25.6, -17.2, -7.8)}
LABEL_FONT = "/usr/share/fonts/truetype/liberation/LiberationSansNarrow-Bold.ttf"   # narrow: taller letters fit


def labels(p):
    """Raised (embossed) PWR and LED on the base top, beside each JST pocket, reading up the node (+y).
    Letters are LabelH tall (cap height), shrunk only if they would not fit their area. Returns solids to fuse."""
    out = []
    zt = p["CarTop"]
    for txt, (x0, x1, y0, y1) in LABEL_AREAS.items():
        chars = Part.makeWireString(txt, LABEL_FONT, 10.0, 0)
        faces = [Part.makeFace(c, "Part::FaceMakerBullseye") for c in chars]
        f = Part.makeCompound(faces)
        f.rotate(V(0, 0, 0), V(0, 0, 1), 90)
        bb = f.BoundBox
        k = min(p["LabelH"] / bb.XLength, 0.94 * (y1 - y0) / bb.YLength, 0.94 * (x1 - x0) / bb.XLength)
        m = App.Matrix(); m.scale(k, k, 1)
        f = f.transformGeometry(m)
        bb = f.BoundBox
        f.translate(V((x0 + x1) / 2 - bb.Center.x, (y0 + y1) / 2 - bb.Center.y, zt - 0.01))
        out += [fc.extrude(V(0, 0, p["LabelD"] + 0.01)) for fc in f.Faces]
    return out


def carrier_deck(p):
    """Carrier part B (prints deck face down, block up): deck, one block, detent sockets, rivet holes."""
    zt, zd = p["CarTop"], p["Zpcb"] - p["DeckT3"]
    s = deck(p).fuse(_posts(p, zt, zd + 0.01))
    c = p["DetentClr"]
    r, h = p["DetentD"] / 2 + c, p["DetentH"] + c
    s = s.cut([_cone(x, y, zt - 0.01, r, r - h * 0.7, h + 0.01) for x, y in detents(p)])
    for x, y in rivets(p):
        s = s.cut(rivet_hole(p, x, y, zt, p["Zpcb"], 0, p["RivetHeadChDeck"]))
    return s.removeSplitter()


def carrier(p):
    """Both carrier parts together, as assembled (for the demo and the checks)."""
    return carrier_base(p).fuse(carrier_deck(p))


# ---------------------------------------------------------------- references
def esp_pl(p, x=0.0, y=0.0):
    """v02 holder frame -> v03 frame (front faces +Z): ESP32 PCB back at Zpcb."""
    return App.Placement(V(x, y, p["Zpcb"]), App.Rotation(V(1, 0, 0), 180))


def ring_pl(p, x=0.0, y=0.0):
    flip = App.Placement(V(), App.Rotation(V(1, 0, 0), 180))
    return App.Placement(V(x, y, p["RingFront"] + 1.05), App.Rotation(V(0, 0, 1), p["RingTwist"])).multiply(flip)


def jst_env(p):
    return jst_housings(p)


def placed(doc, name, pl):
    s = doc.getObject(name).Shape.copy()
    s.Placement = pl.multiply(s.Placement)
    return s


# ---------------------------------------------------------------- wiring (reference)
RING_PADS_CCW = ("DIN", "VCC", "GND", "DOUT")   # ring pads by angle, CCW seen from the front (circuit diagram)
WIRE_COLORS = {"red": (0.85, 0.10, 0.10), "black": (0.08, 0.08, 0.08), "yellow": (0.95, 0.80, 0.10)}


def ring_pads(doc, p):
    """{name: (x, y, z of the pad face)} for the ring's four back pads, as placed."""
    R = placed(doc, "LEDRing", ring_pl(p))
    zb = R.BoundBox.ZMin
    pads = [s for s in R.Solids if 0.08 < s.Volume < 0.12 and s.BoundBox.ZMax < zb + 0.1]
    pads.sort(key=lambda s: math.atan2(s.BoundBox.Center.y, s.BoundBox.Center.x))
    assert len(pads) == 4, len(pads)
    return {n: (s.BoundBox.Center.x, s.BoundBox.Center.y, s.BoundBox.ZMin) for n, s in zip(RING_PADS_CCW, pads)}


def shield(doc, p):
    """(x, y centre, z top) of the ESP32-WROOM metal shield, as placed."""
    E = placed(doc, "ESP32", esp_pl(p))
    sh = max((s for s in E.Solids if s.BoundBox.ZMin > p["Zpcb"] + 1.0), key=lambda s: s.Volume)
    b = sh.BoundBox
    return b.Center.x, b.Center.y, b.ZMax


def touch_parts(doc, p):
    """Foam disc on the shield, washer on the foam. Returns (foam, washer, washer top z, centre)."""
    x, y, zt = shield(doc, p)
    R = p["WasherOD"] / 2
    foam = Part.makeCylinder(R, p["FoamT"], V(x, y, zt))
    z1 = zt + p["FoamT"]
    washer = Part.makeCylinder(R, p["WasherT"], V(x, y, z1)).cut(Part.makeCylinder(p["WasherID"] / 2, p["WasherT"] + 2, V(x, y, z1 - 1)))
    return foam, washer, z1 + p["WasherT"], (x, y)


def _clean(pts):
    q = [V(*pts[0])]
    for a in pts[1:]:
        if (V(*a) - q[-1]).Length > 1e-6:
            q.append(V(*a))
    return q


def wire_path(pts, R=1.5, frac=0.48):
    """Route polyline -> smooth G1 wire (straight runs + tangent arcs). Each bend gets radius R
    (about 1.25x the wire OD, a natural hand-formed bend), reduced where the neighbouring runs are short."""
    q = _clean(pts)
    n = len(q)
    edges, cur = [], q[0]
    for i in range(1, n - 1):
        a, b, c = q[i - 1], q[i], q[i + 1]
        u, v = a - b, c - b
        la, lc = u.Length, v.Length
        u.normalize(); v.normalize()
        ang = math.acos(max(-1.0, min(1.0, u.dot(v))))
        th = math.pi - ang                                  # turn angle
        if th < 1e-4:
            continue
        d = min(R * math.tan(th / 2), la * (frac if i > 1 else 0.95), lc * (frac if i < n - 2 else 0.95))
        r = d / math.tan(th / 2)
        p0, p1 = b + u * d, b + v * d
        bis = u + v; bis.normalize()
        ctr = b + bis * (r / math.sin(ang / 2))
        mid = ctr + ((p0 + p1) * 0.5 - ctr).normalize() * r
        if (p0 - cur).Length > 1e-6:
            edges.append(Part.LineSegment(cur, p0).toShape())
        edges.append(Part.Arc(p0, mid, p1).toShape())
        cur = p1
    if (q[-1] - cur).Length > 1e-6:
        edges.append(Part.LineSegment(cur, q[-1]).toShape())
    return Part.Wire(edges)


def _wire(pts, r):
    """Plain swept wire along the same smooth path (checks, and the model when the Cables workbench is absent)."""
    w = wire_path(pts)
    e0 = w.OrderedEdges[0]
    t0 = e0.tangentAt(e0.FirstParameter)
    prof = Part.Wire(Part.makeCircle(r, w.OrderedVertexes[0].Point, t0))
    return [w.makePipeShell([prof], True, True)]


def wire_routes(doc, p):
    """The six JST pigtail wires as routed: [(name, colour, polyline points)].
    PWR housing (VIN GND D13): red and black out to the +5V and GND contact tabs (in the tab groove,
    ending on the top of the tab), yellow up the side of the ESP32 to the touch washer.
    LED housing (3V3 GND D15): red, black, yellow up to the ring's VCC, GND and DIN pads.
    Wires leave each housing straight down, run in the floor recess and the channel to the USB-end edge."""
    r = p["WireD"] / 2
    zf = p["CarTop"] - p["ChanD"] + r                     # lying on the channel floor
    zg = p["BrTop"]                                       # tab groove tunnel centre (bracket top / base bottom)
    xe = p["BrHalfL"] + 1.0                               # just past the USB-end edge
    (cp0, cp1), (cg0, cg1) = channels(p)
    out = []
    for (x0, y0), role in zip(JST, ("PWR", "LED")):
        zs = p["Zpcb"] - 2.5 - p["JstH"] + 2.5            # inside the housing, at the contact crimp
        ch = (cg0, cg1) if y0 < 0 else (cp0, cp1)
        cm = (ch[0] + ch[1]) / 2
        step = 1.4 if y0 < 0 else -1.4                    # pin 1 takes the lane nearest the pocket
        lanes = [cm - step, cm, cm + step]
        for k, (col, xp) in enumerate(zip(("red", "black", "yellow"), (x0 + 2.5, x0, x0 - 2.5))):
            yl = lanes[k]
            pts = [(xp, y0, zs), (xp, y0, zf), (xp, yl, zf), (xe, yl, zf)]
            out.append((f"{role}_{k + 1}_{col}", col, pts))
    pts = {n: q for n, _, q in out}
    tabs_y = dict((n, yc) for yc, n in tabs(p))
    xt = p["CtRootX"] - p["CtTabL"] + 2.6                 # wire end on the tab top, by the pad
    # PWR red (VIN) -> +5V tab: over the other wires, round to the tab line, in along the groove
    q = pts["PWR_1_red"]; yl = q[-1][1]; xr = xe + 0.9
    q += [(xr, yl, zf), (xr, yl, zf + 2.0), (xr, tabs_y["plus"], zf + 2.0), (xr, tabs_y["plus"], zg), (xt, tabs_y["plus"], zg)]
    # PWR black (GND) -> GND tab
    q = pts["PWR_2_black"]; yl = q[-1][1]; xb = xe + 2.2
    q += [(xb, yl, zf), (xb, tabs_y["gnd"], zf), (xb, tabs_y["gnd"], zg), (xt, tabs_y["gnd"], zg)]
    # PWR yellow (D13) -> touch washer: back over the base top beside the pocket, up past the ESP32's side
    foam, washer, zw, (wx, wy) = touch_parts(doc, p)
    q = pts["PWR_3_yellow"]; yl = q[-1][1]
    q[-1] = (xe - 0.3, yl, zf)
    xu, yu = 18.5, -17.95                                 # riser: outside the pocket wall, inside the ring ID
    zo = p["CarTop"] + r + 0.3
    zt = zw + r
    d = V(xu - wx, yu - wy, 0); d.normalize()
    q += [(xe - 0.3, yl, zo), (xe - 0.3, yu, zo), (xu, yu, zo), (xu, yu, zt), (wx + d.x * 8.5, wy + d.y * 8.5, zt)]
    # LED wires -> ring pads (pad face from below), staggered so they do not cross
    pads = ring_pads(doc, p)
    def under(n, rr=30.8):
        x, y, z = pads[n]; a = math.atan2(y, x)
        return rr * math.cos(a), rr * math.sin(a), z
    xs = xe + 2.3                                         # LED risers: clear of the PWR red run at xe + 0.9
    vx, vy, vz = under("DIN")
    q = pts["LED_3_yellow"]; yl = q[-1][1]
    q += [(vx, yl, zf), (vx, vy, zf), (vx, vy, vz)]
    gx, gy, gz = under("GND")
    q = pts["LED_2_black"]; yl = q[-1][1]
    q += [(xs, yl, zf), (xs, yl, zf + 2.4), (gx, gy, zf + 2.4), (gx, gy, gz)]
    cx, cy, cz = under("VCC")
    q = pts["LED_1_red"]; yl = q[-1][1]; xo = cx + 1.1
    q += [(xs, yl, zf), (xs, yl, zf + 4.4), (xo, yl, zf + 4.4), (xo, cy, zf + 4.4), (cx, cy, zf + 4.4), (cx, cy, cz)]
    return out


def wiring(doc, p):
    """[(name, colour, solids)]: the routed wires as straight cylinders (used for checks without the Cables workbench)."""
    r = p["WireD"] / 2
    return [(n, c, _wire(q, r)) for n, c, q in wire_routes(doc, p)]


# ---------------------------------------------------------------- document
def make_parts(doc, p):
    g = _group(doc, "V03Parts")
    _feature(doc, "BracketPocket", bracket(p, "pocket"), g, "Bracket_v03_pocket")
    _feature(doc, "Carrier3", carrier(p), g, "Carrier_v03 (both parts, assembled)")
    _feature(doc, "CarrierBase", carrier_base(p), g, "Carrier_v03_A_base")
    _feature(doc, "CarrierDeck", carrier_deck(p), g, "Carrier_v03_B_deck")
    _feature(doc, "NodeMagnets", Part.makeCompound(magnets_node(p)), g, "Node_magnets_x4")
    _feature(doc, "JSTEnv3", Part.makeCompound(jst_env(p)), g, "JST_XH_3P_housings")
    _feature(doc, "PlusStrip", strip_2d(p, "plus"), g, f"Plus_strip_{p['RailT']}mm")
    _feature(doc, "GndStrip", strip_2d(p, "gnd"), g, f"Gnd_strip_{p['RailT']}mm")
    _feature(doc, "RailGauge", rail_gauge(p), g, "Rail_gauge")
    for o in g.Group:
        o.Visibility = False


def node_xy(p, rows, per_row):
    out = []
    for r in range(rows):
        y = -r * p["RowPitch3"]
        x0 = p["NodePitch3"] / 2 + (p["NodePitch3"] / 2 if r % 2 else 0)
        n = per_row - (r % 2)
        out += [(r, i, x0 + i * p["NodePitch3"], y) for i in range(n)]
    return out


MAT = {"board": (0.95, 0.95, 0.93), "acrylic": (0.75, 0.88, 0.95), "tape": (0.85, 0.50, 0.25),
       "magnets": (0.55, 0.55, 0.60), "wire_r": (0.85, 0.10, 0.10), "wire_k": (0.08, 0.08, 0.08), "smps": (0.35, 0.40, 0.45)}


def _color(o, c, t=0):
    if App.GuiUp:
        o.ViewObject.ShapeAppearance = [App.Material(DiffuseColor=c)]
        o.ViewObject.Transparency = t


def _cables():
    """The Cables workbench (sargo-devel/Cables) modules, or None. Its WireFlex view provider needs the GUI."""
    if not App.GuiUp:
        return None
    try:
        from freecad.cables import archCable
        return archCable
    except Exception:
        return None


CU = (0.80, 0.50, 0.20)
STRIP = 2.0          # stripped, bare copper at each wire end (on the tab, at the ring pad, in the crimp)


def _cable(doc, ac, n, c, pts, p, g):
    """One single-conductor 26 AWG cable (Cables workbench) on the smooth route; colours set per face."""
    path = doc.addObject("Part::Feature", f"WPath_{n}")
    path.Shape = wire_path(pts)
    path.Label = f"WirePath_{n}"
    g.addObject(path)
    cb = ac.makeCable(baseobj=path, gauge=0.13, name=f"Wire_{n}")          # 26 AWG = 0.13 mm2
    cb.InsulationThickness = (p["WireD"] - 2 * math.sqrt(0.13 / math.pi)) / 2
    cb.StrippedWireLength = STRIP
    g.addObject(cb)
    doc.recompute()
    if App.GuiUp:
        path.ViewObject.Visibility = False
        vo = cb.ViewObject
        if hasattr(vo, "UseMaterialColor"):
            vo.UseMaterialColor = False
        sa = []
        for i, so in enumerate(cb.Shape.Solids):
            sa += [App.Material(DiffuseColor=WIRE_COLORS[c] if i == 0 else CU)] * len(so.Faces)
        vo.ShapeAppearance = sa
    return cb


def make_wiring(doc, p):
    """Wires: Cables-workbench cables when FreeCAD runs with its GUI and the workbench is installed,
    otherwise plain swept solids on the same smooth paths."""
    g = _group(doc, "V03Wiring")
    for o in list(g.Group):
        if doc.getObject(o.Name):
            doc.removeObject(o.Name)
    ac = _cables()
    for n, c, pts in wire_routes(doc, p):
        if ac:
            _cable(doc, ac, n, c, pts, p, g)
        else:
            _color(_feature(doc, f"Wire_{n}", Part.makeCompound(_wire(pts, p["WireD"] / 2)), g, f"Wire_{n}"), WIRE_COLORS[c])
    foam, washer, _, _ = touch_parts(doc, p)
    _color(_feature(doc, "TouchFoam", foam, g, "Touch_foam_3mm"), (0.25, 0.45, 0.85))
    _color(_feature(doc, "TouchWasher", washer, g, "Touch_washer_25x10"), (0.78, 0.78, 0.80))
    return g


def cable_wiring(doc):
    """GUI step after a headless rebuild: replace the plain wires with Cables-workbench cables and relink the demo wall."""
    p = params(doc)
    make_wiring(doc, p)
    make_demo(doc, p)
    make_exploded(doc, p)
    doc.recompute()
    style(doc)
    return p


def make_demo(doc, p, rows=2, per_row=4):
    g = _group(doc, "V03Demo")
    for o in list(g.Group):
        doc.removeObject(o.Name)
    L = per_row * p["NodePitch3"] + p["MagPitch"] * 0
    L = round(L / p["MagPitch"]) * p["MagPitch"]
    ylo = -(rows - 1) * p["RowPitch3"] - 60
    board = _box(-120, L + 40, ylo, 60, -3, 0)
    _color(_feature(doc, "V3Board", board, g, "Whiteboard"), MAT["board"])
    parts = {"acrylic": [], "tape": [], "magnets": []}
    for r in range(rows):
        rp = rail_parts(p, 0, L, -r * p["RowPitch3"])
        for k in parts:
            parts[k] += rp[k]
    for k, c in (("acrylic", MAT["acrylic"]), ("tape", MAT["tape"]), ("magnets", MAT["magnets"])):
        _color(_feature(doc, f"V3Rail_{k}", Part.makeCompound(parts[k]), g, f"Rails_{k}"), c, 40 if k == "acrylic" else 0)
    # SMPS at the left, + and GND to each row; GND rows also looped together at the right
    sm = _box(-110, -60, -40, 0, 0, 30)
    _color(_feature(doc, "V3SMPS", sm, g, "SMPS_5V_5A"), MAT["smps"])
    wr, red, blk = 0.7, [], []
    def wire(pts, out):
        for a, b in zip(pts, pts[1:]):
            a, b = V(*a), V(*b)
            out.append(Part.makeCylinder(wr, (b - a).Length, a, b - a))
            out.append(Part.makeSphere(wr, b))
    for r in range(rows):
        yo = -r * p["RowPitch3"]
        zt = p["TapeTop"] + wr
        wire([(-60, -8, 15), (-30, yo + p["PlusYc"], zt + 2), (5, yo + p["PlusYc"], zt)], red)
        wire([(-60, -30, 15), (-35, yo + p["GndYc"], zt + 2), (5, yo + p["GndYc"], zt)], blk)
    for r in range(rows - 1):
        y0, y1 = -r * p["RowPitch3"] + p["GndYc"], -(r + 1) * p["RowPitch3"] + p["GndYc"]
        zt = p["TapeTop"] + wr
        wire([(L - 5, y0, zt), (L + 20, y0, 4), (L + 20, y1, 4), (L - 5, y1, zt)], blk)
    _color(_feature(doc, "V3WireRed", Part.makeCompound(red), g, "Wires_5V"), MAT["wire_r"])
    _color(_feature(doc, "V3WireBlk", Part.makeCompound(blk), g, "Wires_GND"), MAT["wire_k"])
    br, car = doc.getObject("BracketPocket"), doc.getObject("Carrier3")
    for r, i, x, y in node_xy(p, rows, per_row):
        pl = App.Placement(V(x, y, 0), App.Rotation())
        _link(doc, f"V3Br_r{r}_{i}", br, pl, g)
        _link(doc, f"V3Mag_r{r}_{i}", doc.getObject("NodeMagnets"), pl, g)
        _link(doc, f"V3Car_r{r}_{i}", car, pl, g)
        _link(doc, f"V3ESP_r{r}_{i}", doc.getObject("ESP32"), esp_pl(p, x, y), g)
        _link(doc, f"V3Ring_r{r}_{i}", doc.getObject("LEDRing"), ring_pl(p, x, y), g)
        _link(doc, f"V3JST_r{r}_{i}", doc.getObject("JSTEnv3"), pl, g)
        for o in doc.getObject("V03Wiring").Group:
            if not o.Name.startswith("WPath_"):
                _link(doc, f"V3W_{o.Name}_r{r}_{i}", o, pl, g)


def make_exploded(doc, p):
    g = _group(doc, "ExplodedNodeV03")
    for o in list(g.Group):
        doc.removeObject(o.Name)
    x0 = -260
    rp = rail_parts(p, x0 - 76, x0 + 76)
    _color(_feature(doc, "X3Board", _box(x0 - 90, x0 + 90, -60, 60, -3, 0), g, "X_whiteboard"), MAT["board"])
    for k, c in (("acrylic", MAT["acrylic"]), ("tape", MAT["tape"]), ("magnets", MAT["magnets"])):
        _color(_feature(doc, f"X3Rail_{k}", Part.makeCompound(rp[k]), g, f"X_rails_{k}"), c, 40 if k == "acrylic" else 0)
    steps = [("NodeMagnets", 12), ("BracketPocket", 30), ("CarrierBase", 55), ("CarrierDeck", 115)]
    for n, dz in steps:
        _link(doc, f"X3_{n}", doc.getObject(n), App.Placement(V(x0, 0, dz), App.Rotation()), g)
    _link(doc, "X3_Ring", doc.getObject("LEDRing"), App.Placement(V(0, 0, 150), App.Rotation()).multiply(ring_pl(p, x0, 0)), g)
    _link(doc, "X3_ESP", doc.getObject("ESP32"), App.Placement(V(0, 0, 190), App.Rotation()).multiply(esp_pl(p, x0, 0)), g)
    _link(doc, "X3_JST", doc.getObject("JSTEnv3"), App.Placement(V(x0, 0, 85), App.Rotation()), g)
    _link(doc, "X3_Foam", doc.getObject("TouchFoam"), App.Placement(V(x0, 0, 200), App.Rotation()), g)
    _link(doc, "X3_Washer", doc.getObject("TouchWasher"), App.Placement(V(x0, 0, 210), App.Rotation()), g)
    # wire harness lifted with the JST housings it is crimped into
    for o in doc.getObject("V03Wiring").Group:
        if o.Label.startswith("Wire_") and not o.Name.startswith("WPath_"):
            _link(doc, f"X3_{o.Label}", o, App.Placement(V(x0, 0, 85), App.Rotation()), g)


def style(doc):
    if not App.GuiUp:
        return
    for n, c in COLORS.items():
        o = doc.getObject(n)
        if o:
            _color(o, c)
    o = doc.getObject("NodeMagnets")
    if o:
        _color(o, MAT["magnets"])


def build(doc, rows=2, per_row=4):
    _sheet(doc)
    p = params(doc)
    make_parts(doc, p)
    make_wiring(doc, p)
    make_demo(doc, p, rows, per_row)
    make_exploded(doc, p)
    doc.recompute()
    style(doc)
    return p


# ---------------------------------------------------------------- checks
def checks(doc, p):
    out = {}
    esp, ring = placed(doc, "ESP32", esp_pl(p)), placed(doc, "LEDRing", ring_pl(p))
    br, car = doc.getObject("BracketPocket").Shape, doc.getObject("Carrier3").Shape
    rp = rail_parts(p, -114, 114)
    rails = Part.makeCompound(rp["acrylic"] + rp["tape"] + rp["magnets"])
    vol = lambda a, b: round(a.common(b).Volume, 2)
    out["bracket_x_rails"] = vol(br, rails)
    # pads only: expected overlap = preload (they push the tabs up)
    out["pad_overlap_expected"] = round(2 * p["CtTabW"] * (p["CtPadL"] - 1.6) * p["CtPreload"], 1)
    flip = br.copy(); flip.rotate(V(0, 0, 0), V(0, 0, 1), 180)
    out["flipped_bracket_x_rails"] = vol(flip, rails)
    out["bracket_x_node_magnets"] = vol(br, Part.makeCompound(magnets_node(p)))
    sh = br.copy(); sh.translate(V(10, 0, 0))
    out["bracket_moved_10mm_x_rail_tabs"] = vol(sh, rails)          # off the 38 mm grid: the key tabs block it
    out["base_x_deck"] = vol(doc.getObject("CarrierBase").Shape, doc.getObject("CarrierDeck").Shape)
    out["esp_pins_x_jst_walls"] = vol(esp, Part.makeCompound(jst_pockets(p)[0]))
    out["carrier_x_bracket"] = vol(car, br)
    out["carrier_x_esp"] = vol(car, esp)
    out["carrier_x_ring"] = vol(car, ring)
    out["carrier_x_jst"] = vol(car, Part.makeCompound(jst_env(p)))
    walls = Part.makeCompound(jst_pockets(p)[0])
    out["jst_to_pocket_walls_min_gap"] = [round(h.distToShape(walls)[0], 3) for h in jst_env(p)]
    out["jst_x_esp"] = vol(Part.makeCompound(jst_env(p)), esp)
    slide = []
    for h, (x, y) in zip(jst_env(p), JST):
        d = -1 if y > 0 else 1                       # out through the open side
        hs = [h.copy() for _ in range(4)]
        for k, q in enumerate(hs):
            q.translate(V(0, d * 2.0 * (k + 1), 0))
        slide.append(max(vol(q, walls) for q in hs))
    out["jst_slide_out_x_walls"] = slide
    lift = [h.copy() for h in jst_env(p)]
    for q in lift:
        q.translate(V(0, 0, 0.5))
    out["jst_lifted_0.5_x_walls (lip held)"] = [vol(q, walls) for q in lift]
    wl = wiring(doc, p)
    hous = Part.makeCompound(jst_env(p))
    parts = {"bracket": br, "base": doc.getObject("CarrierBase").Shape, "deck": doc.getObject("CarrierDeck").Shape,
             "esp": esp, "ring": ring}
    foam, washer, _, _ = touch_parts(doc, p)
    parts["foam"], parts["washer"] = foam, washer
    wx = {}
    for n, _, sol in wl:
        w = Part.makeCompound(sol)
        hits = {k: vol(w, v) for k, v in parts.items()}
        wx[n] = {k: v for k, v in hits.items() if v > 0.001}
    out["wires_x_parts"] = wx
    ww = {}
    for i in range(len(wl)):
        for j in range(i + 1, len(wl)):
            v = vol(Part.makeCompound(wl[i][2]), Part.makeCompound(wl[j][2]))
            if v > 0.001:
                ww[f"{wl[i][0]}~{wl[j][0]}"] = v
    out["wire_x_wire"] = ww
    out["foam_x_esp"] = vol(foam, esp)
    out["washer_x_ring"] = vol(washer, ring)
    out["ring_pads"] = {k: [round(c, 2) for c in v] for k, v in ring_pads(doc, p).items()}
    out["jst_bottom_to_base_top"] = round(min(h.BoundBox.ZMin for h in jst_env(p)) - p["CarTop"], 2)
    out["rivet_wall_to_magnet_pocket"] = round((p["BrMagPitch"] - p["MagPocket"]) / 2 - p["RivetHole"] / 2 - p["RivetHeadCh"], 3)
    out["esp_x_ring"] = vol(esp, ring)
    out["ring_x_jst"] = vol(ring, Part.makeCompound(jst_env(p)))
    # ring tolerance: annuli at the extremes
    q = ring_p(p)
    res = {}
    for di in (-1, 0, 1):
        for do in (-1, 0, 1):
            ri, ro = (p["LedRingID"] + di * p["RingTol"]) / 2, (p["LedRingOD"] + do * p["RingTol"]) / 2
            ann = Part.makeCylinder(ro, p["LedRingT"], V(0, 0, p["RingBack"])).cut(Part.makeCylinder(ri, p["LedRingT"], V(0, 0, p["RingBack"])))
            res[f"ID{2*ri:.0f}_OD{2*ro:.0f}"] = vol(car, ann)
    out["ring_size_overlap"] = res
    # spacing
    bbc = car.BoundBox
    out["carrier_bbox"] = [round(v, 1) for v in (bbc.XMin, bbc.XMax, bbc.YMin, bbc.YMax, bbc.ZMin, bbc.ZMax)]
    c2 = car.copy(); c2.translate(V(p["NodePitch3"], 0, 0))
    out["gap_carrier_row"] = round(car.distToShape(c2)[0], 2)
    c3 = car.copy(); c3.translate(V(p["NodePitch3"] / 2, -p["RowPitch3"], 0))
    out["gap_carrier_next_row"] = round(car.distToShape(c3)[0], 2)
    r3 = Part.makeCompound(rail_parts(p, -114, 114, -p["RowPitch3"])["acrylic"])
    out["gap_carrier_to_next_row_rails"] = round(car.distToShape(r3)[0], 2)
    out["gap_bracket_to_next_row_rails"] = round(br.distToShape(r3)[0], 2)
    # tab mechanics (PETG E ~ 2000 MPa)
    E, L, t, w, d = 2000.0, p["CtTabL"], p["CtTabT"], p["CtTabW"], p["CtPreload"]
    I = w * t ** 3 / 12
    out["tab_force_N_at_preload"] = round(3 * E * I * d / L ** 3, 2)
    out["tab_strain_pct_at_preload"] = round(100 * 1.5 * t * d / L ** 2, 2)
    out["tab_strain_pct_at_2mm"] = round(100 * 1.5 * t * 2.0 / L ** 2, 2)
    out["tab_room_above_mm"] = round(p["Zpcb"] - 13.0 - p["BrTop"], 2)
    out["ZpcbBack"] = round(p["Zpcb"], 2)
    out["node_height_front"] = round(max(esp.BoundBox.ZMax, ring.BoundBox.ZMax, bbc.ZMax), 2)
    out["band_mm"] = round(p["Band"], 2)
    out["row_pitch"] = round(p["RowPitch3"], 2)
    out["volumes_cm3"] = {n: round(doc.getObject(n).Shape.Volume / 1000, 2) for n in ("BracketPocket", "CarrierBase", "CarrierDeck")}
    return out


# ---------------------------------------------------------------- export
def export_v03(doc, outdir):
    import MeshPart
    p = params(doc)
    pdir, cdir, ldir = (os.path.join(outdir, d) for d in ("print", "step", "laser"))
    for d in (pdir, cdir, ldir):
        os.makedirs(d, exist_ok=True)
    flip = App.Rotation(V(1, 0, 0), 180)
    prints = {"Bracket_v03_pocket": ("BracketPocket", flip),
              "Carrier_v03_A_base": ("CarrierBase", App.Rotation()), "Carrier_v03_B_deck": ("CarrierDeck", flip)}
    info, paths = {}, []
    for fn, (n, rot) in prints.items():
        s = doc.getObject(n).Shape.copy(); s.Placement = App.Placement(V(), rot); s = s.copy()
        bb = s.BoundBox
        s.translate(V(-bb.Center.x, -bb.Center.y, -bb.ZMin))
        m = MeshPart.meshFromShape(Shape=s, LinearDeflection=0.02, AngularDeflection=0.15, Relative=False)
        path = os.path.join(pdir, f"{fn}.stl"); m.write(path); paths.append(path)
        sp = os.path.join(cdir, f"{fn}.step"); s.exportStep(sp); paths.append(sp)
        info[fn] = {"volume_cm3": round(s.Volume / 1000, 2), "size_mm": [round(v, 1) for v in (bb.XLength, bb.YLength, bb.ZLength)],
                    "watertight": m.isSolid()}
    xy = lambda v: (v.x, v.y)
    T = p["RailT"]
    for which, n in (("plus", "Plus"), ("gnd", "Gnd")):
        s = strip_2d(p, which)
        paths.append(v02._dxf(os.path.join(ldir, f"{n}_strip_{T}mm_x{int(p['StripLen'])}.dxf"), v02._loops(s, V(0, 0, 1), T / 2, xy)))
    g = rail_gauge(p)
    paths.append(v02._dxf(os.path.join(ldir, "Rail_gauge_any_sheet.dxf"), v02._loops(g, V(0, 0, 1), 1, xy)))
    return paths, info
