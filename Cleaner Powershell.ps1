# This script was created by ltx0101

# Check if running with administrator privileges, and if not, relaunch as administrator
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process -FilePath "powershell" -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

# Menu
$choice = Read-Host @"
Choose:
1. Clean
2. Optimize
3. Clean and Optimize
4. Upgrade All Apps
0. Exit
"@

if ($choice -eq "1") {
    Write-Host "Cleaning temporary files..."
    Remove-Item -Path "$env:temp\*" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "C:\Windows\Temp\*" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "C:\Windows\Prefetch\*" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "C:\Windows\SoftwareDistribution\Download\*" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:userprofile\AppData\Local\Microsoft\Windows\Explorer\ThumbCacheToDelete\*" -Force -Recurse -ErrorAction SilentlyContinue
    Write-Host "Temporary files cleaned."

    $restartChoice = Read-Host "Do you want to restart your PC now? (Y/N)"
    if ($restartChoice -eq "Y") {
        Shutdown /r /f /t 0
    }
    else {
        Write-Host "Restart cancelled."
        Read-Host "Press Enter to exit"
    }
}

if ($choice -eq "2") {
    sfc /scannow
    chkdsk /F C:
    DISM /Online /Cleanup-Image /RestoreHealth
    sfc /scannow

    $restartChoice = Read-Host "Do you want to restart your PC now? (Y/N)"
    if ($restartChoice -eq "Y") {
        Shutdown /r /f /t 0
    }
    else {
        Write-Host "Restart cancelled."
        Read-Host "Press Enter to exit"
    }
}

if ($choice -eq "3") {
    Write-Host "Cleaning temporary files..."
    Remove-Item -Path "$env:temp\*" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "C:\Windows\Temp\*" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "C:\Windows\Prefetch\*" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "C:\Windows\SoftwareDistribution\Download\*" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:userprofile\AppData\Local\Microsoft\Windows\Explorer\ThumbCacheToDelete\*" -Force -Recurse -ErrorAction SilentlyContinue
	Write-Host "Done!"

    Write-Host "This is going to take a while..."
    sfc /scannow
    chkdsk /F C:
    DISM /Online /Cleanup-Image /RestoreHealth
    sfc /scannow

    $restartChoice = Read-Host "Do you want to restart your PC now? (Y/N)"
    if ($restartChoice -eq "Y") {
        Shutdown /r /f /t 0
    }
    else {
        Write-Host "Restart cancelled."
        Read-Host "Press Enter to exit"
    }
}

if ($choice -eq "4") {
	# Install Winget if not already installed
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Winget..."
    Invoke-Expression -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://aka.ms/installwinget'))"
    } else {
    Write-Host "Winget is already installed."
    }

    # Open a new PowerShell window to upgrade all installed apps using Winget
    Write-Host "Opening a new PowerShell window to upgrade all installed apps..."
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command winget upgrade --all" -Wait
}
if ($choice -eq "0") {
    Exit
}
Read-Host 'Press Enter to exit'
