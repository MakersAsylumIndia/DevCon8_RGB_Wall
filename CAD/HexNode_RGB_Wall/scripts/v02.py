"""HexNode RGB Wall, version 02: test parts.

Frames
  wall frame   X along the row, Y out of the wall (wall face at Y = 0), Z up.
  holder frame (carrier parts) X along the ESP32, Y across it, Z towards the wall.
               The ESP32's PCB back face is at z = 0 and the board's front faces -Z.
               holder (x, y, z) -> wall (x, Y0 - z, y), so angles in the holder XY plane are
               the same as angles in the wall XZ plane.

Parts
  Rail_strip_v02       v01 rail strip + small snap catches that hold the copper wire.
  Node_back_v02        v01 hook, latch and tape tabs (tabs moved sideways), and a bayonet socket.
  Carrier_v02          printed: deck behind the ESP32 (header strips press into slots), four pegs
                       through the ring's mounting holes, and a bayonet hub with sprung lugs.
  Carrier_deck_acrylic laser-cut 2.8 mm deck (clear), with printed Hub_acrylic and Ring_clip x4.
  Front_cover          laser-cut 2.8 mm clear disc on four printed Cover_standoff (touch electrode).
  Lam_rail             three-layer acrylic rail (2.8 base + 5.0 spacer + 2.8 cap), study.
  Node_back_lam        node back for the acrylic rail (tongue hook, latch behind the cap).
  Bayonet_coupon_*     quick fit test of the bayonet: socket and hub.

Bayonet: lugs sit at PHI (degrees, holder XY = wall XZ) when locked. Insert with the carrier turned
+Twist (counter-clockwise seen from the front), push in, turn back by Twist until it clicks.
"""
import math
import os

import FreeCAD as App
import Part

import wall
from wall import V, _box, _prism_yz, _cyl_y, _feature, _group, _link

V02_INPUTS = [
    # rail wire catches
    ("CatchPitch", "40", "Wire catch spacing along the strip"),
    ("CatchLen", "3", "Wire catch length along the wire"),
    ("CatchT", "0.8", "Wire catch lip thickness"),
    ("CatchGap", "0.9", "Catch mouth: narrower than the wire, so the wire snaps in"),
    # node back
    ("TabX", "15", "Contact tab centre, sideways from the node centre (top tab +X, bottom tab -X)"),
    ("LiteWin", "1", "1 = lightening windows in the node back plate (faster print)"),
    # bayonet
    ("HubR", "6", "Bayonet hub tube outer radius"),
    ("HubWall", "1.6", "Hub tube wall"),
    ("KeyClr", "0.25", "Radial clearance of hub and lugs in the plate keyhole"),
    ("LugH", "2.0", "Lug height, radial (nub); the lug body is DetentI + 0.2 lower"),
    ("LugT", "2.0", "Lug thickness, along the axis"),
    ("AxClr", "0.15", "Axial clearance each side of the plate (flange / lugs)"),
    ("LugKeyArc", "30", "Arc of the wide (keying) lug, degrees"),
    ("LugArc", "20", "Arc of the other two lugs, degrees"),
    ("Twist", "45", "Twist to lock, degrees"),
    ("DetentR", "0.6", "Detent bump radius"),
    ("DetentI", "0.4", "Detent interference: how far the sprung fingers flex to pass the bump"),
    ("NubArc", "4", "Detent nub at the trailing end of each lug, degrees"),
    ("FingerL", "7", "Sprung finger length (slits in the hub tip)"),
    ("SlitW", "1.2", "Finger slit width"),
    ("CavWall", "1.2", "Socket boss wall around the lug cavity"),
    ("BossBackT", "1.4", "Socket boss back wall"),
    ("FlangeR", "12", "Hub flange radius (bears on the plate front: stops wobble)"),
    ("FlangeT", "2", "Hub flange thickness"),
    # carrier
    ("CarrierGap", "17", "Node plate front to ESP32 PCB back (room for the JST housings and wires)"),
    ("DeckT", "2.0", "Printed deck thickness = header spacer height, so the JST housings seat fully"),
    ("DeckHalfW", "16", "Deck half-width across the board (board is 28 wide)"),
    ("DeckEnd", "25.3", "Deck half-length (board is 51 long)"),
    ("HdrSlotW", "2.6", "Header strip slot width (press fit; strips are 2.54)"),
    ("LedH", "1.7", "LED height above the ring PCB"),
    ("LedClr", "0.3", "LED clearance behind the deck"),
    # LED ring clips: four stations, each a seat + inner stop (ID) and a sprung hook (OD)
    ("LedRingID", "54", "LED ring PCB inner diameter: measure yours"),
    ("LedRingOD", "68", "LED ring PCB outer diameter: measure yours"),
    ("LedRingT", "1.6", "LED ring PCB thickness"),
    ("RingTol", "1.0", "Clips accept ID and OD within +/- this (diameter)"),
    ("LedCount", "16", "LEDs on the ring: clips sit in the gaps between them"),
    ("ClipAng", "56.25", "Seat angle from the board's long axis (an LED gap: 11.25 + k x 22.5); clear of the header pins"),
    ("ClipPre", "0.3", "Hook preload at the largest OD"),
    ("SeatW", "5", "Seat and spoke width"),
    ("ArmW", "1.4", "Hook spring arm width (bends radially)"),
    ("ArmH", "3", "Hook spring arm height"),
    ("RingHookW", "4", "Ring clip hook width"),
    ("LipD", "1.0", "Hook lip overlap on the ring's back face"),
    ("LipH", "1.2", "Hook lip thickness"),
    ("LipClr", "0.15", "Axial clearance under the lip"),
    ("StandR", "30", "Cover standoff radius (on the seat spokes, in an LED gap)"),
    ("RingPegD", "2.85", "Standoff pegs"),
    ("StandPegL", "1.3", "Cover standoff peg into the pad / deck"),
    # acrylic
    ("AcrT", "2.8", "Laser-cut acrylic sheet thickness"),
    ("AcrHoleD", "3.0", "Peg holes in acrylic"),
    ("CoverD", "70", "Front cover diameter (keeps a rim round the standoff holes; nodes are 80 apart)"),
    ("CoverGap", "4.5", "PCB back to cover back (clears the USB socket, 3.7)"),
    ("StandD", "5.5", "Cover standoff diameter"),
    # laminated acrylic rail (study)
    ("LamBaseT", "2.8", "Acrylic rail base layer"),
    ("LamSpacerT", "5.0", "Acrylic rail spacer layer"),
    ("LamCapT", "2.8", "Acrylic rail cap layer"),
    ("LamLen", "600", "Acrylic rail length (bed >= 600)"),
    ("LamTopZ0", "13", "Top rail: spacer and cap bottom"),
    ("LamTopSpZ1", "22", "Top rail: spacer top (slot floor)"),
    ("LamTopCapZ1", "26", "Top rail: cap top (lip)"),
    ("LamBotZ1", "-15", "Bottom rail: spacer and cap top"),
    ("LamBotSpZ0", "-26", "Bottom rail: spacer bottom (slot top)"),
    ("LamBotCapZ0", "-28", "Bottom rail: cap bottom"),
    ("LamGrooveW", "1.2", "Wire groove engraved in the cap face (wire rests on its edges)"),
    ("LamGrooveD", "0.5", "Engraved groove depth"),
    ("LamHookT", "5", "Tongue hook thickness above the cap"),
    ("LamClr", "0.3", "Hook and tongue clearance"),
]

PHI = (60.0, 180.0, 300.0)       # locked lug angles; the first lug is the wide keying lug
JST = [(13.25, 12.7), (13.25, -12.7)]   # housing centres (holder XY): three pins nearest the USB end


# ---------------------------------------------------------------- params
def _sheet(doc):
    sh = doc.getObject("V02Params") or doc.addObject("Spreadsheet::Sheet", "V02Params")
    sh.set("A1", "Parameter"); sh.set("B1", "Value"); sh.set("C1", "Notes")
    for i, (a, v, n) in enumerate(V02_INPUTS, start=2):
        sh.set(f"A{i}", a)
        if sh.getAlias(f"B{i}") != a:
            sh.set(f"B{i}", v)
            sh.setAlias(f"B{i}", a)
        sh.set(f"C{i}", n)
    doc.recompute()
    return sh


def params(doc):
    p = wall._wp(doc)
    sh = doc.getObject("V02Params")
    clash = {a for a, _, _ in V02_INPUTS} & {a for a, _, _ in wall.WALL_INPUTS}
    assert not clash, f"V02Params names clash with WallParams: {clash}"
    for a, _, _ in V02_INPUTS:
        v = sh.get(a)
        p[a] = float(getattr(v, "Value", v))
    p["Y0"] = p["PlateB"] + p["CarrierGap"]          # wall Y of the ESP32 PCB back
    p["RingZ0"] = p["DeckT"] + p["LedH"] + p["LedClr"]  # holder z of the ring PCB front face
    return p


def lam_params(p):
    """Same params, re-derived for the laminated acrylic rail."""
    q = dict(p)
    q["RailFront"] = p["LamBaseT"] + p["LamSpacerT"] + p["LamCapT"]
    r = p["WireD"] / 2
    sit = math.sqrt(r * r - (p["LamGrooveW"] / 2) ** 2)          # wire centre above the cap face
    q["WireProt"] = sit + r
    q["WireY"] = q["RailFront"] + sit
    q["PlateF"] = q["RailFront"] + p["PlateGap"]
    q["PlateB"] = q["PlateF"] + p["NodePlateT"]
    q["BumpProt"] = p["PlateGap"] - q["WireProt"] + p["TabPreload"]
    q["Y0"] = q["PlateB"] + p["CarrierGap"]
    return q


# ---------------------------------------------------------------- helpers
def _sector_xz(r0, r1, a0, a1, y0, y1):
    """Annular sector in the wall XZ plane (angles in degrees), from y0 to y1."""
    n = max(4, int(abs(a1 - a0)))
    arc = lambda r: [(r * math.cos(math.radians(a0 + (a1 - a0) * i / n)),
                      r * math.sin(math.radians(a0 + (a1 - a0) * i / n))) for i in range(n + 1)]
    pts = arc(r1) + (arc(r0)[::-1] if r0 > 0 else [(0, 0)])
    w = Part.makePolygon([V(x, y0, z) for x, z in pts] + [V(pts[0][0], y0, pts[0][1])])
    return Part.Face(w).extrude(V(0, y1 - y0, 0))


def _sector_h(r0, r1, a0, a1, z0, z1):
    """Annular sector in the holder XY plane, from z0 to z1."""
    n = max(4, int(abs(a1 - a0)))
    arc = lambda r: [(r * math.cos(math.radians(a0 + (a1 - a0) * i / n)),
                      r * math.sin(math.radians(a0 + (a1 - a0) * i / n))) for i in range(n + 1)]
    pts = arc(r1) + (arc(r0)[::-1] if r0 > 0 else [(0, 0)])
    w = Part.makePolygon([V(x, y, z0) for x, y in pts] + [V(pts[0][0], pts[0][1], z0)])
    return Part.Face(w).extrude(V(0, 0, z1 - z0))


def _cyl_h(x, y, r, z0, z1):
    return Part.makeCylinder(r, z1 - z0, V(x, y, z0))


def _bar_h(p1, p2, w, z0, z1):
    """Flat bar between two holder-XY points, rounded ends."""
    (x1, y1), (x2, y2) = p1, p2
    L = math.hypot(x2 - x1, y2 - y1)
    nx, ny = -(y2 - y1) / L * w / 2, (x2 - x1) / L * w / 2
    pts = [(x1 + nx, y1 + ny), (x2 + nx, y2 + ny), (x2 - nx, y2 - ny), (x1 - nx, y1 - ny)]
    f = Part.Face(Part.makePolygon([V(x, y, z0) for x, y in pts] + [V(pts[0][0], pts[0][1], z0)]))
    b = f.extrude(V(0, 0, z1 - z0))
    return b.fuse([_cyl_h(x1, y1, w / 2, z0, z1), _cyl_h(x2, y2, w / 2, z0, z1)])


def lug_arcs(p):
    return [p["LugKeyArc"], p["LugArc"], p["LugArc"]]


def stations(p):
    """(seat angle, hook angle) for the four ring clips. Hooks sit one LED pitch further round,
    away from the board's long axis (clear of the USB plug)."""
    a, pitch = p["ClipAng"], 360.0 / p["LedCount"]
    seats = [a, 180 - a, 180 + a, 360 - a]
    return [(t, t + (pitch if (t % 180) < 90 else -pitch)) for t in seats]


def stand_xy(p):
    return [(p["StandR"] * math.cos(math.radians(t)), p["StandR"] * math.sin(math.radians(t))) for t, _ in stations(p)]


def _pol(r, a):
    return (r * math.cos(math.radians(a)), r * math.sin(math.radians(a)))


def ring_clip(p, ts, th, zb, r_in, foot_t):
    """One clip station, holder frame. zb = face it stands on; r_in = where its foot starts.
    Seat under the ring's front face, a stop just inside the smallest ID, and a hook on a curved
    spring arm that presses on the OD and laps over the ring's back face."""
    Ri, Ro, T = p["LedRingID"] / 2, p["LedRingOD"] / 2, p["LedRingT"]
    tol = p["RingTol"] / 2
    z0 = p["RingZ0"]
    ra0 = Ro + tol + 0.3                          # arm inner radius: clear of the largest ring
    ra1 = ra0 + p["ArmW"]
    rf = Ro - tol - p["ClipPre"]                  # hook face, free
    w = p["SeatW"]
    ri1 = Ri - tol - 0.2                          # inner stop, outer face: just inside the smallest ID
    dw = lambda r: math.degrees(w / 2 / r)
    parts = [_bar_h(_pol(r_in, ts), _pol(ra1 - w / 2 + 0.01, ts), w, zb, zb + foot_t),
             _sector_h(ri1 - 1.2, Ro - 0.6, ts - dw(ri1), ts + dw(ri1), zb, z0)]
    parts.append(_sector_h(ri1 - 1.2, ri1, ts - math.degrees(w / 2 / ri1), ts + math.degrees(w / 2 / ri1), z0 - 0.01, z0 + T))
    hw = math.degrees(p["RingHookW"] / 2 / Ro)
    a0, a1 = sorted((ts, th + (hw if th > ts else -hw)))
    parts.append(_sector_h(ra0, ra1, a0, a1, zb, zb + p["ArmH"]))
    zl = z0 + T + p["LipClr"]
    zt = zl + p["LipH"]
    c = 0.8
    prof = [(rf, zb), (ra0 + 0.2, zb), (ra0 + 0.2, zt), (rf - p["LipD"] + c, zt), (rf - p["LipD"], zt - c),
            (rf - p["LipD"], zl), (rf, zl)]
    face = Part.Face(Part.makePolygon([V(r, 0, z) for r, z in prof] + [V(prof[0][0], 0, prof[0][1])]))
    hook = face.revolve(V(0, 0, 0), V(0, 0, 1), 2 * hw)
    hook.rotate(V(0, 0, 0), V(0, 0, 1), th - hw)
    parts.append(hook)
    out = parts[0].fuse(parts[1:])
    return out.removeSplitter()


def carrier_placement(p, x=0.0, z=0.0, twist=0.0):
    """Holder frame -> wall frame, optionally turned by `twist` (deg, CCW seen from the front)."""
    base = App.Placement(V(x, p["Y0"], z), App.Rotation(V(1, 0, 0), 90))
    return App.Placement(V(), App.Rotation(V(0, -1, 0), twist)).multiply(base) if twist else base


# ---------------------------------------------------------------- rail strip v02
def wire_catches(p, L, wire_y, faces):
    """Snap catches along each wire: two lips with a mouth narrower than the wire."""
    r = p["WireD"] / 2
    yt = p["RailFront"] + p["WireProt"] - 0.1               # lip tops just under the wire top
    t, g, cl = p["CatchT"], p["CatchGap"], p["CatchLen"]
    out = []
    n = int(L // p["CatchPitch"])
    xs = [p["CatchPitch"] / 2 + k * p["CatchPitch"] for k in range(n)]
    for wz in faces:
        for x in xs:
            blk = _box(x - cl / 2, x + cl / 2, p["RailFront"] - 0.01, yt, wz - r - t, wz + r + t)
            blk = blk.cut(Part.makeCylinder(r + 0.05, cl + 2, V(x - cl / 2 - 1, wire_y, wz), V(1, 0, 0)))
            blk = blk.cut(_box(x - cl / 2 - 1, x + cl / 2 + 1, wire_y + 0.15, yt + 1, wz - g / 2, wz + g / 2))
            lead = _prism_yz([(yt + 0.01, wz - g / 2 - 0.35), (yt + 0.01, wz + g / 2 + 0.35),
                              (yt - 0.35, wz + g / 2), (yt - 0.35, wz - g / 2)], x - cl / 2 - 1, x + cl / 2 + 1)
            out.append(blk.cut(lead))
    return out


def rail_strip_v02(p):
    s = wall.rail_strip_shape(p)
    return s.fuse(wire_catches(p, p["StripLen"], p["WireY"], (p["WireTopZ"], p["WireBotZ"]))).removeSplitter()


# ---------------------------------------------------------------- node back v02
def _plate(p):
    pf, pb = p["PlateF"], p["PlateB"]
    hw, R = p["PlateHalfW"], p["PlateR"]
    disk = Part.makeCylinder(R, pb - pf, V(0, pf, 0), V(0, 1, 0))
    return disk.common(_box(-hw, hw, pf, pb, p["_plate_z0"], R + 1))


def _hook_latch_printed(p):
    """v01 hook on the French cleat and T latch into the bottom rail's V-groove."""
    pf, pb = p["PlateF"], p["PlateB"]
    zbt = p["BotRailZ"] - p["RailH"] - p["LatchClr"]
    p["_plate_z0"] = zbt + p["LatchGap"]
    ytip = p["BaseT"] + p["HookTipGap"]
    c, c2 = p["HookClr"], p["HookClr"] * math.sqrt(2)
    rf, za, cd = p["RailFront"], p["TopRailZ"] + p["RailH"], p["CleatD"]
    zshelf = za - cd + c
    ycorner = rf - cd + c - c2
    ztop = za + p["HookT"]
    hook = _prism_yz([(ytip, zshelf), (ycorner, zshelf), (rf, za + c2), (pb, za + c2), (pb, ztop), (ytip, ztop)],
                     -p["HookW"] / 2, p["HookW"] / 2)
    yp = wall._latch_y(p)
    return hook, _latch(p, zbt, yp, p["BotRailZ"] - p["RailH"] + p["LatchE"])


def _latch(p, zbt, yp, zpeak):
    pf, pb = p["PlateF"], p["PlateB"]
    ax = p["LatchPostW"] / 2 + p["LatchArmL"]
    hh = zpeak - zbt
    arm = _box(-ax, ax, yp - hh, pb, zbt - p["LatchT"], zbt)
    post = _box(-p["LatchPostW"] / 2, p["LatchPostW"] / 2, pf, pb, zbt - p["LatchT"], p["_plate_z0"] + 2)
    barbs = []
    for sgn in (-1, 1):
        x0, x1 = sorted((sgn * (ax - p["BarbW"]), sgn * ax))
        barbs.append(_prism_yz([(yp - hh, zbt), (yp, zpeak), (yp + hh, zbt)], x0, x1))
    return arm.fuse([post] + barbs)


def _hook_latch_lam(p):
    """Acrylic rail: a tongue drops into the slot behind the top cap; the latch barb hooks behind
    the bottom cap's lower edge."""
    pf, pb, c = p["PlateF"], p["PlateB"], p["LamClr"]
    yb, ys = p["LamBaseT"], p["LamBaseT"] + p["LamSpacerT"]
    zf, zc = p["LamTopSpZ1"], p["LamTopCapZ1"]
    t0, t1 = yb + c, ys - c
    zt = zc + c + p["LamHookT"]
    ch = 0.6
    hook = _prism_yz([(t0, zf + c + ch), (t0 + ch, zf + c), (t1 - ch, zf + c), (t1, zf + c + ch), (t1, zc + c),
                      (pb, zc + c), (pb, zt), (t0, zt)], -p["HookW"] / 2, p["HookW"] / 2)
    zbt = p["LamBotCapZ0"] - p["LatchClr"]
    p["_plate_z0"] = zbt + p["LatchGap"]
    e = min(p["LatchE"] + 0.3, p["LamBotSpZ0"] - p["LamBotCapZ0"] - 0.2)
    zpeak = p["LamBotCapZ0"] + e
    hh = zpeak - zbt
    yp = ys - (hh + 0.15)            # front flank meets the cap's back-bottom corner, 0.15 play
    return hook, _latch(p, zbt, yp, zpeak)


def _tabs(p, s):
    pf, pb = p["PlateF"], p["PlateB"]
    L, W, T, g, ph = p["TabL"], p["TabW"], p["TabT"], p["TabSlot"], p["PadH"]
    for zc, sgn, xo in ((p["WireTopZ"], 1, p["TabX"]), (p["WireBotZ"], -1, -p["TabX"])):
        zf = zc + sgn * ph / 2
        zr = zf - sgn * L
        za_, zb_ = sorted((zr, zf + sgn * g))
        z0, z1 = sorted((zr, zf))
        slot = _box(xo - W / 2 - g, xo + W / 2 + g, pf - 1, pb + 1, za_, zb_)
        tab = _box(xo - W / 2, xo + W / 2, pf - 1, pb + 1, z0, z1)
        s = s.cut(slot.cut(tab))
        s = s.cut(_box(xo - W / 2, xo + W / 2, pf - 1, pb - T, z0, z1))
        s = s.fuse(_box(xo - W / 2, xo + W / 2, pf - p["BumpProt"], pb - T + 0.01, zc - ph / 2, zc + ph / 2))
    return s


def _socket(p):
    """Bayonet socket: keyhole in the plate, lug cavity in a boss on the wall side, stops and detents.
    Returns (add, cut)."""
    pf = p["PlateF"]
    rk = p["HubR"] + p["KeyClr"]
    rl = p["HubR"] + p["LugH"] + p["KeyClr"]              # lug notch radius
    rc = rl + 0.15                                        # cavity radius
    rb = rc + p["CavWall"]
    yc = pf - p["LugT"] - 2 * p["AxClr"]                  # cavity back face
    yb = yc - p["BossBackT"]
    add = [Part.makeCylinder(rb, pf - yb + 0.01, V(0, yb, 0), V(0, 1, 0))]
    cut = [_cyl_y(0, 0, rk, yc, p["PlateB"] + 1)]
    for ph, a in zip(PHI, lug_arcs(p)):
        cut.append(_sector_xz(0, rl, ph + p["Twist"] - a / 2 - 1, ph + p["Twist"] + a / 2 + 1, pf - 0.01, p["PlateB"] + 1))
        cut.append(_sector_xz(0, rc, ph - a / 2 - 1, ph + p["Twist"] + a / 2 + 1, yc, pf + 0.01))
    bumps = []
    for ph, a in zip(PHI, lug_arcs(p)):
        r_ = p["DetentR"]
        rr = p["HubR"] + p["LugH"] - p["DetentI"] + r_    # bump centre: inner edge DetentI inside the lug
        ang = math.radians(ph + a / 2 + math.degrees((r_ + 0.4) / rr))
        bumps.append(_cyl_y(rr * math.cos(ang), rr * math.sin(ang), r_, yc - 0.01, pf + 0.01))
    return add, cut, bumps


def _lite(p, s):
    """Lightening windows where the plate carries nothing."""
    pf, pb = p["PlateF"], p["PlateB"]
    rb = p["HubR"] + p["LugH"] + p["KeyClr"] + 0.15 + p["CavWall"] + 2.5
    wins = []
    # right: below the top tab; left: above the bottom tab (tabs are at +X top, -X bottom)
    for sx, z0, z1 in ((1, -20, 1.5), (-1, -5.5, 16)):
        x0, x1 = sorted((sx * rb, sx * (p["PlateHalfW"] - 3)))
        w = _box(x0, x1, pf - 1, pb + 1, z0, z1)
        w = w.cut(Part.makeCylinder(rb, 20, V(0, pf - 5, 0), V(0, 1, 0)))
        wins.append(w)
    return s.cut(wins)


def node_back_v02(p, rail="printed"):
    p = dict(p)
    hook, latch = _hook_latch_printed(p) if rail == "printed" else _hook_latch_lam(p)
    s = _plate(p).fuse([hook, latch])
    if p["LiteWin"] > 0.5:
        s = _lite(p, s)
    s = _tabs(p, s)
    add, cut, bumps = _socket(p)
    s = s.fuse(add).cut(cut).fuse(bumps)
    return s.removeSplitter()


# ---------------------------------------------------------------- carrier (holder frame)
def _hub(p, z_base):
    """Bayonet hub from z_base (behind the deck) to the lug tips, with flange and sprung fingers."""
    y0 = p["Y0"]
    z_fl1 = y0 - (p["PlateB"] + p["AxClr"])               # flange face on the plate front
    z_fl0 = z_fl1 - p["FlangeT"]
    z_lug0 = y0 - (p["PlateF"] - p["AxClr"])              # lug face on the plate back
    z_tip = z_lug0 + p["LugT"]
    R, ri = p["HubR"], p["HubR"] - p["HubWall"]
    h = _cyl_h(0, 0, R, z_base, z_tip)
    fl = _cyl_h(0, 0, p["FlangeR"], z_fl0, z_fl1)
    cone = Part.makeCone(R, p["FlangeR"], p["FlangeR"] - R, V(0, 0, z_fl0 - (p["FlangeR"] - R)))
    s = h.fuse([fl, cone])
    # lug body is relieved below the detent bump; only a nub at the trailing end reaches full
    # height, so the fingers flex just for the last few degrees of the twist (the click)
    H = p["LugH"]
    Hb = H - p["DetentI"] - 0.2
    prof = [(R - 0.5, z_lug0), (R + 1.0, z_lug0), (R + Hb, z_lug0 + 0.6 * Hb / H), (R + Hb, z_tip - 0.3),
            (R + Hb - 0.3, z_tip), (R - 0.5, z_tip)]
    face = Part.Face(Part.makePolygon([V(r, 0, z) for r, z in prof] + [V(prof[0][0], 0, prof[0][1])]))
    lugs = []
    for ph, a in zip(PHI, lug_arcs(p)):
        lug = face.revolve(V(0, 0, 0), V(0, 0, 1), a)
        lug.rotate(V(0, 0, 0), V(0, 0, 1), ph - a / 2)
        lugs.append(lug)
        nub = _sector_h(R + Hb - 0.1, R + H, ph + a / 2 - p["NubArc"], ph + a / 2, z_lug0 + 0.6, z_tip - 0.5)
        lugs.append(nub)
    s = s.fuse(lugs)
    # bore and finger slits
    s = s.cut(_cyl_h(0, 0, ri, z_base - 1, z_tip + 1))
    for ph in PHI:
        a = math.radians(ph + 60)
        w = p["SlitW"]
        slit = Part.makeBox(R + p["LugH"] + 2, w, p["FingerL"] + 1, V(0, -w / 2, z_tip - p["FingerL"]))
        slit.rotate(V(0, 0, 0), V(0, 0, 1), ph + 60)
        s = s.cut(slit)
    return s, (z_fl0, z_fl1, z_lug0, z_tip)


def _deck_outline(p, t):
    """Flat deck + ring arms + pads, holder z 0..t, with header slots."""
    e, hw = p["DeckEnd"], p["DeckHalfW"]
    d = _box(-e, e, -hw, hw, 0, t)
    # round the corners
    for sx in (-1, 1):
        for sy in (-1, 1):
            r = 3
            cx, cy = sx * (e - r), sy * (hw - r)
            corner = _box(min(cx, sx * e), max(cx, sx * e), min(cy, sy * hw), max(cy, sy * hw), -1, t + 1)
            d = d.cut(corner.cut(_cyl_h(cx, cy, r, -1, t + 1)))
    ra1 = p["LedRingOD"] / 2 + p["RingTol"] / 2 + 0.3 + p["ArmW"]
    w = p["SeatW"]
    d = d.fuse([_bar_h(_pol(20, ts), _pol(ra1 - w / 2, ts), w, 0, t) for ts, _ in stations(p)])
    # header strip slots (press fit), same layout as the original holder
    L = p["SlotLen"] + 0.4
    for sy in (-1, 1):
        d = d.cut(_box(p["SlotOffX"] - L / 2, p["SlotOffX"] + L / 2, sy * 12.7 - p["HdrSlotW"] / 2,
                       sy * 12.7 + p["HdrSlotW"] / 2, -1, t + 1))
    d = d.cut(_box(21.9, 24.5, -4.8, 4.8, -1, 0.5))       # relief for the USB socket's through tabs
    return d


def carrier_printed(p):
    t = p["DeckT"]
    d = _deck_outline(p, t)
    # lightening windows behind the board (hidden), keep a ring round the hub
    for sx in (-1, 1):
        x0, x1 = sorted((sx * 11.5, sx * (p["DeckEnd"] - 3.5)))
        d = d.cut(_box(x0, x1, -8.5, 8.5, -1, t + 1))
    # ring clips; cover standoff holes from the front
    d = d.fuse([ring_clip(p, ts, th, 0, 20, t) for ts, th in stations(p)])
    for hx, hy in stand_xy(p):
        d = d.cut(_cyl_h(hx, hy, p["AcrHoleD"] / 2, -1, p["StandPegL"] + 0.2))
    hub, _ = _hub(p, t - 0.01)
    return d.fuse(hub).removeSplitter()


def carrier_deck_acrylic(p):
    q = dict(p); q["DeckT"] = p["AcrT"]
    d = _deck_outline(q, p["AcrT"])
    for hx, hy in stand_xy(p):
        d = d.cut(_cyl_h(hx, hy, p["AcrHoleD"] / 2, -1, p["AcrT"] + 1))
    return d


def acr_params(p):
    q = dict(p); q["DeckT"] = p["AcrT"]
    q["RingZ0"] = p["AcrT"] + p["LedH"] + p["LedClr"]
    return q


def hub_acrylic(p):
    """Printed hub for the acrylic deck: base disc on the deck's back face, pegs flush through it."""
    q = acr_params(p)
    t = p["AcrT"]
    hub, _ = _hub(q, t + 2 - 0.01)
    base = _cyl_h(0, 0, 11.5, t, t + 2)        # glued to the deck's back face (engraved circle locates it)
    return base.fuse(hub).removeSplitter()


def ring_clips_acrylic(p):
    """Four separate printed clips for the acrylic deck, glued onto its spokes."""
    q = acr_params(p)
    Ri = p["LedRingID"] / 2
    return [ring_clip(q, ts, th, p["AcrT"], Ri - p["RingTol"] / 2 - 1.4, 1.2) for ts, th in stations(p)]


def cover(p):
    zb = -p["CoverGap"]
    c = _cyl_h(0, 0, p["CoverD"] / 2, zb - p["AcrT"], zb)
    for hx, hy in stand_xy(p):
        c = c.cut(_cyl_h(hx, hy, p["AcrHoleD"] / 2, zb - p["AcrT"] - 1, zb + 1))
    return c


def cover_standoff(p, hx=0, hy=0):
    zb = -p["CoverGap"]
    s = _cyl_h(hx, hy, p["StandD"] / 2, zb, 0)
    s = s.fuse(_cyl_h(hx, hy, p["RingPegD"] / 2, -0.01, p["StandPegL"]))
    s = s.fuse(_cyl_h(hx, hy, p["RingPegD"] / 2, zb - p["AcrT"], zb + 0.01))
    return d_flat(s, hx, hy, p["RingPegD"] / 2 - 0.3).removeSplitter()


def d_flat(shape, hx, hy, r):
    """Flat side so a small round part with pegs at both ends prints lying down."""
    return shape.cut(_box(hx - 50, hx - r, hy - 50, hy + 50, -50, 50))


def jst_envelope(p):
    """Two housings on the header pins nearest the USB end, plus the wire exit, holder frame."""
    return Part.makeCompound([_box(x - 5, x + 5, y - 2.9, y + 2.9, 2.0, 13.0) for x, y in JST])


# ---------------------------------------------------------------- laminated acrylic rail
def lam_layers(p, L=None):
    """Three acrylic layers (wall frame). Returns dict name -> list of solids."""
    L = L or p["LamLen"]
    q = lam_params(p)
    tb, ts, tc = p["LamBaseT"], p["LamSpacerT"], p["LamCapT"]
    z0 = p["LamBotCapZ0"] - p["StripMargin"]
    z1 = p["LamTopCapZ1"] + p["StripMargin"]
    base = _box(0, L, 0, tb, z0, z1)
    zs = (p["LamTopZ0"] + p["LamBotZ1"]) / 2
    for x in (30, L / 2, L - 30):
        base = base.cut(_cyl_y(x, zs, p["WallScrewD"] / 2, -1, tb + 1))
    spacer = [_box(0, L, tb, tb + ts, p["LamTopZ0"], p["LamTopSpZ1"]),
              _box(0, L, tb, tb + ts, p["LamBotSpZ0"], p["LamBotZ1"])]
    caps = [_box(0, L, tb + ts, tb + ts + tc, p["LamTopZ0"], p["LamTopCapZ1"]),
            _box(0, L, tb + ts, tb + ts + tc, p["LamBotCapZ0"], p["LamBotZ1"])]
    gw, gd = p["LamGrooveW"], p["LamGrooveD"]
    yf = q["RailFront"]
    caps = [c.cut([_box(-1, L + 1, yf - gd, yf + 1, z - gw / 2, z + gw / 2) for z in (p["WireTopZ"], p["WireBotZ"])])
            for c in caps]
    return {"base": [base], "spacer": spacer, "cap": caps}


def lam_rail(p, L=None):
    ly = lam_layers(p, L)
    return Part.makeCompound(ly["base"] + ly["spacer"] + ly["cap"])


# ---------------------------------------------------------------- coupons
def coupons(p):
    """Quick bayonet fit test: a 26 mm socket disc and a short hub. Same lug, detent and clearances."""
    q = dict(p)
    q["_plate_z0"] = -100
    pf, pb = q["PlateF"], q["PlateB"]
    disc = Part.makeCylinder(13.5, pb - pf, V(0, pf, 0), V(0, 1, 0))
    add, cut, bumps = _socket(q)
    sock = disc.fuse(add).cut(cut).fuse(bumps).removeSplitter()
    q["Y0"] = q["PlateB"] + 6
    hub, _ = _hub(q, -0.01)
    grip = _cyl_h(0, 0, 13.5, -2.4, 0)
    for k in range(3):                                                     # finger grips + orientation mark
        a = math.radians(PHI[0])
        grip = grip.cut(_cyl_h(15 * math.cos(math.radians(k * 120 + 90)), 15 * math.sin(math.radians(k * 120 + 90)), 3, -3, 1))
    grip = grip.cut(_cyl_h(10 * math.cos(math.radians(PHI[0])), 10 * math.sin(math.radians(PHI[0])), 1, -3, -1.8))
    return sock, grip.fuse(hub).removeSplitter()


# ---------------------------------------------------------------- document
COLORS = {"RailStripV2": (0.85, 0.85, 0.80), "NodeBackV2": (0.95, 0.55, 0.15),
          "CarrierV2": (0.55, 0.62, 0.80), "CarrierAcr": (0.75, 0.90, 1.00), "HubAcr": (0.55, 0.62, 0.80),
          "CoverV2": (0.80, 0.95, 1.00), "LamRail": (0.25, 0.25, 0.28), "NodeBackLam": (0.95, 0.55, 0.15),
          "JSTEnv": (0.95, 0.95, 0.90)}
TRANSPARENT = {"CarrierAcr": 55, "CoverV2": 70}


def make_parts(doc, p):
    g = _group(doc, "V02Parts")
    _feature(doc, "RailStripV2", rail_strip_v02(p), g, "Rail_strip_v02")
    _feature(doc, "NodeBackV2", node_back_v02(p), g, "Node_back_v02")
    _feature(doc, "CarrierV2", carrier_printed(p), g, "Carrier_v02")
    _feature(doc, "CarrierAcr", carrier_deck_acrylic(p), g, "Carrier_deck_acrylic")
    _feature(doc, "HubAcr", hub_acrylic(p), g, "Hub_acrylic")
    if doc.getObject("RingClipsAcr"):
        doc.removeObject("RingClipsAcr")
    _feature(doc, "RingClipsAcr", Part.makeCompound(ring_clips_acrylic(p)), g, "Ring_clip_x4 (acrylic deck)")
    _feature(doc, "CoverV2", cover(p), g, "Front_cover")
    _feature(doc, "Standoffs", Part.makeCompound([cover_standoff(p, x, y) for x, y in stand_xy(p)]), g, "Cover_standoff_x4")
    _feature(doc, "JSTEnv", jst_envelope(p), g, "JST_housing_envelope")
    _feature(doc, "LamRail", lam_rail(p, 240), g, "Lam_rail_240")
    _feature(doc, "NodeBackLam", node_back_v02(lam_params(p), "lam"), g, "Node_back_lam")
    s, h = coupons(p)
    _feature(doc, "CouponSocket", s, g, "Bayonet_coupon_socket")
    _feature(doc, "CouponHub", h, g, "Bayonet_coupon_hub")


def style(doc):
    if not App.GuiUp:
        return
    for n, c in COLORS.items():
        o = doc.getObject(n)
        if o:
            o.ViewObject.ShapeAppearance = [App.Material(DiffuseColor=c)]
            o.ViewObject.Transparency = TRANSPARENT.get(n, 0)


# ---------------------------------------------------------------- demo
def make_demo(doc, p, rows=2, strips=2):
    g = _group(doc, "V02Demo")
    for o in list(g.Group):
        doc.removeObject(o.Name)
    L = strips * p["StripLen"]
    _feature(doc, "V2WallBoard", _box(-40, L + 40, -12, 0, -50, (rows - 1) * p["RowPitch"] + 50), g, "Wall")
    strip = doc.getObject("RailStripV2")
    for r in range(rows):
        for k in range(strips):
            _link(doc, f"V2Strip_r{r}_{k}", strip, App.Placement(V(k * p["StripLen"], 0, r * p["RowPitch"]), App.Rotation()), g)
    wr = p["WireD"] / 2
    wires = []
    for r in range(rows):
        z = r * p["RowPitch"]
        wires += [Part.makeCylinder(wr, L, V(0, p["WireY"], z + zz), V(1, 0, 0)) for zz in (p["WireTopZ"], p["WireBotZ"])]
    _feature(doc, "V2Wires", Part.makeCompound(wires), g, "Wires")
    dz = p["RingZ0"] - 1.05
    for r, i, x, z in wall.node_placements(p, rows, strips * 3):
        _link(doc, f"V2NB_r{r}_{i}", doc.getObject("NodeBackV2"), App.Placement(V(x, 0, z), App.Rotation()), g)
        cp = carrier_placement(p, x, z)
        _link(doc, f"V2Car_r{r}_{i}", doc.getObject("CarrierV2"), cp, g)
        _link(doc, f"V2ESP_r{r}_{i}", doc.getObject("ESP32"), cp, g)
        _link(doc, f"V2Ring_r{r}_{i}", doc.getObject("LEDRing"), cp.multiply(App.Placement(V(0, 0, dz), App.Rotation())), g)
        if (r + i) % 2:
            _link(doc, f"V2Cov_r{r}_{i}", doc.getObject("CoverV2"), cp, g)
            _link(doc, f"V2Std_r{r}_{i}", doc.getObject("Standoffs"), cp, g)
    # acrylic set on the laminated rail, to the left of the printed wall
    q = lam_params(p)
    x0 = -200
    _link(doc, "V2Lam", doc.getObject("LamRail"), App.Placement(V(x0 - 120, 0, 0), App.Rotation()), g)
    _feature(doc, "V2LamWires", Part.makeCompound(
        [Part.makeCylinder(wr, 240, V(x0 - 120, q["WireY"], zz), V(1, 0, 0)) for zz in (p["WireTopZ"], p["WireBotZ"])]), g, "Lam_wires")
    for k, x in enumerate((x0 - 80, x0, x0 + 80)):
        _link(doc, f"V2LNB_{k}", doc.getObject("NodeBackLam"), App.Placement(V(x, 0, 0), App.Rotation()), g)
        qa = acr_params(q)
        cp = carrier_placement(qa, x, 0)
        for n in ("CarrierAcr", "HubAcr", "RingClipsAcr", "ESP32"):
            _link(doc, f"V2L{n}_{k}", doc.getObject(n), cp, g)
        _link(doc, f"V2LRing_{k}", doc.getObject("LEDRing"), cp.multiply(App.Placement(V(0, 0, qa["RingZ0"] - 1.05), App.Rotation())), g)
    hide = ["RailStripV2", "NodeBackV2", "CarrierV2", "CarrierAcr", "HubAcr", "RingClipsAcr", "CoverV2", "Standoffs",
            "JSTEnv", "LamRail", "NodeBackLam", "CouponSocket", "CouponHub", "ESP32", "LEDRing", "Holder"]
    if App.GuiUp:
        for n in hide:
            if doc.getObject(n):
                doc.getObject(n).Visibility = False
        doc.getObject("V2WallBoard").ViewObject.ShapeAppearance = [App.Material(DiffuseColor=(0.80, 0.72, 0.58))]
        doc.getObject("V2Wires").ViewObject.ShapeAppearance = [App.Material(DiffuseColor=(0.80, 0.45, 0.20))]
        doc.getObject("V2LamWires").ViewObject.ShapeAppearance = [App.Material(DiffuseColor=(0.80, 0.45, 0.20))]


def build(doc, rows=2, strips=2):
    _sheet(doc)
    p = params(doc)
    make_parts(doc, p)
    make_demo(doc, p, rows, strips)
    doc.recompute()
    style(doc)
    return p


# ---------------------------------------------------------------- export
def _dxf(path, loops, layers=None):
    """Minimal R12 DXF: closed polylines. loops: list of (layer, [(x, y), ...])."""
    out = ["0", "SECTION", "2", "ENTITIES"]
    for layer, pts in loops:
        out += ["0", "POLYLINE", "8", layer, "66", "1", "70", "1"]
        for x, y in pts:
            out += ["0", "VERTEX", "8", layer, "10", f"{x:.4f}", "20", f"{y:.4f}", "30", "0"]
        out += ["0", "SEQEND"]
    out += ["0", "ENDSEC", "0", "EOF"]
    with open(path, "w") as f:
        f.write("\n".join(out) + "\n")
    return path


def _loops(shape, normal, mid, to2d, layer="CUT"):
    loops = []
    for w in shape.slice(normal, mid):
        pts = w.discretize(Deflection=0.01)
        loops.append((layer, [to2d(v) for v in pts]))
    return loops


def export_v02(doc, outdir):
    import MeshPart
    import Import
    p = params(doc)
    os.makedirs(outdir, exist_ok=True)
    laser = os.path.join(outdir, "laser"); os.makedirs(laser, exist_ok=True)
    pdir = os.path.join(outdir, "print"); os.makedirs(pdir, exist_ok=True)
    cdir = os.path.join(outdir, "step"); os.makedirs(cdir, exist_ok=True)
    rx = lambda a: App.Rotation(V(1, 0, 0), a)
    ry = lambda a: App.Rotation(V(0, 1, 0), a)
    clips = ring_clips_acrylic(p)
    one_std = cover_standoff(p, 0, 0)
    prints = {
        "Rail_strip_v02": (doc.getObject("RailStripV2").Shape, rx(90)),
        "Node_back_v02": (doc.getObject("NodeBackV2").Shape, rx(-90)),
        "Carrier_v02": (doc.getObject("CarrierV2").Shape, App.Rotation()),
        "Cover_standoff_x4": (one_std, ry(-90)),
        "Hub_acrylic": (doc.getObject("HubAcr").Shape, App.Rotation()),
        "Ring_clip_A_x2": (clips[0], App.Rotation()),
        "Ring_clip_B_x2": (clips[1], App.Rotation()),
        "Node_back_lam": (doc.getObject("NodeBackLam").Shape, rx(-90)),
        "Bayonet_coupon_socket": (doc.getObject("CouponSocket").Shape, rx(-90)),
        "Bayonet_coupon_hub": (doc.getObject("CouponHub").Shape, App.Rotation()),
    }
    paths, info = [], {}
    for fn, (shape, rot) in prints.items():
        s = shape.copy(); s.Placement = App.Placement(V(), rot); s = s.copy()
        bb = s.BoundBox
        s.translate(V(-bb.Center.x, -bb.Center.y, -bb.ZMin))
        m = MeshPart.meshFromShape(Shape=s, LinearDeflection=0.02, AngularDeflection=0.15, Relative=False)
        path = os.path.join(pdir, f"{fn}.stl"); m.write(path); paths.append(path)
        sp = os.path.join(cdir, f"{fn}.step"); s.exportStep(sp); paths.append(sp)
        info[fn] = {"volume_cm3": round(s.Volume / 1000, 2), "size_mm": [round(v, 1) for v in (s.BoundBox.XLength, s.BoundBox.YLength, s.BoundBox.ZLength)],
                    "watertight": m.isSolid()}
    # laser-cut parts (2D, mm)
    q = lam_params(p)
    deck = doc.getObject("CarrierAcr").Shape
    loops = _loops(deck, V(0, 0, 1), p["AcrT"] / 2, lambda v: (v.x, v.y))
    n = 72
    loops.append(("ENGRAVE", [(11.5 * math.cos(2 * math.pi * k / n), 11.5 * math.sin(2 * math.pi * k / n)) for k in range(n + 1)]))
    paths.append(_dxf(os.path.join(laser, "Carrier_deck_acrylic_2.8mm.dxf"), loops))
    cv = cover(p)
    paths.append(_dxf(os.path.join(laser, "Front_cover_clear_2.8mm.dxf"),
                      _loops(cv, V(0, 0, 1), -p["CoverGap"] - p["AcrT"] / 2, lambda v: (v.x, -v.y))))
    ly = lam_layers(p, p["LamLen"])
    tb, ts, tc = p["LamBaseT"], p["LamSpacerT"], p["LamCapT"]
    xz = lambda v: (v.x, v.z)
    paths.append(_dxf(os.path.join(laser, f"Lam_rail_base_{tb}mm.dxf"),
                      sum((_loops(s, V(0, 1, 0), tb / 2, xz) for s in ly["base"]), [])))
    paths.append(_dxf(os.path.join(laser, f"Lam_rail_spacer_{ts}mm.dxf"),
                      sum((_loops(s, V(0, 1, 0), tb + ts / 2, xz) for s in ly["spacer"]), [])))
    cap_loops = sum((_loops(s, V(0, 1, 0), tb + ts + 0.2, xz) for s in ly["cap"]), [])
    gw = p["LamGrooveW"]
    for z in (p["WireTopZ"], p["WireBotZ"]):
        cap_loops.append(("ENGRAVE", [(0, z - gw / 2), (p["LamLen"], z - gw / 2), (p["LamLen"], z + gw / 2), (0, z + gw / 2), (0, z - gw / 2)]))
    paths.append(_dxf(os.path.join(laser, f"Lam_rail_cap_{tc}mm.dxf"), cap_loops))
    return paths, info
