#!/usr/bin/env python3
"""One serial session with a freshly flashed HexNode (stdlib only, used by hexnode.sh).

Keeps the port open for the whole check so nothing resets the board halfway:
waits for boot to finish, reads its id, optionally sets a position, runs the D13
touch test and flashes the ring. Prints result lines for hexnode.sh:
    ID id=XXXXXXXX pos=(q,r)
    TOUCH PASS | TOUCH FAIL | TOUCH STUCK
"""
import argparse, os, re, select, subprocess, sys, termios, time


def sound(name):
    subprocess.Popen(["afplay", f"/System/Library/Sounds/{name}.aiff"],
                     stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)


def say(msg):
    print(msg, file=sys.stderr, flush=True)


class Port:
    def __init__(self, path):
        self.fd = os.open(path, os.O_RDWR | os.O_NOCTTY | os.O_NONBLOCK)
        a = termios.tcgetattr(self.fd)
        a[0] = 0                                                  # iflag
        a[1] = 0                                                  # oflag
        a[2] = termios.CS8 | termios.CREAD | termios.CLOCAL       # cflag
        a[3] = 0                                                  # lflag
        a[4] = a[5] = termios.B115200
        a[6][termios.VMIN] = 0
        a[6][termios.VTIME] = 0
        termios.tcsetattr(self.fd, termios.TCSANOW, a)
        termios.tcflush(self.fd, termios.TCIOFLUSH)
        self.buf = ""

    def send(self, line):
        os.write(self.fd, (line + "\n").encode())

    def lines(self, seconds):
        """Yield complete lines received during the next `seconds`."""
        end = time.time() + seconds
        while time.time() < end:
            r, _, _ = select.select([self.fd], [], [], max(0.0, min(0.1, end - time.time())))
            if not r:
                continue
            try:
                chunk = os.read(self.fd, 4096)
            except BlockingIOError:
                continue
            if not chunk:
                raise OSError("port closed (board unplugged?)")
            self.buf += chunk.decode("latin-1").replace("\r", "")
            while "\n" in self.buf:
                line, self.buf = self.buf.split("\n", 1)
                yield line

    def wait_for(self, pattern, seconds):
        rx = re.compile(pattern)
        for line in self.lines(seconds):
            m = rx.search(line)
            if m:
                return m
        return None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("port")
    ap.add_argument("--touch", type=int, default=0, help="seconds to wait for a touch (0 = skip)")
    ap.add_argument("--ring", action="store_true", help="flash the ring red/green/blue")
    ap.add_argument("--pos", nargs=2, metavar=("Q", "R"))
    args = ap.parse_args()

    p = Port(args.port)

    # Boot ends with the "Commands:" line (after ring self-test + touch calibration).
    if not p.wait_for(r"^Commands:", 10):
        say("    (no boot message seen, carrying on)")
    time.sleep(0.3)

    p.send("info")
    m = p.wait_for(r"id=[0-9A-F]+\s+pos=\S+", 3)
    print("ID " + (re.sub(r"\s+", " ", m.group(0)) if m else "unknown"), flush=True)

    if args.pos:
        p.send(f"pos {args.pos[0]} {args.pos[1]}")
        if not p.wait_for(r"Position set", 3):
            say("    WARNING: board did not confirm the position")

    if args.touch:
        p.send("dbg")
        # Hands off: a TOUCH now means the sensor reads touched on its own.
        stuck = sum(1 for l in p.lines(1.5) if l.endswith("TOUCH")) >= 3
        if stuck:
            print("TOUCH STUCK", flush=True)
        else:
            sound("Ping")
            say(f"\n    >>> TOUCH THE D13 PIN NOW ({args.touch}s) <<<\n")
            ok = p.wait_for(r"TOUCH$", args.touch)
            print("TOUCH " + ("PASS" if ok else "FAIL"), flush=True)
        p.send("dbg")   # turn live readings off again
        time.sleep(0.2)

    if args.ring:
        p.send("ring")
        time.sleep(1.4)


if __name__ == "__main__":
    try:
        main()
    except OSError as e:
        print(f"ERROR {e}", flush=True)
        sys.exit(1)
