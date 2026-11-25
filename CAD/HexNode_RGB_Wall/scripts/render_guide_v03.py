# Renders the step pictures for the HexNode v03 assembly guide and writes export/guide/assets/guide_content.json;
# make_guide_v03.py lays them out as the branded HTML + PDF.
# Run inside the FreeCAD GUI (Macro > Execute, or through the MCP execute_code tool):
#   exec(open('<repo>/CAD/HexNode_RGB_Wall/scripts/render_guide_v03.py').read())
# Works on a temporary copy (export/guide/assets/_render_copy.FCStd): the guide-only extras (copper tape,
# solder, painter's tape, filament rivets) never end up in HexNode_RGB_Wall.FCStd.
import os, sys, json, shutil
import FreeCAD as App
import FreeCADGui as Gui
import Part

V = App.Vector
HERE = os.path.dirname(os.path.dirname(os.path.abspath(__file__))) if '__file__' in globals() else \
    '/home/anool/Documents/projects-git/Makers_Asylum/DevCon8_2026/DevCon8_RGB_Wall/CAD/HexNode_RGB_Wall'
sys.path.insert(0, os.path.join(HERE, 'scripts'))
import importlib, v03
importlib.reload(v03)
OUT = os.path.join(HERE, 'export', 'guide', 'assets')
os.makedirs(OUT, exist_ok=True)

TMP = os.path.join(OUT, '_render_copy.FCStd')
for d in list(App.listDocuments().values()):
    if os.path.basename(d.FileName) == '_render_copy.FCStd':
        App.closeDocument(d.Name)
shutil.copy(os.path.join(HERE, 'HexNode_RGB_Wall.FCStd'), TMP)
doc = App.openDocument(TMP)
Gui.ActiveDocument = Gui.getDocument(doc.Name)
p = v03.params(doc)


def feat(name, shape, color, transp=0):
    o = doc.addObject('Part::Feature', name)
    o.Shape = shape
    o.ViewObject.ShapeColor = color
    o.ViewObject.LineColor = tuple(c * 0.6 for c in color)
    o.ViewObject.Transparency = transp
    return o


def box(x0, x1, y0, y1, z0, z1):
    return Part.makeBox(x1 - x0, y1 - y0, z1 - z0, V(x0, y0, z0))


# ---------------------------------------------------------------- guide-only extras
W, L, T = p['CtTabW'], p['CtTabL'], p['CtTabT']
xr, zt = p['CtRootX'], p['BrTop']
xf = xr - L
zpad = p['TapeTop'] - p['CtPreload']
COPPER, SOLDER, PAINTER, FIL = (0.85, 0.45, 0.2), (0.78, 0.8, 0.82), (0.0, 0.78, 0.95), (0.98, 0.98, 0.98)
tape_t = 0.12
tapes, solders = [], []
for yc, _ in v03.tabs(p):
    r = 1.6
    prof = [V(xf, 0, zt), V(xr, 0, zt), V(xr, 0, zt - T), V(xf + p['CtPadL'], 0, zt - T),
            V(xf + p['CtPadL'] - r, 0, zpad), V(xf + r, 0, zpad)]
    face = Part.Face(Part.makePolygon(prof + prof[:1]))
    solid = face.extrude(V(0, W, 0))
    solid.translate(V(0, yc - W / 2, 0))
    shell = solid.makeOffsetShape(tape_t, 0.01, join=2).cut(solid)
    # 30 mm strip: under the tab from the root, round the free end, back along the top
    tapes.append(shell.common(box(xf - 1, xr, yc - W / 2 + 0.01, yc + W / 2 - 0.01, zpad - 1, zt + 1)))
    s = solid.makeOffsetShape(tape_t + 0.15, 0.01, join=2).cut(solid.makeOffsetShape(tape_t, 0.01, join=2))
    solders.append(s.common(box(xf + 0.3, xf + p['CtPadL'] - 0.3, yc - W / 2 + 0.5, yc + W / 2 - 0.5, zpad - 1, zpad + 0.3)))
CopperTape = feat('G_CopperTape', Part.makeCompound(tapes), COPPER)
Solder = feat('G_Solder', Part.makeCompound(solders), SOLDER)
# painter's tape holding the power wires in the bracket grooves (step 9)
# one long strip per tab: from the tab's free end (over the copper tape) to the bracket's USB-end edge
PainterBr = feat('G_PainterBr', Part.makeCompound([box(xf + 0.3, p['BrHalfL'], yc - 4, yc + 4, zt + tape_t, zt + tape_t + 0.12)
                                                  for yc, _ in v03.tabs(p)]), PAINTER)
# painter's tape across the USB-end edge of the carrier base over the wires (step 14)
PainterCar = feat('G_PainterCar', box(23.0, p['BrHalfL'], -18, 20, p['CarTop'] + p['LabelD'], p['CarTop'] + p['LabelD'] + 0.25), PAINTER)
# 30 mm filament rivets, flush with the deck face
fils = [Part.makeCylinder(0.875, 30, V(x, y, p['Zpcb'] - 30)) for x, y in v03.rivets(p)]
Filament = feat('G_Filament', Part.makeCompound(fils), FIL)
# the same pins after trimming flush with the bracket's magnet side (z = 0)
FilTrim = feat('G_FilTrim', Part.makeCompound([Part.makeCylinder(0.875, p['Zpcb'], V(x, y, 0)) for x, y in v03.rivets(p)]), FIL)
# two magnets (the outer pockets) out of the four
m = p['MagS'] / 2
Magnets2 = feat('G_Magnets2', Part.makeCompound([box(x - m, x + m, p['TongueYc'] - m, p['TongueYc'] + m, 0, p['MagT'])
                                                 for x in (v03.mag_xs(p)[0], v03.mag_xs(p)[-1])]), (0.6, 0.62, 0.66))

# the two JST housings, separately: PWR on the [-] side (-y), LED on the [+] side (+y)
_js = doc.getObject('JSTEnv3').Shape.Solids
for nm, sel in (('G_JstPwr', lambda c: c.y < 0), ('G_JstLed', lambda c: c.y > 0)):
    feat(nm, Part.makeCompound([q for q in _js if sel(q.BoundBox.Center)]), (0.95, 0.95, 0.9))

# ---------------------------------------------------------------- colours of the model parts
COL = {'BracketPocket': (0.15, 0.45, 0.85), 'CarrierBase': (0.98, 0.75, 0.08), 'CarrierDeck': (0.2, 0.7, 0.45),
       'JSTEnv3': (0.95, 0.95, 0.9), 'TouchFoam': (0.97, 0.97, 0.97), 'TouchWasher': (0.72, 0.74, 0.77)}
for n, c in COL.items():
    o = doc.getObject(n)
    o.ViewObject.ShapeColor = c
    o.ViewObject.LineColor = tuple(k * 0.6 for k in c)

ITEMS = {
    'Bracket': ['BracketPocket'], 'Copper': ['G_CopperTape'], 'Solder': ['G_Solder'],
    'PwrRB': ['Cable', 'Cable001'], 'Touch': ['Cable002'], 'LedW': ['Cable003', 'Cable004', 'Cable005'],
    'PainterBr': ['G_PainterBr'], 'Base': ['CarrierBase'], 'JST': ['G_JstPwr'], 'JstLed': ['G_JstLed'], 'Ring': ['Ref_LEDRing'],
    'PainterCar': ['G_PainterCar'], 'Deck': ['CarrierDeck'], 'Filament': ['G_Filament'], 'FilTrim': ['G_FilTrim'], 'ESP': ['Ref_ESP32'],
    'Foam': ['TouchFoam'], 'Washer': ['TouchWasher'], 'Magnets': ['G_Magnets2'],
}
for o in doc.Objects:
    if 'Visibility' in dict(getattr(o, 'ExpressionEngine', [])):
        o.setExpression('Visibility', None)
for o in doc.Objects:
    if o.TypeId not in ('Spreadsheet::Sheet',):
        o.Visibility = False
        if o.ViewObject:
            o.ViewObject.Visibility = False
ALLN = {n for names in ITEMS.values() for n in names}


def show(old, new, fade=True):
    for o in doc.Objects:          # groups can switch children back on: hide everything first
        if o.ViewObject and o.TypeId != 'Spreadsheet::Sheet':
            o.Visibility = False
            o.ViewObject.Visibility = False
    for key, names in ITEMS.items():
        for n in names:
            o = doc.getObject(n)
            vo = o.ViewObject
            on = key in old or key in new
            o.Visibility = on
            vo.Visibility = on
            if not on:
                continue
            faded = fade and key in old and key not in new
            if o.TypeId == 'App::Link':
                vo.OverrideMaterial = faded
                if faded:
                    mt = vo.ShapeMaterial
                    mt.DiffuseColor = (0.75, 0.75, 0.75)
                    mt.Transparency = 0.7
                    vo.ShapeMaterial = mt
            else:
                vo.Transparency = 70 if faded else 0


v = Gui.ActiveDocument.ActiveView
v.setAnimationEnabled(False)
R = App.Rotation


def camera(view):
    """+x (USB end) = 12 o'clock. 'top': straight down; 'top34': tilted; 'under34': from the magnet side."""
    up = R(V(0, 0, 1), -90)            # x up the picture
    if view == 'top':
        q = up
    elif view == 'top34':
        q = R(V(0, 0, 1), -90 - 30).multiply(R(V(1, 0, 0), 50))
    elif view == 'under34':
        q = R(V(0, 0, 1), -90 + 30).multiply(R(V(1, 0, 0), 180 - 50))
    elif view == 'under':
        q = R(V(0, 0, 1), -90).multiply(R(V(1, 0, 0), 180))
    elif view == 'end34':            # from the USB end, looking back and down
        q = R(V(0, 0, 1), 90).multiply(R(V(1, 0, 0), 45))
    elif view == 'side34':
        q = R(V(0, 0, 1), -90 - 35).multiply(R(V(1, 0, 0), 70))
    v.setCameraOrientation(q.Q)


# ---------------------------------------------------------------- steps
# (title, already fitted (faded), new in this step (solid), view, text, parts, keep old parts solid)
TAB = ['Bracket', 'Copper']
WIRED = TAB + ['Solder', 'PwrRB', 'JST']
STACK = WIRED + ['PainterBr', 'Base']
RINGED = STACK + ['Ring', 'LedW', 'JstLed', 'PainterCar']
DECKED = RINGED + ['Deck', 'FilTrim']
STEPS = [
    ('Copper tape on the spring tabs', ['Bracket'], ['Copper'], 'under34',
     'Cut two strips of <b>10 mm wide copper tape, each 30 mm long</b>. Peel off half the backing and stick that half on a '
     'spring tab, on the <b>magnet side</b> of the bracket. Push the rest of the strip through to the other side and stick it '
     'down firmly all round. On the other side, the tab has a groove for the power wire: <b>press the tape into the groove</b>. '
     'Do the same on the second tab, so both <b>+5V</b> and <b>GND</b> are taped.',
     ['bracket', '2 × copper tape 10 × 30 mm'], True),
    ('Power wires', TAB, ['PwrRB', 'JST'], 'top34',
     'Take <b>JST cable no. 1</b>. Cut two of its wires to <b>60 mm</b>: red and brown (on a red / brown / black cable) '
     'or red and black (on a red / black / yellow cable). <b>Don\'t cut the third wire</b> (black or yellow): it becomes the touch wire later. '
     'Strip about <b>10 mm</b> off the cut ends and solder them to the copper tape in the tab grooves: '
     '<b>red to the + tab</b>, the other wire to the − tab.',
     ['JST cable no. 1', 'wire stripper', 'soldering iron'], True),
    ('Solder the contact pads', WIRED, ['Solder'], 'under34',
     'Turn the bracket over. Each spring tab has a raised pad at its end: this is what touches the power rail on the wall. '
     'Run a <b>thin layer of solder</b> over the copper tape on each pad.',
     ['solder'], True),
    ('Anchor the wires', WIRED + ['Solder'], ['PainterBr'], 'top34',
     'Lay each wire in its groove on the bracket and hold it down with a <b>long strip of painter\'s tape</b>: from the '
     'spring tab (over the copper tape) <b>all the way to the edge</b> of the bracket.',
     ['painter\'s tape'], False),
    ('Carrier base onto the bracket', WIRED + ['PainterBr'], ['Base'], 'top34',
     'Put the carrier base on the bracket. The <b>[+] and [−] marks</b> on the bracket and on the carrier base <b>must line up</b>.',
     ['carrier base'], False),
    ('Power connector into its socket', STACK, ['JST'], 'top',
     'Slide <b>JST connector no. 1</b> (the power cable) into its socket on the carrier base, on the side with the '
     '<b>[−] mark</b> (the one labelled PWR). The <b>red wire goes nearest the edge</b> of the carrier base.',
     ['JST connector no. 1'], False),
    ('LED ring connector into its socket', STACK, ['LedW', 'JstLed'], 'top',
     'The LED ring already has a 3-pin JST cable soldered to it. Slide this <b>JST connector no. 2</b> into the other socket, '
     'on the side with the <b>[+] mark</b> (labelled LED). Again, the <b>red wire goes nearest the edge</b>.',
     ['JST connector no. 2 (on the LED ring)'], False),
    ('Fit the LED ring', STACK + ['LedW', 'JstLed'], ['Ring'], 'top',
     'Fit the LED ring into the carrier base. Turn it so its <b>wires are at about 10 to 11 o\'clock</b>, near the LED socket '
     '(USB end of the node = 12 o\'clock). Two of the holes in the ring should now line up with two of the <b>four clips</b> '
     'that hold it.',
     ['RGB LED ring'], False),
    ('Tape the wires down', STACK + ['LedW', 'JstLed'], ['PainterCar'], 'end34',
     'Check that the wires from both connectors run in the <b>cable channels</b>. Put a narrow strip of painter\'s tape across '
     'the top edge of the carrier base, over the wires, so they stay in place.',
     ['painter\'s tape'], False),
    ('Filament pins in the deck', [], ['Deck', 'Filament'], 'top34',
     'Push three <b>30 mm pieces of 1.75 mm 3D-printer filament</b> through the three holes in the carrier deck. '
     'Make the filament <b>flush with the top face</b> of the deck.',
     ['carrier deck', '3 × filament 1.75 mm, 30 mm long'], True),
    ('Deck onto the stack', RINGED, ['Deck', 'Filament'], 'top34',
     'Fit the deck, passing the filament pins through the matching holes in the carrier base and the bracket. '
     'Two <b>keying tabs</b> only let it go on one way: the <b>wide end of the deck at 6 o\'clock</b>, the small USB cut-out '
     'at <b>12 o\'clock</b>. Once it is lined up, <b>push it all the way in</b>. The three printed parts are now held together '
     'as one sandwich.',
     ['deck from the step before'], False),
    ('Trim the filament', RINGED + ['Deck'], ['Filament'], 'under34',
     'Turn the node over. The three filament pins stick out about <b>10 mm</b> from the magnet side of the bracket. '
     '<b>Cut them flush</b> with the bottom of the bracket, so the node sits flat on the wall.',
     ['wire cutter'], False),
    ('ESP32', DECKED, ['ESP'], 'top34',
     'Fit the ESP32 with its <b>USB connector at 12 o\'clock</b>. The black plastic strips of the header pins must go '
     '<b>all the way into</b> the long slots in the deck.',
     ['ESP32 DevKit'], False),
    ('Touch washer', DECKED + ['ESP'], ['Touch', 'Foam', 'Washer'], 'top34',
     'Stick a piece of <b>1 mm double-sided foam tape</b> on the ESP32\'s metal shield. Cut the last wire of JST cable no. 1 '
     '(the touch wire, black or yellow) to about <b>110 mm</b> and strip <b>20–25 mm</b> off the end. Twist the bare strands '
     'and fix them firmly to the <b>metal washer</b>. Cover any bare wire with painter\'s tape, but <b>leave the washer '
     'uncovered</b>. Stick the washer on the foam tape.',
     ['metal washer', '1 mm double-sided foam tape', 'painter\'s tape'], False),
    ('Magnets', DECKED + ['ESP', 'Touch', 'Foam', 'Washer'], ['Magnets'], 'under34',
     'Press <b>two 10 × 10 × 2 mm neodymium magnets</b> into the pockets under the bracket. There are four pockets, '
     'but two are enough. Put both magnets in <b>the same way round</b> (same pole facing out).',
     ['2 × magnet 10 × 10 × 2 mm'], False),
]
VIEW_FOR = {}
FIN = DECKED + ['ESP', 'Touch', 'Foam', 'Washer', 'Magnets']


def shot(old, new, view, fn, solid_old=False, w=1600, h=1200):
    show(old, new, fade=not solid_old)
    camera(view)
    v.fitAll()
    v.saveImage(os.path.join(OUT, fn), w, h, 'White')
    return fn


shots = [shot(o, n, vw, f'step_{i + 1:02d}.png', so) for i, (t, o, n, vw, x, pr, so) in enumerate(STEPS)]
shot(FIN, FIN, 'top34', 'finished.png')
shot(FIN, FIN, 'top', 'finished_top.png')

# ---------------------------------------------------------------- content for make_guide_v03.py
BAG = {'head': ['Printed (PETG)', 'Electronics', 'Other'],
       'rows': [['Bracket ×1 (blue in the pictures)', 'ESP32 DevKit V1 ×1', 'Copper tape, 10 mm wide: 2 × 30 mm'],
                ['Carrier base ×1 (yellow)', '16-LED RGB ring with JST cable (no. 2) ×1', '1.75 mm filament: 3 × 30 mm'],
                ['Carrier deck ×1 (green)', '3-pin JST cable (no. 1) ×1', 'Neodymium magnets 10 × 10 × 2 mm ×2'],
                ['', '', 'Metal washer ×1 (touch pad)'],
                ['', '', '1 mm double-sided foam tape, painter\'s tape']]}
TOOLS = [('Soldering iron and solder', 'for the power wires and the contact pads'),
         ('Wire cutter and stripper', 'to cut the JST cable wires and trim the filament'),
         ('Scissors', 'for the copper tape and painter\'s tape')]
TROUBLE = [
    ('Nothing lights up on the wall', 'The contact pads don\'t touch the rails, or a power wire is loose',
     'Steps 2–3: check the solders and add a little more solder on the pads'),
    ('LEDs dark but the ESP32 is on', 'LED connector (no. 2) the wrong way round', 'Step 7: red wire nearest the edge'),
    ('ESP32 doesn\'t power up', 'Power connector (no. 1) in the wrong socket or the wrong way round',
     'Step 6: [−] / PWR socket, red wire nearest the edge'),
    ('Touch does nothing', 'Washer covered by tape, or the wire is loose on the washer', 'Step 14: bare washer, wire twisted on firmly'),
    ('Node won\'t sit flat on the wall', 'Filament sticking out under the bracket, or a magnet standing proud',
     'Step 12: trim the filament flush; press the magnets fully into their pockets'),
    ('Parts don\'t line up', 'Carrier base turned round', 'Step 5: [+] over [+], [−] over [−]'),
]
json.dump({'steps': [{'title': t, 'text': x, 'parts': pr, 'image': fn}
                     for (t, o, n, vw, x, pr, so), fn in zip(STEPS, shots)],
           'finished': 'finished.png', 'finished_top': 'finished_top.png', 'trouble': TROUBLE, 'bag': BAG, 'tools': TOOLS},
          open(os.path.join(OUT, 'guide_content.json'), 'w'), indent=1, ensure_ascii=False)
App.closeDocument(doc.Name)
os.remove(TMP)
print('guide pictures + guide_content.json written to', OUT)
