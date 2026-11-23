python3 scripts/lightburn.py && python3 scripts/lightburn.py --proto && cd export/print && SL=/home/anool/Documents/AI/FreeCAD_AI/SnapBox/scripts/slice_bambu.py && rm -f HexNode_v03_*gcode* && python3 $SL --out HexNode_v03_node_pocket_P1S --filament "Bambu PETG" Bracket_v03_pocket.stl Carrier_v03_A_base.stl Carrier_v03_B_deck.stl 2>&1 | grep -E '"time|filament_g|md5|warnings' && python3 $SL --out HexNode_v03_bracket_embed_P1S --filament "Bambu PETG" Bracket_v03_embed.stl 2>&1 | grep -E '"time|filament_g|md5|warnings' && python3 - <<'EOF'
import zipfile, hashlib, os
name="HexNode_v03_bracket_embed_P1S"
g=open(name+".gcode").read()
i=g.index("; CHANGE_LAYER\n; Z_HEIGHT: 4.2\n")
j=g.index("G1 E-.04 F1800\n", i)+len("G1 E-.04 F1800\n"); assert j-i<400
g=g[:j]+"; PAUSE: drop the four magnets into the pockets (same way up), then resume\nG1 Z14 F1200\nM400 U1\n"+g[j:]
open(name+".gcode","w").write(g)
md5=hashlib.md5(g.encode()).hexdigest()
src=name+".gcode.3mf"; tmp=src+".tmp"
with zipfile.ZipFile(src) as zi, zipfile.ZipFile(tmp,"w",zipfile.ZIP_DEFLATED) as zo:
    for it in zi.infolist():
        data=zi.read(it.filename)
        if it.filename=="Metadata/plate_1.gcode": data=g.encode()
        if it.filename=="Metadata/plate_1.gcode.md5":
            old=data.decode().strip(); data=(md5.upper() if old.isupper() else md5).encode()
        zo.writestr(it, data)
os.replace(tmp,src)
with zipfile.ZipFile(src) as z:
    gg=z.read("Metadata/plate_1.gcode"); m=z.read("Metadata/plate_1.gcode.md5").decode()
    print("embed md5 ok:", hashlib.md5(gg).hexdigest().lower()==m.strip().lower(), "pause:", gg.count(b"; PAUSE: drop"))
EOF
awk '/; Z_HEIGHT/{z=$3} /; FEATURE: Bridge/{print z}' HexNode_v03_bracket_embed_P1S.gcode | sort -u | tr '\n' ' '
