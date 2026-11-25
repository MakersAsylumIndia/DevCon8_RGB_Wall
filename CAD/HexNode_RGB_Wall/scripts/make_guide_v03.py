# Lays out the HexNode v03 assembly guide in the Maker's Asylum slide style (same layout as the MA_AI_Bot_01
# guide: 16:9 pages, white pages with the MA logo top-right, yellow title panel; Titillium Web titles, Lato body,
# official colours), then prints the PDF with headless Chrome.
# Run after render_guide_v03.py (in FreeCAD) has written export/guide/assets/guide_content.json:
#   ~/.venvs/maker/bin/python scripts/make_guide_v03.py
import html, json, os, re, shutil, subprocess
from PIL import Image, ImageChops

HERE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT = os.path.join(HERE, 'export', 'guide')
ASSETS = os.path.join(OUT, 'assets')   # pictures, logos and guide_content.json
BRAND = os.path.join(HERE, 'ref', 'brand')
NAME = 'HexNode v03'
FILE = 'HexNode_v03'
GITHUB = 'https://github.com/MakersAsylumIndia/DevCon8_RGB_Wall'
SITE = 'https://www.makersasylum.com'
# MA style guide colours: Lightning Yellow, Tundora, Ship Gray, Gray, Silver, Alabaster
YELLOW, INK, GREY, MID, LINE, PALE = '#FCBF15', '#231F20', '#414042', '#898989', '#CCCCCC', '#F8F8F8'

C = json.load(open(os.path.join(ASSETS, 'guide_content.json')))
for f in ('MA_Standard_Black.svg', 'MA_Standard_Color.svg', 'MBC_wordmark.svg'):
    shutil.copy(os.path.join(BRAND, f), ASSETS)


def trimmed(fn, pad=0.04):
    """Copy of a render with the white margin cut away (keeps a small border)."""
    im = Image.open(os.path.join(ASSETS, fn)).convert('RGB')
    box = ImageChops.difference(im, Image.new('RGB', im.size, 'white')).getbbox() or (0, 0) + im.size
    p = int(pad * max(box[2] - box[0], box[3] - box[1]))
    box = (max(0, box[0] - p), max(0, box[1] - p), min(im.width, box[2] + p), min(im.height, box[3] + p))
    out = 't_' + fn
    im.crop(box).save(os.path.join(ASSETS, out))
    return 'assets/' + out


def bag_table():
    """'In the bag' table (from the guide content)."""
    esc = lambda t: html.escape(t)
    th = ''.join(f'<th>{esc(h)}</th>' for h in C['bag']['head'])
    tb = ''.join('<tr>' + ''.join(f'<td>{esc(c)}</td>' for c in r) + '</tr>' for r in C['bag']['rows'])
    return f'<table class="bag"><tr>{th}</tr>{tb}</table>'


pages = []


def page(body, n, cls=''):
    pages.append(f'''<section class="page {cls}">
  <img class="ma" src="assets/MA_Standard_Color.svg" alt="Maker's Asylum">
  {body}
  <div class="pn">{n}</div>
</section>''')


# ---- cover (template title layout: yellow left half with the MA logo, MBC logo top-right)
pages.append(f'''<section class="page cover">
  <div class="panel">
    <img class="ma-big" src="assets/MA_Standard_Black.svg" alt="Maker's Asylum">
    <h1>{NAME}</h1>
    <p class="sub">RGB wall node<br>Assembly guide</p>
    <p class="meta">Soldering iron · wire stripper · scissors · about 30–45 minutes</p>
  </div>
  <div class="right">
    <img class="mbc" src="assets/MBC_wordmark.svg" alt="make. break. create.">
    <img class="hero" src="{trimmed(C['finished'])}" alt="The finished node">
    <div class="links">
      <div><span>Files &amp; design</span> <a href="{GITHUB}">{GITHUB.replace('https://', '')}</a></div>
      <div><span>Maker's Asylum</span> <a href="{SITE}">{SITE.replace('https://www.', '')}</a></div>
    </div>
  </div>
</section>''')

n = 2
acc = ''.join(f'<li><b>{html.escape(a)}</b> {html.escape(b)}</li>' for a, b in C['tools'])
page(f'''<h2>In the bag</h2>
  <div class="bagwrap">{bag_table()}</div>
  <h3>Tools</h3>
  <ul class="acc">{acc}</ul>''', n)

for i, s in enumerate(C['steps'], 1):
    n += 1
    chips = ''.join(f'<li>{html.escape(p)}</li>' for p in s['parts'])
    page(f'''<h2><span class="num">{i}</span>{html.escape(s['title'])}</h2>
  <div class="cols">
    <div class="txt"><ul class="parts">{chips}</ul><p>{s['text']}</p></div>
    <div class="pic"><img src="{trimmed(s['image'])}" alt="Step {i}"></div>
  </div>''', n, 'step')

n += 1
rows = ''.join(f'<tr><td>{a}</td><td>{b}</td><td>{c}</td></tr>' for a, b, c in C['trouble'])
page(f'''<h2>If it doesn't work</h2>
  <table class="trouble"><tr><th>What you see</th><th>Cause</th><th>Fix</th></tr>{rows}</table>''', n)

n += 1
page(f'''<h2>On the wall</h2>
  <div class="cols">
    <div class="txt">
      <p>Press the node onto its place on the RGB Node Wall: the magnets hold it, and the soldered pads on the spring tabs pick up +5V and GND from the copper rails. <b>Enjoy!</b></p>
      <p>The node is fully parametric. The printed parts, the laser-cut rails and the pictures in this guide come from one FreeCAD script, and the firmware is in the same repository.</p>
      <p class="links2"><b>Design files</b><br><a href="{GITHUB}">{GITHUB.replace('https://', '')}</a><br><br>
         <b>Maker's Asylum</b><br><a href="{SITE}">{SITE.replace('https://www.', '')}</a></p>
      <p class="lic">Hardware: CERN-OHL-S-2.0 · Software: MIT · Documentation: CC BY 4.0</p>
    </div>
    <div class="pic"><img src="{trimmed('finished.png')}" alt="Finished node"></div>
  </div>''', n, 'step')

CSS = f'''
@page {{ size: 10in 5.625in; margin: 0; }}
* {{ box-sizing: border-box; }}
html {{ -webkit-print-color-adjust: exact; print-color-adjust: exact; }}
body {{ margin: 0; background: #ddd; font-family: "Lato", sans-serif; color: {INK}; }}
h1, h2, .num, .sub, th, .links span, .links2 b {{ font-family: "Titillium Web", sans-serif; }}
.page {{ position: relative; width: 10in; height: 5.625in; background: #fff; overflow: hidden;
         margin: 0 auto 12px; page-break-after: always; break-after: page; padding: 0.34in 0.34in 0.3in; }}
.page .ma {{ position: absolute; top: 0.22in; right: 0.32in; width: 1.42in; }}
.pn {{ position: absolute; right: 0.3in; bottom: 0.18in; font-size: 10pt; color: {MID}; }}
h2 {{ font-size: 26pt; font-weight: 700; margin: 0.02in 1.7in 0.18in 0; display: flex; align-items: center; gap: 0.16in; }}
.num {{ background: {YELLOW}; color: {INK}; font-weight: 700; font-size: 20pt; width: 0.5in; height: 0.5in;
        border-radius: 50%; display: inline-grid; place-items: center; flex: none; }}
.cols {{ display: grid; grid-template-columns: 0.95fr 1.15fr; gap: 0.3in; height: 4.25in; align-items: center; }}
.txt {{ font-size: 13pt; line-height: 1.42; color: {GREY}; }}
.txt b {{ color: {INK}; }}
.parts {{ list-style: none; padding: 0; margin: 0 0 0.14in; display: flex; flex-wrap: wrap; gap: 6px; }}
.parts li {{ background: {PALE}; border-left: 4px solid {YELLOW}; padding: 2px 9px; font-size: 10.5pt; color: {INK}; }}
.pic {{ height: 100%; display: flex; align-items: center; justify-content: center; }}
.pic img {{ max-width: 100%; max-height: 4.2in; }}
table {{ border-collapse: collapse; width: 100%; font-size: 10.5pt; color: {GREY}; }}
th {{ background: {YELLOW}; color: {INK}; text-align: left; padding: 5px 8px; }}
td {{ border-bottom: 1px solid {LINE}; padding: 5px 8px; vertical-align: top; }}
td b {{ color: {INK}; }}
.bagwrap {{ margin-top: 0.05in; }}
h3 {{ font-family: "Titillium Web", sans-serif; font-weight: 700; font-size: 14pt; margin: 0.16in 0 0.04in; }}
.acc {{ list-style: none; padding: 0; margin: 0; display: flex; gap: 0.3in; font-size: 10.5pt; color: {GREY}; }}
.acc li {{ border-left: 4px solid {YELLOW}; padding-left: 8px; }}
.acc b {{ color: {INK}; display: block; }}
.trouble td:first-child {{ color: {INK}; font-weight: 700; width: 26%; }}
.cover {{ padding: 0; display: grid; grid-template-columns: 50% 50%; }}
.cover .panel {{ background: {YELLOW}; padding: 0.3in 0.45in; position: relative; }}
.ma-big {{ width: 3.4in; }}
.cover h1 {{ font-size: 42pt; font-weight: 700; margin: 0.45in 0 0.04in; }}
.cover .sub {{ font-size: 21pt; font-weight: 300; margin: 0; line-height: 1.2; }}
.cover .meta {{ position: absolute; left: 0.45in; bottom: 0.32in; margin: 0; font-size: 11pt; }}
.cover .right {{ position: relative; padding: 0.3in; }}
.mbc {{ position: absolute; top: 0.18in; right: 0.32in; width: 1.45in; z-index: 2; }}
.hero {{ position: absolute; left: 0.3in; right: 0.3in; top: 1.35in; width: calc(100% - 0.6in); height: calc(100% - 2.4in); object-fit: contain; }}
.links {{ position: absolute; left: 0.3in; right: 0.3in; bottom: 0.25in; font-size: 10.5pt; color: {GREY}; }}
.links span {{ display: inline-block; width: 1.25in; color: {INK}; font-weight: 700; }}
a {{ color: {INK}; text-decoration: none; border-bottom: 2px solid {YELLOW}; }}
.links2 {{ font-size: 12pt; }}
.lic {{ font-size: 9.5pt; color: {GREY}; margin-top: 0.25in; }}
@media print {{ body {{ background: #fff; }} .page {{ margin: 0; }} }}
'''

doc = f'''<!doctype html>
<html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>HexNode Assembly Guide</title><style>{CSS}</style></head>
<body>
{chr(10).join(pages)}
</body></html>'''
html_path = os.path.join(OUT, f'{FILE}_assembly_guide.html')
open(html_path, 'w').write(doc)
pdf = os.path.join(OUT, f'{FILE}_assembly_guide.pdf')
subprocess.run(['google-chrome', '--headless=new', '--disable-gpu', '--no-pdf-header-footer',
                '--allow-file-access-from-files', f'--print-to-pdf={pdf}', 'file://' + html_path],
               check=True, capture_output=True, timeout=120)
print(f'{len(pages)} pages ->', pdf)
