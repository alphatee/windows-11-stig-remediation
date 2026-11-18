<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows System event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Daniel Herrera
    LinkedIn        : linkedin.com/in/daniel-alexander-herrera-307aa4bb/
    GitHub          : github.com/alphatee
    Date Created    : 2026-11-18
    Last Modified   : 2026-11-18
    Version         : 1.0
    STIG-ID         : WN11-AU-000510
    Documentation   : https://stigaview.com/products/win11/v2r11/WN11-AU-000510/

.TESTED ON
    Date(s) Tested  : 2026-11-18
    Tested By       : Daniel Herrera
    Systems Tested  : Windows 11 (Azure VM)
    PowerShell Ver. : 5.1

.USAGE
    Run in PowerShell ISE as Administrator.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-AU-000510.ps1
#>

# Define the registry path and value
$RegPath   = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\System"
$ValueName = "MaxSize"
$ValueData = 0x00008000   # 32768 KB

# Create the registry key if it doesn't exist
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Set the MaxSize DWORD value
New-ItemProperty -Path $RegPath -Name $ValueName -Value $ValueData -PropertyType DWord -Force | Out-Null

# Confirm the change
Get-ItemProperty -Path $RegPath -Name $ValueName
