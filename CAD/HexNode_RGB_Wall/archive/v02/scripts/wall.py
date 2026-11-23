"""HexNode wall: printed rail strips with bare copper wire conductors, and node backs that hook on.

Run inside FreeCAD after hexnode.py has built the holder (same document):

    exec(open("<project>/scripts/hexnode.py").read())
    exec(open("<project>/scripts/wall.py").read())
    doc = App.getDocument("HexNode_RGB_Wall")
    build_wall(doc)                       # parts + a demo wall (2 hex-offset rows)
    print(verify_wall(doc))
    export_wall(doc, "<project>/export")
    # after editing the WallParams spreadsheet:
    rebuild_wall(doc)

Shapes are generated in Python from the `WallParams` spreadsheet; edit a cell, then run
rebuild_wall(doc) (a plain recompute does not regenerate them).

Wall frame (all parts): X along the row, Y out of the wall (wall face Y = 0), Z up.
A rail strip's Z = 0 is its row's centre line; a node's centre sits on it.

Each row has one strip carrying two rails:
  top rail    - French cleat, 45 deg bevel facing up and into the wall. GND wire on its face.
                The node's hook sits on the bevel, so the node is pulled into the wall and
                the GND contact makes first when a node is hung.
  bottom rail - the same bevel facing down. +5V wire on its face. A spring latch on the node
                snaps under it and stops the node lifting off the cleat. A firm pull on the
                bottom of the node releases it (45 deg catch).
The latch barbs are 45/45 deg triangles that seat in a matching V-groove along the underside
of the bottom rail (NotchClr all round), so the node has no rattle once latched.
Polarity key: apart from that small V-groove the bottom rail is solid underneath. A node turned
upside down would need its hook to go up into the rail, so it collides instead of seating with
reversed polarity.
"""
import math
import os

import FreeCAD as App
import Part

V = App.Vector

# (alias, value, note)
WALL_INPUTS = [
    # layout
    ("NodePitch", "80", "Node spacing along a row"),
    ("RowPitch", "=NodePitch * sqrt(3) / 2", "Row spacing (hex packing)"),
    ("StripLen", "240", "Printed rail strip length (fits a 256 mm bed)"),
    # rail strip
    ("BaseT", "3", "Strip base thickness (screwed or taped to the wall)"),
    ("RailD", "8", "Rail depth out from the base"),
    ("RailH", "10", "Rail front face height"),
    ("CleatD", "3", "Top rail: depth of the 45 deg lip; behind it a flat shelf back to the base"),
    ("TopRailZ", "14", "Underside of the top rail, above the row centre"),
    ("BotRailZ", "-18", "Top of the bottom rail"),
    ("StripMargin", "3", "Base plate beyond the rails"),
    ("WireD", "1.38", "Bare solid copper wire (1.5 mm2 house wire = 1.38)"),
    ("WireProt", "1.0", "Wire stands proud of the rail face (shallow locating groove; wire pulled taut)"),
    ("WireOff", "4", "Wire centre from the rail's flat edge"),
    ("WallScrewD", "3.6", "Wall screw clearance (M3.5 / #6 wood screw)"),
    ("WallCskD", "7.2", "Wall screw countersink diameter"),
    # node back
    ("PlateGap", "2.5", "Gap between rail faces and node plate"),
    ("NodePlateT", "3", "Node plate thickness"),
    ("PlateR", "33", "Node plate outline radius (ring OD 68 hides it)"),
    ("PlateHalfW", "24", "Node plate half-width"),
    ("HookT", "6", "Hook thickness above the rail lip"),
    ("HookW", "24", "Hook width"),
    ("HookClr", "0.3", "Hook clearance on the cleat bevel"),
    ("HookTipGap", "0.6", "Hook tip clearance to the strip base"),
    ("LatchT", "1.0", "Latch arm thickness (bending direction)"),
    ("LatchArmL", "15", "Latch arm free length, each side of the post (arm ends stay inside the ring)"),
    ("LatchPostW", "4", "Latch centre post width"),
    ("LatchE", "1.5", "Latch barb height into the rail's V-groove (45/45 deg triangle)"),
    ("LatchLand", "1.0", "Flat on the rail underside between its front edge and the V-groove"),
    ("NotchClr", "0.15", "Clearance between the barb and the V-groove, normal to its faces"),
    ("LatchClr", "0.3", "Latch clearance under the rail"),
    ("LatchGap", "0.6", "Gap between latch arm and plate edge"),
    ("BarbW", "5", "Latch barb width"),
    ("PostH", "12", "Holder posts, holder to plate (clears header pins and wiring)"),
    ("PostRecess", "0.8", "Post ends sit in pockets this deep in the plate (locates the holder)"),
    ("PostClr", "0.15", "Radial clearance of the post pockets"),
    ("ScrewClrD", "3.4", "Optional M3 screw through the plate into a post (plain hole; a pan head clears the rail)"),
    # snap fit: four arms on the holder's long edges clip through slots in the plate
    ("SnapArmX", "12", "Snap arm centre, either side of the middle along X"),
    ("SnapArmW", "6", "Snap arm width"),
    ("SnapArmT", "1.2", "Snap arm thickness (bending direction)"),
    ("SnapE", "1.5", "Snap barb engagement (catch overlap on the plate = SnapE - SnapClr)"),
    ("SnapRecess", "1.8", "Pocket on the plate's wall side that the barbs sit in (flush = barb height)"),
    ("SnapClr", "0.2", "Clearance around the snap arms"),
    # copper-tape spring tab
    ("TabL", "16", "Spring tab length (vertical, root towards the node centre)"),
    ("TabW", "10", "Spring tab width = flat pad length along the wire"),
    ("TabT", "1.0", "Spring tab thickness"),
    ("TabSlot", "1.0", "Slot around the tab"),
    ("PadH", "4", "Flat contact pad height (copper tape wraps over it)"),
    ("TabPreload", "1.5", "Spring tab deflection when seated (pad pressed onto the wire); the free pad reaches 0.5 mm past the rail face"),
    # pogo pin: CHIN-BAN PG1000-01-012P (LCSC C49451495), 2 A, collar 3.0 x 2.0, barrel 2.0
    ("PinCollarD", "3.0", "Pogo pin collar diameter"),
    ("PinCollarT", "2.0", "Pogo pin collar thickness"),
    ("PinSeatToTip", "13.2", "Collar underside to plunger tip, at rest"),
    ("PinStroke", "3.0", "Pogo pin max stroke"),
    ("PinPreload", "1.8", "Pogo pin compression when seated (datasheet working point is 2.5)"),
    ("PinBoreD", "3.1", "Bore in the holder boss: collar is a light press fit, barrel is free"),
    ("PinTailD", "1.4", "Hole for the pin's 1.0 mm tail through the boss's shoulder"),
    ("PinShoulderT", "1.0", "Shoulder behind the collar; the 3 mm tail sticks out past it for soldering"),
    ("PinWindowW", "3.5", "Solder window: cavity and side opening under the shoulder"),
    ("PinBossD", "7", "Pogo pin boss on the holder"),
    ("PinBossGap", "2", "Gap between the boss end and the node plate"),
    ("PinPassD", "2.8", "Hole through the node plate's tab and pad for the pin barrel (room for the pad to tilt)"),
]


def _wp(doc):
    """Spreadsheet values as a plain dict of floats (wall params + holder params)."""
    p = {}
    for name in ("Params", "WallParams"):
        sh = doc.getObject(name)
        if sh is None:
            continue
        for c in sh.getUsedCells():
            a = sh.getAlias(c)
            if a:
                v = sh.get(a)
                p[a] = float(getattr(v, "Value", v))
    # derived positions (Y out of the wall)
    p["RailFront"] = p["BaseT"] + p["RailD"]
    p["PlateF"] = p["RailFront"] + p["PlateGap"]          # node plate, wall side
    p["PlateB"] = p["PlateF"] + p["NodePlateT"]               # node plate, node side
    p["HolderTopY"] = p["PlateB"] + p["PostH"]
    p["HolderY0"] = p["HolderTopY"] + p.get("PlateT", 3.6)   # holder underside (holder PlateT)
    p["WireY"] = p["RailFront"] + p["WireProt"] - p["WireD"] / 2
    p["WireTopZ"] = p["TopRailZ"] + p["WireOff"]          # GND
    p["WireBotZ"] = p["BotRailZ"] - p["WireOff"]          # +5V
    p["BumpProt"] = p["PlateGap"] - p["WireProt"] + p["TabPreload"]
    p["StripZ0"] = p["BotRailZ"] - p["RailH"] - p["StripMargin"]
    p["StripZ1"] = p["TopRailZ"] + p["RailH"] + p["StripMargin"]
    return p


def _params_sheet(doc, overrides=None):
    sh = doc.getObject("WallParams") or doc.addObject("Spreadsheet::Sheet", "WallParams")
    sh.set("A1", "Parameter"); sh.set("B1", "Value"); sh.set("C1", "Notes")
    overrides = overrides or {}
    for i, (alias, val, note) in enumerate(WALL_INPUTS, start=2):
        sh.set(f"A{i}", alias)
        sh.set(f"B{i}", str(overrides.get(alias, val)))
        sh.set(f"C{i}", note)
        if sh.getAlias(f"B{i}") != alias:
            sh.setAlias(f"B{i}", alias)
    doc.recompute()
    return sh


# ---------------------------------------------------------------- geometry helpers
def _prism_yz(pts, x0, x1):
    """Polygon given as (y, z) points, extruded along X from x0 to x1."""
    w = Part.makePolygon([V(x0, y, z) for y, z in pts] + [V(x0, pts[0][0], pts[0][1])])
    return Part.Face(w).extrude(V(x1 - x0, 0, 0))


def _box(x0, x1, y0, y1, z0, z1):
    return Part.makeBox(x1 - x0, y1 - y0, z1 - z0, V(x0, y0, z0))


def _cyl_y(x, z, r, y0, y1):
    return Part.makeCylinder(r, y1 - y0, V(x, y0, z), V(0, 1, 0))


def _csk_hole(x, z, d, dk, y_face, y_back, toward):
    """Countersunk hole along Y. Head at y_face; `toward` = +1 if the material is at y > y_face."""
    hole = _cyl_y(x, z, d / 2, min(y_face, y_back) - 1, max(y_face, y_back) + 1)
    depth = (dk - d) / 2
    cone = Part.makeCone(dk / 2, d / 2, depth, V(x, y_face, z), V(0, toward, 0))
    lead = _cyl_y(x, z, dk / 2, y_face - 2 if toward > 0 else y_face, y_face if toward > 0 else y_face + 2)
    return hole.fuse([cone, lead])


# ---------------------------------------------------------------- rail strip
def rail_profiles(p):
    bt, rf, rh, rd = p["BaseT"], p["RailFront"], p["RailH"], p["RailD"]
    zt, zb = p["TopRailZ"], p["BotRailZ"]
    za, cd = zt + rh, p["CleatD"]                                         # lip apex, lip depth
    top = [(bt, zt - rd), (rf, zt), (rf, za), (rf - cd, za - cd),          # 45 deg brace under,
           (bt, za - cd)]                                                  # 45 deg lip, flat shelf
    bot = [(bt, zb + rd), (rf, zb), (rf, zb - rh), (bt, zb - rh)]        # 45 deg brace on top
    return top, bot


def _latch_y(p):
    """Wall-frame Y of the latch barb peak (= V-groove centre)."""
    return p["RailFront"] - p["LatchLand"] - p["LatchE"] - p["NotchClr"] * math.sqrt(2)


def latch_notch(p, x0, x1):
    """V-groove under the bottom rail: the barb's 45/45 deg triangle grown by NotchClr."""
    zr = p["BotRailZ"] - p["RailH"]
    yc, h = _latch_y(p), p["LatchE"] + p["NotchClr"] * math.sqrt(2)
    return _prism_yz([(yc - h - 1, zr - 1), (yc, zr + h), (yc + h + 1, zr - 1)], x0, x1)


def rail_strip_shape(p):
    L = p["StripLen"]
    base = _box(0, L, 0, p["BaseT"], p["StripZ0"], p["StripZ1"])
    top, bot = rail_profiles(p)
    s = base.fuse([_prism_yz(top, 0, L), _prism_yz(bot, 0, L)]).cut(latch_notch(p, -1, L + 1))
    # wire grooves: round seat, mouth slightly narrower than the wire so it snaps in
    r = p["WireD"] / 2 + 0.05
    for z in (p["WireTopZ"], p["WireBotZ"]):
        s = s.cut(Part.makeCylinder(r, L + 2, V(-1, p["WireY"], z), V(1, 0, 0)))
    # countersunk wall screws between the rails (hidden behind the nodes)
    zs = (p["TopRailZ"] + p["BotRailZ"]) / 2
    for x in (20, L / 2, L - 20):
        s = s.cut(_csk_hole(x, zs, p["WallScrewD"], p["WallCskD"], p["BaseT"], 0, -1))
    return s.removeSplitter()


# ---------------------------------------------------------------- node back
def node_back_base(p):
    """Plate + hook + latch + holder post pockets and snap slots, without contacts."""
    pf, pb = p["PlateF"], p["PlateB"]
    zbt = p["BotRailZ"] - p["RailH"] - p["LatchClr"]          # latch arm top
    plate_z0 = zbt + p["LatchGap"]
    hw, R = p["PlateHalfW"], p["PlateR"]
    disk = Part.makeCylinder(R, pb - pf, V(0, pf, 0), V(0, 1, 0))
    plate = disk.common(_box(-hw, hw, pf, pb, plate_z0, R + 1))

    # hook: a solid block on the shelf and the 45 deg lip, tip reaching back to the base
    ytip = p["BaseT"] + p["HookTipGap"]
    c, c2 = p["HookClr"], p["HookClr"] * math.sqrt(2)
    rf, za, cd = p["RailFront"], p["TopRailZ"] + p["RailH"], p["CleatD"]
    zshelf = za - cd + c
    ycorner = rf - cd + c - c2                       # flat meets the 45 deg face
    ztop = za + p["HookT"]
    hook_pts = [(ytip, zshelf), (ycorner, zshelf), (rf, za + c2), (pb, za + c2), (pb, ztop), (ytip, ztop)]
    hook = _prism_yz(hook_pts, -p["HookW"] / 2, p["HookW"] / 2)

    # latch: T-shaped spring under the bottom rail, barbs at the arm ends
    ax = p["LatchPostW"] / 2 + p["LatchArmL"]
    zpeak = p["BotRailZ"] - p["RailH"] + p["LatchE"]
    hh = zpeak - zbt
    yp = _latch_y(p)
    arm = _box(-ax, ax, yp - hh, pb, zbt - p["LatchT"], zbt)
    post = _box(-p["LatchPostW"] / 2, p["LatchPostW"] / 2, pf, pb, zbt - p["LatchT"], plate_z0 + 2)
    barbs = []
    for sgn in (-1, 1):
        x0, x1 = sorted((sgn * (ax - p["BarbW"]), sgn * ax))
        barbs.append(_prism_yz([(yp - hh, zbt), (yp, zpeak), (yp + hh, zbt)], x0, x1))

    s = plate.fuse([hook, arm, post] + barbs)

    # holder posts sit in shallow pockets; optional M3 screw through each into the post
    for x, z in _boss_xz(p):
        s = s.cut(_cyl_y(x, z, p["BossD"] / 2 + p["PostClr"], pb - p["PostRecess"], pb + 1))
        s = s.cut(_cyl_y(x, z, p["ScrewClrD"] / 2, pf - 1, pb + 1))
    # snap arm slots, with a pocket on the wall side so the barbs sit flush
    for x0, x1, z_in, z_out, sgn in _snap_slots(p):
        zlo, zhi = sorted((z_in, z_out))
        s = s.cut(_box(x0, x1, pf - 1, pb + 1, zlo, zhi))
        e, g = p["SnapE"], p["SnapClr"]
        zlo2, zhi2 = sorted((z_in, z_out + sgn * (e + g)))
        s = s.cut(_box(x0 - 0.2, x1 + 0.2, pf - 1, pf + p["SnapRecess"], zlo2, zhi2))
    return s


def _snap_slots(p):
    """(x0, x1, z_inner, z_outer, sign) of each plate slot. The arm flexes inward to pass."""
    hw, t, w = p["HalfW"], p["SnapArmT"], p["SnapArmW"]
    e, g = p["SnapE"], p["SnapClr"]
    out = []
    for sx in (-1, 1):
        for sz in (-1, 1):
            xc = sx * p["SnapArmX"]
            out.append((xc - w / 2 - g, xc + w / 2 + g, sz * (hw - t - e - g), sz * (hw + g), sz))
    return out


def _boss_xz(p):
    bx, by = p.get("BossX", 18.1), p.get("BossY", 8.5)
    return [(sx * bx, sz * by) for sx in (-1, 1) for sz in (-1, 1)]


def _contact_z(p):
    return [p["WireTopZ"], p["WireBotZ"]]


def node_back(p):
    """One node back for both contact options.
    Each rail gets a printed spring tab with a flat pad. The tab runs vertically (root towards
    the node centre), so as it bends the pad tilts about an axis parallel to the wire and keeps
    a line contact along its full width.
      tape: copper tape wrapped over the pad (it spans the pin hole)
      pogo: the pin, held in a boss on the holder, reaches the wire through the hole in the pad
    """
    s = node_back_base(p)
    pf, pb = p["PlateF"], p["PlateB"]
    L, W, T, g, ph = p["TabL"], p["TabW"], p["TabT"], p["TabSlot"], p["PadH"]
    for zc, sgn in ((p["WireTopZ"], 1), (p["WireBotZ"], -1)):
        zf = zc + sgn * ph / 2                        # free end
        zr = zf - sgn * L                             # root
        za_, zb_ = sorted((zr, zf + sgn * g))
        slot = _box(-W / 2 - g, W / 2 + g, pf - 1, pb + 1, za_, zb_)
        z0, z1 = sorted((zr, zf))
        tab = _box(-W / 2, W / 2, pf - 1, pb + 1, z0, z1)
        s = s.cut(slot.cut(tab))
        s = s.cut(_box(-W / 2, W / 2, pf - 1, pb - T, z0, z1))       # thin from the wall side
        pad = _box(-W / 2, W / 2, pf - p["BumpProt"], pb - T + 0.01, zc - ph / 2, zc + ph / 2)
        s = s.fuse(pad)
        s = s.cut(_cyl_y(0, zc, p["PinPassD"] / 2, pf - p["BumpProt"] - 1, pb + 1))
    return s.removeSplitter()


def _pin_y(p):
    """Wall-frame Y of the pogo pin: plunger tip at rest, collar underside, collar top."""
    tip = p["PlateF"] - _pin_prot(p)
    seat = tip + p["PinSeatToTip"]
    return tip, seat, seat + p["PinCollarT"]


def _pin_prot(p):
    """Plunger protrusion past the plate's wall face at rest."""
    return p["PlateGap"] - p["WireProt"] + p["PinPreload"]


def holder_wall_shape(doc, p):
    """The HexNode holder (holder frame: Z up = towards the wall) with its bosses extended into
    posts that reach the node plate, and four snap arms on its long edges."""
    h = doc.getObject("Holder").Shape.copy()
    t0 = p["PlateT"]                                          # holder top face
    z_end = t0 + p["PostH"] + p["PostRecess"]                 # post ends inside the plate pockets
    z_catch = t0 + p["PostH"] + p["NodePlateT"] - p["SnapRecess"]   # barb catch on the pocket floor
    add, cut = [], []
    for x, y in [(sx * p["BossX"], sy * p["BossY"]) for sx in (-1, 1) for sy in (-1, 1)]:
        add.append(Part.makeCylinder(p["BossD"] / 2, z_end - t0 + 0.01, V(x, y, t0 - 0.01)))
        cut.append(Part.makeCylinder(p["HoleD"] / 2, z_end + 2, V(x, y, -1)))
    hw, t, w, e = p["HalfW"], p["SnapArmT"], p["SnapArmW"], p["SnapE"]
    tip = 0.3                                                 # barb land
    for sx in (-1, 1):
        for sy in (-1, 1):
            xc = sx * p["SnapArmX"]
            # profile in the (y, z) plane, drawn for +y and mirrored for -y
            pts = [(hw - t, t0 - 0.01), (hw, t0 - 0.01), (hw, z_catch), (hw + e, z_catch),
                   (hw + e, z_catch + tip), (hw, z_catch + tip + e), (hw - t, z_catch + tip + e)]
            pts = [(sy * y, z) for y, z in pts]
            w_ = Part.makePolygon([V(xc - w / 2, y, z) for y, z in pts] + [V(xc - w / 2, pts[0][0], pts[0][1])])
            add.append(Part.Face(w_).extrude(V(w, 0, 0)))
    # pogo pin bosses: stand on the bed beside the holder's long edges, one per rail. The pin goes
    # in tail first from the open (wall) end; the spring pushes its collar onto the shoulder.
    y0 = p["HolderY0"]
    _, _, collar_top = _pin_y(p)
    hz_shoulder = y0 - collar_top                             # shoulder face (holder frame)
    hz_front = y0 - (p["PlateB"] + p["PinBossGap"])           # boss end, short of the plate
    rb = p["PinBossD"] / 2
    for zc in _contact_z(p):
        sgn = 1 if zc > 0 else -1
        add.append(Part.makeCylinder(rb, hz_front, V(0, zc, 0)))
        y_a, y_b = sorted((sgn * (hw - 1), zc))
        add.append(Part.makeBox(rb * 1.4, y_b - y_a, t0, V(-rb * 0.7, y_a, 0)))   # web to the holder
        cut.append(Part.makeCylinder(p["PinBoreD"] / 2, hz_front - hz_shoulder + 1, V(0, zc, hz_shoulder)))
        cut.append(Part.makeCylinder(p["PinTailD"] / 2, hz_shoulder + 2, V(0, zc, -1)))
        # solder cavity under the shoulder, opening outward (away from the node centre)
        hz_cav = hz_shoulder - p["PinShoulderT"]
        ww = p["PinWindowW"]
        cut.append(Part.makeCylinder(ww / 2, hz_cav + 1, V(0, zc, -1)))
        y_a, y_b = sorted((zc, zc + sgn * (rb + 1)))
        cut.append(Part.makeBox(ww, y_b - y_a, hz_cav + 1, V(-ww / 2, y_a, -1)))
    s = h.fuse(add).cut(cut)
    return s.removeSplitter()


def holder_placement(p, x=0.0, z=0.0):
    """Holder frame -> wall frame: holder +Z (back) points into the wall."""
    return App.Placement(V(x, p["HolderY0"], z), App.Rotation(V(1, 0, 0), 90))


# ---------------------------------------------------------------- document
PART_COLORS = {"RailStrip": (0.85, 0.85, 0.80), "NodeBack": (0.95, 0.55, 0.15),
               "HolderWall": (0.55, 0.62, 0.80),
               "WireGND": (0.10, 0.10, 0.10), "Wire5V": (0.85, 0.15, 0.10),
               "WallBoard": (0.80, 0.72, 0.58)}


def _feature(doc, name, shape, group=None, label=None):
    o = doc.getObject(name) or doc.addObject("Part::Feature", name)
    o.Shape = shape
    if label:
        o.Label = label
    if group and o not in group.Group:
        group.addObject(o)
    return o


def _group(doc, name, parent=None):
    g = doc.getObject(name) or doc.addObject("App::DocumentObjectGroup", name)
    if parent and g not in parent.Group:
        parent.addObject(g)
    return g


def _make_parts(doc, p):
    g = _group(doc, "WallParts")
    _feature(doc, "RailStrip", rail_strip_shape(p), g, "Rail_strip")
    _feature(doc, "NodeBack", node_back(p), g, "Node_back")
    for old in ("NodeBackTape", "NodeBackPogo"):
        if doc.getObject(old):
            doc.removeObject(old)
    _feature(doc, "HolderWall", holder_wall_shape(doc, p), g, "Holder_wall")
    if doc.getObject("Spacer"):
        doc.removeObject("Spacer")


def _link(doc, name, target, placement, group):
    o = doc.getObject(name) or doc.addObject("App::Link", name)
    o.LinkedObject = target
    o.LinkTransform = True          # keep the target's own placement (ESP32 and ring have one)
    o.Placement = placement
    if o not in group.Group:
        group.addObject(o)
    return o


def node_placements(p, rows=2, nodes=9):
    out = []
    for r in range(rows):
        z = r * p["RowPitch"]
        x0 = p["NodePitch"] / 2 + (p["NodePitch"] / 2 if r % 2 else 0)
        n = nodes - (r % 2)
        out += [(r, i, x0 + i * p["NodePitch"], z) for i in range(n)]
    return out


def _make_demo(doc, p, rows=2, strips=3, variants=("NodeBack",)):
    g = _group(doc, "DemoWall")
    for o in list(g.Group):
        if o.TypeId in ("App::Link", "Part::Feature"):
            doc.removeObject(o.Name)
    L = strips * p["StripLen"]
    _feature(doc, "WallBoard", _box(-60, L + 60, -12, 0, -60, (rows - 1) * p["RowPitch"] + 60), g, "Wall")
    strip = doc.getObject("RailStrip")
    for r in range(rows):
        for k in range(strips):
            _link(doc, f"Strip_r{r}_{k}", strip, App.Placement(V(k * p["StripLen"], 0, r * p["RowPitch"]), App.Rotation()), g)
    # copper wires, and the edge loops (insulated) that tie the rows together
    wr = p["WireD"] / 2
    gnd, v5 = [], []
    for r in range(rows):
        z = r * p["RowPitch"]
        gnd.append(Part.makeCylinder(wr, L + 30, V(-15, p["WireY"], z + p["WireTopZ"]), V(1, 0, 0)))
        v5.append(Part.makeCylinder(wr, L + 50, V(-25, p["WireY"], z + p["WireBotZ"]), V(1, 0, 0)))
    zt = [r * p["RowPitch"] + p["WireTopZ"] for r in range(rows)]
    zb = [r * p["RowPitch"] + p["WireBotZ"] for r in range(rows)]
    for x in (-15, L + 15):
        gnd.append(Part.makeCylinder(1.2, zt[-1] - zt[0] + 0.01, V(x, p["WireY"] + 3, zt[0]), V(0, 0, 1)))
        gnd += [Part.makeCylinder(wr, 3, V(x, p["WireY"], z), V(0, 1, 0)) for z in zt]
    for x in (-25, L + 25):
        v5.append(Part.makeCylinder(1.2, zb[-1] - zb[0] + 0.01, V(x, p["WireY"] + 6, zb[0]), V(0, 0, 1)))
        v5 += [Part.makeCylinder(wr, 6, V(x, p["WireY"], z), V(0, 1, 0)) for z in zb]
    _feature(doc, "WireGND", Part.makeCompound(gnd), g, "Wire_GND")
    _feature(doc, "Wire5V", Part.makeCompound(v5), g, "Wire_5V")
    # nodes: holder + ESP32 + ring via links, node back alternating tape / pogo
    for r, i, x, z in node_placements(p, rows, strips * 3):
        nb = doc.getObject(variants[(r + i) % len(variants)])
        _link(doc, f"NodeBack_r{r}_{i}", nb, App.Placement(V(x, 0, z), App.Rotation()), g)
        for n in ("HolderWall", "ESP32", "LEDRing"):
            if doc.getObject(n):
                _link(doc, f"{n}_r{r}_{i}", doc.getObject(n), holder_placement(p, x, z), g)


def _style(doc):
    if not App.GuiUp:
        return
    for n, c in PART_COLORS.items():
        o = doc.getObject(n)
        if o:
            o.ViewObject.ShapeAppearance = [App.Material(DiffuseColor=c)]
    for n in ("RailStrip", "NodeBack", "HolderWall", "Holder"):
        if doc.getObject(n):
            doc.getObject(n).Visibility = False


def build_wall(doc, params=None, rows=2, strips=3):
    _params_sheet(doc, params)
    p = _wp(doc)
    _make_parts(doc, p)
    _make_demo(doc, p, rows, strips)
    doc.recompute()
    _style(doc)
    return doc


def rebuild_wall(doc, rows=2, strips=3):
    doc.recompute()
    p = _wp(doc)
    _make_parts(doc, p)
    _make_demo(doc, p, rows, strips)
    doc.recompute()
    _style(doc)
    return doc


# ---------------------------------------------------------------- checks
def verify_wall(doc):
    p = _wp(doc)
    strip = doc.getObject("RailStrip").Shape
    out = {}
    for n in ("NodeBack",):
        nb = doc.getObject(n).Shape
        out[n] = {"valid": nb.isValid(), "solids": len(nb.Solids), "volume_mm3": round(nb.Volume, 1)}
        # seated on a strip (node at x = 120): no collision with the rails
        st = strip.copy()
        nbm = nb.copy(); nbm.translate(V(120, 0, 0))
        # the free contact pads reach past the rail face by design (they deflect onto the wire),
        # so they are left out of the seated check
        pads = [_box(120 - p["TabW"] / 2 - 0.1, 120 + p["TabW"] / 2 + 0.1, 0, p["PlateF"],
                     zc - p["PadH"] / 2 - 0.1, zc + p["PadH"] / 2 + 0.1) for zc in _contact_z(p)]
        out[n]["collision_seated_mm3"] = round(nbm.cut(pads[0].fuse(pads[1])).common(st).Volume, 3)
        out[n]["free_pad_past_rail_face_mm"] = round(p["BumpProt"] - p["PlateGap"], 2)
        # upside down (rotated 180 deg about Y) at any height within +-10 mm: always collides
        worst = None
        for k in range(-20, 21):
            f = nb.copy(); f.rotate(V(0, 0, 0), V(0, 1, 0), 180); f.translate(V(120, 0, k * 0.5))
            v = f.common(st).Volume
            worst = v if worst is None else min(worst, v)
        out[n]["upside_down_min_collision_mm3"] = round(worst, 1)
        # stays inside the ring's 68 mm outline (seen from the front)
        bb = nb.BoundBox
        rmax = max(math.hypot(v.X, v.Z) for v in nb.Vertexes)
        out[n]["max_radius_mm"] = round(rmax, 1)
    # contact preload against the wire
    wire_top_y = p["RailFront"] + p["WireProt"]
    out["tape_tab_preload_mm"] = round(wire_top_y - (p["PlateF"] - p["BumpProt"]), 2)
    E = 3500.0  # PLA/PETG ~2000-3500 MPa
    L, T, W = p["TabL"] - p["PadH"] / 2, p["TabT"], p["TabW"]
    d = out["tape_tab_preload_mm"]
    out["tape_tab_force_N"] = round(3 * E * (W * T ** 3 / 12) * d / L ** 3, 2)
    out["tape_tab_strain_pct"] = round(150 * T * d / L ** 2, 2)
    out["tape_pad_tilt_deg"] = round(math.degrees(1.5 * d / L), 1)        # about an axis along the wire
    out["tape_contact_length_mm"] = W
    out["pogo_preload_mm"] = round(_pin_prot(p) - p["PlateGap"] + p["WireProt"], 2)
    out["pogo_stroke_left_mm"] = round(p["PinStroke"] - out["pogo_preload_mm"], 2)
    _, _, collar_top = _pin_y(p)
    out["pogo_tail_exposed_mm"] = round(3.0 - p["PinShoulderT"], 1)   # PG1000 tail is 3 mm
    out["pogo_barrel_to_pass_hole_mm"] = round((p["PinPassD"] - 2.0) / 2, 2)
    # latch spring
    La, Ta, Wa = p["LatchArmL"], p["LatchT"], p["PlateB"] - _latch_y(p) + p["LatchE"] + p["LatchClr"]
    dl = p["LatchE"] + p["LatchClr"]
    f1 = 3 * E * (Wa * Ta ** 3 / 12) * dl / La ** 3
    out["latch_snap_force_N"] = round(2 * f1, 1)
    out["latch_pull_off_N_approx"] = round(2 * f1 * (1 + 0.3) / (1 - 0.3), 1)
    out["latch_strain_pct"] = round(150 * Ta * dl / La ** 2, 2)
    out["latch_barb_height_mm"] = round(p["LatchE"] + p["LatchClr"], 2)
    out["latch_play_mm"] = round(p["NotchClr"] * math.sqrt(2), 2)          # along Y or Z, seated
    out["snap_catch_overlap_mm"] = round(p["SnapE"] - p["SnapClr"], 2)
    # holder posts + snap arms
    Ls = p["PostH"] + p["NodePlateT"] - p["SnapRecess"]
    ds = p["SnapE"] + p["SnapClr"]
    fs = 3 * E * (p["SnapArmW"] * p["SnapArmT"] ** 3 / 12) * ds / Ls ** 3
    out["snap_arm_length_mm"] = round(Ls, 1)
    out["snap_push_on_N_total"] = round(4 * fs, 1)
    out["snap_strain_pct"] = round(150 * p["SnapArmT"] * ds / Ls ** 2, 2)
    hwall = doc.getObject("HolderWall").Shape.copy()
    hwall.Placement = holder_placement(p, 120, 0)
    hwall = hwall.copy()
    for n in ("NodeBack",):
        nbm = doc.getObject(n).Shape.copy(); nbm.translate(V(120, 0, 0))
        out[n]["collision_with_holder_mm3"] = round(nbm.common(hwall).Volume, 3)
    out["holder_vs_strip_mm3"] = round(hwall.common(strip).Volume, 3)
    out["snap_tip_below_plate_face_mm"] = round(hwall.BoundBox.YMin - p["PlateF"], 2)   # >= 0: flush or recessed
    for n in ("ESP32", "LEDRing"):
        o = doc.getObject(n)
        if o:
            out[f"holder_vs_{n}_mm3"] = round(doc.getObject("HolderWall").Shape.common(o.Shape).Volume, 3)
    # clearances
    pins_tip_y = p["HolderTopY"] - 3.9                       # ESP32 header pins stand 3.9 above the holder
    out["plate_to_header_pins_mm"] = round(pins_tip_y - p["PlateB"], 1)
    out["gap_between_rows_mm"] = round(p["RowPitch"] - (p["TopRailZ"] + p["RailH"] + p["HookT"]) + (p["BotRailZ"] - p["RailH"] - p["LatchClr"] - p["LatchT"] - 1), 1)
    out["ring_gap_between_rows_mm"] = round(p["NodePitch"] - 68, 1)
    return out


def export_wall(doc, outdir):
    import MeshPart
    os.makedirs(outdir, exist_ok=True)
    paths = []
    # print orientation: strip on its back, node backs on their node-side face, holder flat (posts up)
    orient = {"RailStrip": (App.Rotation(V(1, 0, 0), 90), "Rail_strip"),
              "NodeBack": (App.Rotation(V(1, 0, 0), -90), "Node_back"),
              "HolderWall": (App.Rotation(), "Holder_wall")}
    import Import
    for n, (rot, fn) in orient.items():
        s = doc.getObject(n).Shape.copy()
        s.Placement = App.Placement(V(), rot)
        s = s.copy()
        bb = s.BoundBox
        s.translate(V(-bb.Center.x, -bb.Center.y, -bb.ZMin))
        m = MeshPart.meshFromShape(Shape=s, LinearDeflection=0.02, AngularDeflection=0.15, Relative=False)
        path = os.path.join(outdir, f"{fn}.stl"); m.write(path); paths.append(path)
        sp = os.path.join(outdir, f"{fn}.step")
        Import.export([doc.getObject(n)], sp); paths.append(sp)
    return paths
