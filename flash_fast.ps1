# flash_fast.ps1 - Windows version of flash_fast.sh.
# Flashes every ESP32 you plug in, several at the same time (use a USB hub).
# No questions asked: keep plugging boards in. Ctrl+C when done.
#
#   Double-click flash_fast.bat          compile once (if the source is here), then flash
#   flash_fast.bat -NoCompile            reuse the last build (skips the ~30 s compile)
#
# With a ready-made firmware\ folder next to this script (the shared package), it skips
# compiling and only needs esptool:  pip install esptool
#
# Check each board afterwards by touching D13: the blue onboard LED lights and, if a
# ring is attached, the whole ring glows white; let go and the glow goes away.
# Saved positions are kept (only the program area is written). Log: flash_fast_log.csv
param([switch]$NoCompile)
# 'Continue': under 'Stop', Windows PowerShell 5.1 aborts when a program merely writes to stderr
$ErrorActionPreference = 'Continue'

$Dir     = $PSScriptRoot
$Sketch  = Join-Path $Dir 'Code\HexNode_01'
$LogFile = Join-Path $Dir 'flash_fast_log.csv'
$JobDir  = Join-Path $Dir '.flash_jobs'
$Arduino = Join-Path $env:LOCALAPPDATA 'Arduino15\packages\esp32'

function Test-Cmd($name) { [bool](Get-Command $name -ErrorAction SilentlyContinue) }
function Test-PyModule($py) {
  if (-not (Test-Cmd $py)) { return $false }
  try { & $py -c 'import esptool' 2>$null; return $LASTEXITCODE -eq 0 } catch { return $false }
}

# esptool: the copy inside the Arduino esp32 core, else a pip install
$bundled = Get-ChildItem "$Arduino\tools\esptool_py\*\esptool.exe" -ErrorAction SilentlyContinue |
           Sort-Object FullName | Select-Object -Last 1
if ($bundled)                  { $Esp = @($bundled.FullName) }
elseif (Test-Cmd 'esptool')    { $Esp = @('esptool') }
elseif (Test-Cmd 'esptool.py') { $Esp = @('esptool.py') }
elseif (Test-PyModule 'python') { $Esp = @('python', '-m', 'esptool') }
elseif (Test-PyModule 'py')     { $Esp = @('py', '-m', 'esptool') }
else { Write-Host 'esptool not found. Install Python, then:  pip install esptool'; exit 1 }
# Start-Process needs a real program; resolve "esptool" / "python" to its full path
$EspExe  = (Get-Command $Esp[0]).Source
$EspArgs = @($Esp | Select-Object -Skip 1)

if (Test-Path $Sketch) {
  $FW = Join-Path $Dir '.build'
  if (-not $NoCompile) {
    if (-not (Test-Cmd 'arduino-cli')) { Write-Host 'arduino-cli not found (or use a package with a firmware\ folder).'; exit 1 }
    Write-Host 'Compiling once...'
    $out = & arduino-cli compile --fqbn esp32:esp32:esp32 --output-dir $FW $Sketch 2>&1
    if ($LASTEXITCODE -ne 0) { $out | Select-Object -Last 15 | Write-Host; exit 1 }
    $out | Select-String 'Sketch uses' | Write-Host
  }
  $bootApp0 = Get-ChildItem "$Arduino\hardware\esp32\*\tools\partitions\boot_app0.bin" -ErrorAction SilentlyContinue |
              Sort-Object FullName | Select-Object -Last 1
  if ($bootApp0) { Copy-Item $bootApp0.FullName (Join-Path $FW 'boot_app0.bin') -Force }
} else {
  $FW = Join-Path $Dir 'firmware'   # shared package: prebuilt firmware
  Write-Host "Using prebuilt firmware in $FW"
}
foreach ($f in 'HexNode_01.ino.bootloader.bin', 'HexNode_01.ino.partitions.bin', 'boot_app0.bin', 'HexNode_01.ino.bin') {
  if (-not (Test-Path (Join-Path $FW $f))) { Write-Host "Missing $FW\$f"; exit 1 }
}

# USB serial ports of ESP32 boards (CP210x, CH340/CH9102, FTDI, native USB); skips built-in COM1
function Get-BoardPorts {
  try {
    Get-CimInstance Win32_PnPEntity -Filter "Name LIKE '%(COM%'" -ErrorAction Stop |
      Where-Object { $_.Name -match 'CP210|CH340|CH910|CH343|USB|UART|FTDI' } |
      ForEach-Object { if ($_.Name -match '\((COM\d+)\)') { $Matches[1] } }
  } catch {
    [System.IO.Ports.SerialPort]::GetPortNames() | Where-Object { $_ -ne 'COM1' }
  }
}

function Start-Flash($port, $baud, $attempt) {
  $q = { param($s) '"' + $s + '"' }   # quote every argument: paths may contain spaces
  $a = $EspArgs + @('--chip', 'esp32', '--port', $port, '--baud', $baud, 'write_flash', '-z',
         '--flash_mode', 'dio', '--flash_freq', '80m', '--flash_size', '4MB',
         '0x1000',  (Join-Path $FW 'HexNode_01.ino.bootloader.bin'),
         '0x8000',  (Join-Path $FW 'HexNode_01.ino.partitions.bin'),
         '0xe000',  (Join-Path $FW 'boot_app0.bin'),
         '0x10000', (Join-Path $FW 'HexNode_01.ino.bin'))
  $p = Start-Process -FilePath $EspExe -ArgumentList ($a | ForEach-Object { & $q $_ }) -NoNewWindow -PassThru `
         -RedirectStandardOutput (Join-Path $JobDir "$port.$attempt.out") `
         -RedirectStandardError  (Join-Path $JobDir "$port.$attempt.err")
  $null = $p.Handle   # without this, ExitCode can come back empty once the process has ended
  @{ Proc = $p; Attempt = $attempt }
}

New-Item -ItemType Directory -Force $JobDir | Out-Null
Remove-Item (Join-Path $JobDir '*') -Force -ErrorAction SilentlyContinue
if (-not (Test-Path $LogFile)) { 'time,port,flash' | Set-Content $LogFile }

# A port is "seen" from the moment it is flashed until it has been missing for 3 s in a
# row; ports blink out during a flash or reset, so a short gap must not count as a new board.
$seen = @{}; $gone = @{}; $busy = @{}
$ok = 0; $bad = 0
Write-Host 'Ready. Plug in ESP32s (several at once is fine). Ctrl+C to stop.'
try {
  while ($true) {
    $ports = @(Get-BoardPorts)
    foreach ($p in $ports) {
      $gone.Remove($p)
      if ($seen.ContainsKey($p)) { continue }
      $seen[$p] = $true
      Write-Host "--> flashing $p"
      $busy[$p] = Start-Flash $p 460800 1
    }

    foreach ($p in @($busy.Keys)) {
      $job = $busy[$p]
      if (-not $job.Proc.HasExited) { continue }
      $job.Proc.WaitForExit()
      if ($job.Proc.ExitCode -eq 0) {
        $busy.Remove($p); $ok++
        "$(Get-Date -Format HH:mm:ss),$p,ok" | Add-Content $LogFile
        [System.Media.SystemSounds]::Asterisk.Play()
        Write-Host "    OK  $p done ($ok flashed). Touch D13 to check, then unplug." -ForegroundColor Green
      } elseif ($job.Attempt -eq 1) {
        Start-Sleep -Seconds 1
        $busy[$p] = Start-Flash $p 115200 2      # slow retry if the fast one fails
      } else {
        $busy.Remove($p); $bad++
        "$(Get-Date -Format HH:mm:ss),$p,FAILED" | Add-Content $LogFile
        [System.Media.SystemSounds]::Hand.Play()
        $why = Get-Content (Join-Path $JobDir "$p.2.out"), (Join-Path $JobDir "$p.2.err") -ErrorAction SilentlyContinue |
               Where-Object { $_ -match 'error|fatal' -and $_ -notmatch '^Note' } | Select-Object -Last 1
        Write-Host "    FAIL $p : $why" -ForegroundColor Red
        Write-Host '       Unplug, then replug while holding BOOT.'
      }
    }

    foreach ($p in @($seen.Keys)) {
      if ($ports -contains $p -or $busy.ContainsKey($p)) { continue }
      $gone[$p] = 1 + [int]$gone[$p]
      if ($gone[$p] -ge 3) { $seen.Remove($p); $gone.Remove($p) }
    }
    Start-Sleep -Seconds 1
  }
} finally {
  Write-Host ''
  Write-Host "Done: $ok flashed, $bad failed."
}
