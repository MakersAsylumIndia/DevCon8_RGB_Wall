@echo off
rem Double-click to flash HexNode boards on Windows. Runs flash_fast.ps1 (same folder).
rem Add -NoCompile to reuse the last build:  flash_fast.bat -NoCompile
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0flash_fast.ps1" %*
pause
