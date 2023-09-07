@echo off

timeout /t 1 /nobreak > NUL
openfiles > NUL 2>&1
if %errorlevel%==0 (
    echo Running
) else (
    echo Please Run The Script As An Administrator!
    echo ---------------------------------------------
    echo Right click and select 'Run as Administrator'
    echo ---------------------------------------------
    echo Press any key to exit..
    pause > NUL
    exit
)

echo The original creator of the script is ltx0101
echo .
echo .
echo .

echo Cleaning Windows Temporary folder
rmdir /s /q C:\Windows\Temp
mkdir C:\Windows\Temp
echo .

echo Cleaning User Temporary folder
rmdir /s /q %Temp%
mkdir %Temp%
echo .

echo Cleaning Windows Update cache
del /q "%windir%\SoftwareDistribution\Download\*.*"
echo .

echo Clean Windows Error Reporting files
del /q "%localappdata%\Microsoft\Windows\WER\ReportQueue\*.*"
echo .

echo Clean thumbnails cache
del /q "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.db"
echo .

echo Everything is clean now!

sfc /scannow

echo Ready!

echo Do you want to restart your PC now? (Y/N)
set /p choice=
if /i "%choice%"=="Y" (
    shutdown /r /f /t 0
) else (
    echo Restart cancelled.
    pause
)
pause