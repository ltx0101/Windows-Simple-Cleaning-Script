title This script was created by ltx0101
@echo off
net session >nul 2>&1
if %errorlevel% equ 0 (
    echo Administrator PRIVILEGES Detected! 
) else (
   echo OOOOOOOO  OOOOOOOO   OOOOOOOO     OOOOOOO    OOOOOOOO  
   echo OO        OO     OO  OO     OO   OO     OO   OO     OO 
   echo OO        OO     OO  OO     OO  OO       OO  OO     OO 
   echo OOOOOO    OOOOOOOO   OOOOOOOO   OO       OO  OOOOOOOO  
   echo OO        OO    OO   OO    OO   OO       OO  OO    OO   
   echo OO        OO     OO  OO     OO   OO     OO   OO     OO  
   echo OOOOOOOO  OO      OO OO      OO   OOOOOOO    OO      OO 
   echo.
   echo.
   echo ERROR: Please run as Administrator
   echo This script must be run as administrator to work properly!
   pause
   exit /B 1
)

@echo off

setlocal enabledelayedexpansion
cls

echo Choose:
echo 1. Clean
echo 2. Optimize
echo 3. Clean and Optimize
echo 0. Exit

set /p choice=Choose:

if "%choice%"=="1" (
    echo Cleaning temporary files...
    del /q /f /s "%temp%\*.*" > nul 2>&1
    del /q /f /s "C:\Windows\Temp\*.*" > nul 2>&1
    del /q /f /s "C:\Windows\Prefetch\*.*" > nul 2>&1
    del /q /f /s "C:\Windows\SoftwareDistribution\Download\*.*" > nul 2>&1
    del /q /f /s "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\ThumbCacheToDelete\*.*" > nul 2>&1
    echo Temporary files cleaned.

    set /p "restartChoice=Do you want to restart your PC now? (Y/N)"
    if /i "!restartChoice!"=="Y" (
        shutdown /r /f /t 0
    ) else (
        echo Restart cancelled.
        pause
    )
)

if "%choice%"=="2" (
    sfc /scannow
    chkdsk
    DISM /online /cleanup-image /restorehealth
    sfc /scannow

    set /p "restartChoice=Do you want to restart your PC now? (Y/N)"
    if /i "!restartChoice!"=="Y" (
        shutdown /r /f /t 0
    ) else (
        echo Restart cancelled.
        pause
    )
)

if "%choice%"=="3" (
    echo Cleaning temporary files...
    del /q /f /s "%temp%\*.*" > nul 2>&1
    del /q /f /s "C:\Windows\Temp\*.*" > nul 2>&1
    del /q /f /s "C:\Windows\Prefetch\*.*" > nul 2>&1
    del /q /f /s "C:\Windows\SoftwareDistribution\Download\*.*" > nul 2>&1
    del /q /f /s "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\ThumbCacheToDelete\*.*" > nul 2>&1

    echo This is going to take a while...
    echo.
    echo.
    echo.
    sfc /scannow
    chkdsk
    DISM /online /cleanup-image /restorehealth
    sfc /scannow

    set /p "restartChoice=Do you want to restart your PC now? (Y/N)"
    if /i "!restartChoice!"=="Y" (
        shutdown /r /f /t 0
    ) else (
        echo Restart cancelled.
        pause
    )
)

if "%choice%"=="0" (
    exit
)
