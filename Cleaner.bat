@echo off
setlocal enabledelayedexpansion

:: Check for administrator privileges
openfiles > NUL 2>&1
if %errorlevel% neq 0 (
    echo Please Run The Script As An Administrator!
    echo ---------------------------------------------
    echo Right-click and select 'Run as Administrator'
    echo ---------------------------------------------
    echo Press any key to exit...
    pause > NUL
    exit /b 1
)

echo The original creator of the script is ltx0101
echo .
echo .
echo .

:: Cleanup
echo Cleaning Windows Temporary folder
rmdir /s /q C:\Windows\Temp
mkdir C:\Windows\Temp
echo Done
echo.
echo.

echo Cleaning User Temporary folder
rmdir /s /q "%TEMP%"
mkdir "%TEMP%"
echo Done
echo.
echo.

echo Cleaning Windows Update cache
del /q "%windir%\SoftwareDistribution\Download\*.*"
echo Done
echo.
echo.

echo Cleaning Windows Error Reporting files
del /q "%localappdata%\Microsoft\Windows\WER\ReportQueue\*.*"
echo Done
echo.
echo.

echo Cleaning thumbnails cache
del /q "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.db"
echo Done
echo.
echo.

:: Prompt for restart
echo.
echo Ready!
set /p restartChoice=Do you want to restart your PC now? (Y/N)
if /i "!restartChoice!"=="Y" (
    shutdown /r /f /t 0
) else (
    echo Restart cancelled.
    pause
)
