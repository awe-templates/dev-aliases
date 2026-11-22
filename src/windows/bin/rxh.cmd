@echo off
rem Runs rxh.ps1 from cmd.exe, scripts and shells that do not load .ps1 files.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0rxh.ps1" %*
exit /b %ERRORLEVEL%
