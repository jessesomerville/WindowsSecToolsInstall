#Requires -RunAsAdministrator

# In order to run scripts, run the following command:
# Set-ExecutionPolicy Bypass -Scope Process -Force

function CreateShortcut {
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [string] $SourceFile,
        [Parameter(Mandatory=$true, Position=0)]
        [string] $ShortcutFile
    )
    $WScriptShell        = New-Object -ComObject WScript.Shell
    $Shortcut            = $WScriptShell.CreateShortcut($ShortcutFile)
    $Shortcut.TargetPath = $SourceFile
    $Shortcut.Save()
}

# Powershell 7
Write-Host "[+] Installing Powershell 7 Module"
Install-Module -name PSReleaseTools -Force | Out-Null
Write-Host "[+] Installing PSPreview. This can take a few minutes"
Install-PSPreview -mode Quiet

# chocolatey
Write-Host "[+] Installing chocolatey package manager"
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Firefox
Write-Host "[+] Installing Firefox"
choco install firefox -y --force | Out-Null

# Windows Terminal
Write-Host "[+] Installing Windows Terminal"
choco install microsoft-windows-terminal -y --force | Out-Null

# Sysinternals
Write-Host "[+] Installing SysInternals"
choco install sysinternals --params "/InstallDir:$HOME\Desktop\SysInternals" -y --force | Out-Null

# PESecurity
# Write-Host "[+] Installing PESecurity"
# $Url = "https://raw.githubusercontent.com/NetSPI/PESecurity/master/Get-PESecurity.psm1"
# $OutFile = "$HOME\Documents\Get_PESecurity.psm1"
# Invoke-WebRequest -Uri $Url -OutFile $OutFile | Out-Null
# "Import $($OutFile)" >> $PROFILE

# Wireshark
Write-Host "[+] Installing Wireshark"
choco install Wireshark -y --force | Out-Null
$WiresharkFile = "C:\Program Files\Wireshark\Wireshark.exe"
$ShortcutFile = "$HOME\Desktop\Wireshark.lnk"
CreateShortcut -SourceFile $WiresharkFile -ShortcutFile $ShortcutFile

# vim
Write-Host "[+] Installing vim"
choco install vim -y --force --params "/NoDesktopShortcuts" | Out-Null

# oh-my-posh
Write-Host "[+] Installing posh"
# Download Powerline Compatible Font
Write-Host "[+] Installing Powerline Font"
$Url             = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/InconsolataGo.zip"
$TempFolder      = "$($env:TEMP)\Fonts"
$ZipFile         = "$($TempFolder)\InconsolataGo.zip"
$UserFontsFolder = "$HOME\AppData\Local\Microsoft\Windows\Fonts\"
$FontName        = "InconsolataGo Nerd Font Complete Mono Windows Compatible.ttf"

New-Item -ItemType Directory -Force -Path $TempFolder
New-Item $TempFolder -Type Directory -Force | Out-Null
If (-not(Test-Path $ZipFile)) {
    Invoke-WebRequest -Uri $Url -OutFile $ZipFile | Out-Null
}
if (-not(Test-Path "$($TempFolder)\$($FontName)")) {
    $ExtractShell = New-Object -ComObject Shell.Application
    $Files = $ExtractShell.Namespace($ZipFile).Items()
    $ExtractShell.NameSpace($TempFolder).CopyHere($Files)
}
If (-not(Test-Path "$($UserFontsFolder)$($FontName)")) {
    $InstallFontShell = (New-Object -ComObject Shell.Application).NameSpace(0x14)
    $InstallFontShell.CopyHere("$($TempFolder)$($FontName)")
}
Remove-Item -path $TempFolder -recurse

# Install posh-git and oh-my-posh
Install-Module posh-git -y | Out-Null
Install-Module oh-my-posh -y | Out-Null

# Persist posh settings to user profile
"Set-Prompt" >> $PROFILE
"Set-Theme star" >> $PROFILE