#!/usr/bin/env python3
"""HexNode update server: run on a laptop on the same Wi-Fi as the boards.

  python3 ota_server.py            then open http://localhost:8266

- Broadcasts "HEXNODE ver=<N> port=8266" on UDP 4211 every 2 s. Boards running an
  older version download /firmware.bin and reboot into it.
- Listens on UDP 4212 for the boards' status lines and shows them on the web page.
- Serves ota/firmware.bin and ota/version.txt, which ota_release.sh writes. A new
  release is picked up automatically; no restart needed.
- Test batch: while ota/test_ids.txt lists board ids, the beacon says "only=<ids>" and
  only those boards update. `ota_release.sh --all` deletes it to release to everyone.
- Download queue: at most MAX_DOWNLOADS boards download at once; the rest get
  HTTP 503 and retry on a later beacon, so the Wi-Fi never gets swamped.
Standard library only.
"""
import json, os, re, socket, threading, time
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

HTTP_PORT, BEACON_PORT, REPORT_PORT = 8266, 4211, 4212
OTA_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "ota")
FIRMWARE = os.path.join(OTA_DIR, "firmware.bin")
VERSION = os.path.join(OTA_DIR, "version.txt")
TEST_IDS = os.path.join(OTA_DIR, "test_ids.txt")
MAX_DOWNLOADS = 15       # boards downloading at the same time
ONLINE_S = 15            # a board is "online" if it reported in the last 15 s
FIELDS = ("id", "ver", "pos", "rssi", "links", "touch", "up")

boards = {}              # id -> {"ip":..., "seen": t, fields...}
lock = threading.Lock()
slots = threading.BoundedSemaphore(MAX_DOWNLOADS)
downloading = {}         # board ip -> number of downloads in progress


def release_version():
    try:
        with open(VERSION) as f:
            return int(f.read().strip())
    except (OSError, ValueError):
        return 0


def test_ids():
    """Board ids the current release is limited to; empty list = everyone."""
    try:
        with open(TEST_IDS) as f:
            return [i for i in f.read().replace(",", " ").split() if re.fullmatch(r"[0-9A-F]{8}", i)]
    except OSError:
        return []


def beacon():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
    while True:
        v = release_version()
        if v and os.path.exists(FIRMWARE):
            try:
                msg = f"HEXNODE ver={v} port={HTTP_PORT}"
                ids = test_ids()
                if ids:
                    msg += " only=" + ",".join(ids)
                s.sendto(msg.encode(), ("255.255.255.255", BEACON_PORT))
            except OSError as e:
                print("beacon send failed:", e)
        time.sleep(2)


def reports():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    s.bind(("", REPORT_PORT))
    while True:
        data, (ip, _) = s.recvfrom(512)
        pairs = (kv.split("=", 1) for kv in data.decode("latin-1").split() if "=" in kv)
        fields = {k: v[:32] for k, v in pairs if k in FIELDS}
        if "id" not in fields:
            continue
        with lock:
            new = fields["id"] not in boards
            boards[fields["id"]] = {**fields, "ip": ip, "seen": time.time()}
        if new:
            print(f"board {fields['id']} at {ip} v{fields.get('ver')} ({len(boards)} known)")


PAGE = """<!doctype html><html><head><meta charset="utf-8"><title>HexNode wall</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
body{font:14px system-ui,sans-serif;margin:16px;background:#111;color:#eee}
#sum{font-size:18px;margin-bottom:12px} .grid{display:flex;flex-wrap:wrap;gap:6px}
.b{width:150px;padding:6px;border-radius:6px;font-size:12px;line-height:1.4}
.ok{background:#14532d}.old{background:#854d0e}.off{background:#3f3f46;color:#aaa}
.b b{font-size:13px} .t{outline:2px solid #fff} #sum{line-height:1.6}
</style></head><body>
<div id="sum">loading...</div><div class="grid" id="g"></div>
<script>
function line(parent, text, bold) {
  const el = document.createElement(bold ? 'b' : 'div');
  el.textContent = text;
  parent.appendChild(el);
}
async function tick() {
  const d = await (await fetch('/api/boards')).json();
  const on = d.boards.filter(b => b.online), latest = on.filter(b => +b.ver === d.release);
  const stage = d.test_ids.length ? `TEST BATCH (${d.test_ids.length} boards) - run ota_release.sh --all when they look good`
                                  : 'released to all';
  document.getElementById('sum').textContent =
    `release v${d.release}  |  ${stage}  |  ${on.length} online  |  ${latest.length} on v${d.release}  |  ` +
    `${on.length - latest.length} old  |  downloading ${d.downloading}/${d.max_downloads}  |  ` +
    `${d.boards.length - on.length} offline`;
  const g = document.getElementById('g');
  g.replaceChildren(...d.boards.map(b => {
    const box = document.createElement('div');
    box.className = 'b ' + (!b.online ? 'off' : (+b.ver === d.release ? 'ok' : 'old')) +
                    (b.touch === '1' ? ' t' : '');
    line(box, `${b.id} v${b.ver}${b.test ? '  [test]' : ''}${b.downloading ? '  ↓' : ''}`, true);
    line(box, `pos ${b.pos} · ${b.ip}`);
    line(box, `${b.rssi} dBm · ${b.links} links · up ${b.up}s`);
    if (!b.online) line(box, `last seen ${b.ago}s ago`);
    return box;
  }));
}
tick(); setInterval(tick, 2000);
</script></body></html>"""


class Handler(BaseHTTPRequestHandler):
    def log_message(self, fmt, *args):
        if self.path.startswith("/firmware"):
            print(f"{self.client_address[0]} {fmt % args}")

    def send(self, code, body, ctype):
        self.send_response(code)
        self.send_header("Content-Type", ctype)
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def do_GET(self):
        if self.path == "/":
            self.send(200, PAGE.encode(), "text/html; charset=utf-8")
        elif self.path == "/api/boards":
            now = time.time()
            with lock:
                rows = [{**b, "online": now - b["seen"] < ONLINE_S, "ago": int(now - b["seen"])}
                        for b in boards.values()]
            rows.sort(key=lambda b: b["id"])
            ids = test_ids()
            for b in rows:
                b["test"] = b["id"] in ids
                b["downloading"] = downloading.get(b["ip"], 0) > 0
            self.send(200, json.dumps({"release": release_version(), "test_ids": ids,
                                       "downloading": sum(downloading.values()), "max_downloads": MAX_DOWNLOADS,
                                       "boards": rows}).encode(), "application/json")
        elif self.path == "/firmware.bin" and os.path.exists(FIRMWARE):
            if not slots.acquire(blocking=False):
                self.send(503, b"busy, retry later", "text/plain")
                return
            ip = self.client_address[0]
            with lock:
                downloading[ip] = downloading.get(ip, 0) + 1
            try:
                # small send buffer: the slot stays taken until the board has really received the data
                self.connection.setsockopt(socket.SOL_SOCKET, socket.SO_SNDBUF, 32768)
                with open(FIRMWARE, "rb") as f:
                    self.send(200, f.read(), "application/octet-stream")
            except OSError as e:
                print(f"{ip} download aborted: {e}")
            finally:
                with lock:
                    downloading[ip] -= 1
                    if not downloading[ip]:
                        del downloading[ip]
                slots.release()
        else:
            self.send(404, b"not found", "text/plain")


if __name__ == "__main__":
    os.makedirs(OTA_DIR, exist_ok=True)
    threading.Thread(target=beacon, daemon=True).start()
    threading.Thread(target=reports, daemon=True).start()
    v = release_version()
    print(f"Release: v{v}" if v else "No release yet: run ./ota_release.sh")
    print(f"Status page: http://localhost:{HTTP_PORT}   (Ctrl+C to stop)")
    ThreadingHTTPServer(("", HTTP_PORT), Handler).serve_forever()
