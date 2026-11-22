@echo off
rem Runs prx.ps1 from cmd.exe, scripts and shells that do not load .ps1 files.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0prx.ps1" %*
exit /b %ERRORLEVEL%
