# WindowsSecToolsInstall
Powershell script that installs some baseline tools that are useful for desktop application security testing.
This script is meant to be run on a new Windows 10 installation.

## Usage

1. Open an Administrator Powershell prompt
2. Allow running scripts `Set-ExecutionPolicy Bypass -Scope Process -Force`
3. Run the script `.\Install-Windows-Tools.ps1`. Select `Yes` when prompted
4. Set Terminal Font to support Powerline glyphs
    1. Open Windows Terminal
    2. Click Dropdown Arrow > Settings
    3. Add `"fontFace": "InconsolataGo Nerd Font Complete Mono Windows Compatible"` in the profiles > default section

## Tools

* Powershell 7
* chocolatey Package Manager
* Firefox
* Windows Terminal
* Sysinternals
* Wireshark
* vim
* posh-git/oh-my-posh
    * Sets default prompt to `star`
    * Sets default font to InconsolataGo