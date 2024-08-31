@echo off
setlocal enabledelayedexpansion

:: Define log file path
set "logFile=%~dp0cleaner.log"

:: Start logging
echo [%DATE% %TIME%] Starting cleanup... > "%logFile%"
powershell -Command "Write-Host 'Starting cleanup...' -ForegroundColor Cyan"

:: Check if running with administrative privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [%DATE% %TIME%] Error: Administrative rights required. >> "%logFile%"
    powershell -Command "Write-Host 'Error: Administrative rights required.' -ForegroundColor Red"
    echo This script must be run as Administrator.
    echo Please right-click and select "Run as administrator".
    pause
    exit /b 1
)

:: Clean TEMP directories
echo [%DATE% %TIME%] Cleaning TEMP directories... >> "%logFile%"
powershell -Command "Write-Host 'Cleaning TEMP directories...' -ForegroundColor Yellow"

:: Clean system TEMP folder
del /f /s /q %WINDIR%\TEMP\* >nul 2>&1
rd /s /q %WINDIR%\TEMP\* >nul 2>&1

:: Clean user TEMP folder
del /f /s /q %TEMP%\* >nul 2>&1
rd /s /q %TEMP%\* >nul 2>&1

echo [%DATE% %TIME%] TEMP directories cleaned. >> "%logFile%"
powershell -Command "Write-Host 'TEMP directories cleaned.' -ForegroundColor Green"

:: Flush DNS cache
echo [%DATE% %TIME%] Flushing DNS cache... >> "%logFile%"
powershell -Command "Write-Host 'Flushing DNS cache...' -ForegroundColor Magenta"

ipconfig /flushdns
if %errorlevel% neq 0 (
    echo [%DATE% %TIME%] Failed to flush DNS cache >> "%logFile%"
    powershell -Command "Write-Host 'Failed to flush DNS cache' -ForegroundColor Red"
) else (
    echo [%DATE% %TIME%] DNS cache flushed successfully. >> "%logFile%"
    powershell -Command "Write-Host 'DNS cache flushed successfully.' -ForegroundColor Green"
)

:: Finish and display completion message
echo [%DATE% %TIME%] Cleanup process completed. See cleaner.log for details. >> "%logFile%"
powershell -Command "Write-Host 'Cleanup process completed. See cleaner.log for details.' -ForegroundColor Green"
pause
exit /b 0
