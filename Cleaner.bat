@echo off
echo The original creator of the script is ltx0101
echo .
echo .
echo .

cd %temp%
del /q /f /s *.* > nul 2>&1
cd ..

cd C:\Windows\Temp
del /q /f /s *.* > nul 2>&1
cd ..

cd C:\Windows\Prefetch
del /q /f /s *.* > nul 2>&1
cd ..

cd C:\Windows\SoftwareDistribution\Download
del /q /f /s *.* > nul 2>&1
cd ..

cd %userprofile%\AppData\Local\Microsoft\Windows\Explorer\ThumbCacheToDelete
del /q /f /s *.* > nul 2>&1
cd ..

echo Temporary files cleaned.
set /p restartChoice=Do you want to restart your PC now? (Y/N)
if /i "!restartChoice!"=="Y" (
    shutdown /r /f /t 0
) else (
    echo Restart cancelled.
    pause
)
