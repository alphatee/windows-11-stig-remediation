<#
.SYNOPSIS
    This PowerShell script ensures that PowerShell script block logging is enabled on Windows 11.

.NOTES
    Author          : Daniel Herrera
    LinkedIn        : linkedin.com/in/daniel-alexander-herrera-307aa4bb/
    GitHub          : github.com/alphatee
    Date Created    : 2026-11-18
    Last Modified   : 2026-11-18
    Version         : 1.0
    STIG-ID         : WN11-CC-000326
    Documentation   : https://stigaview.com/products/win11/v2r11/WN11-CC-000326/

.TESTED ON
    Date(s) Tested  : 2026-11-18
    Tested By       : Daniel Herrera
    Systems Tested  : Windows 11 (Azure VM)
    PowerShell Ver. : 5.1

.USAGE
    Run in PowerShell ISE as Administrator.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000326.ps1
#>

# Define the registry path and value
$RegPath   = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging"
$ValueName = "EnableScriptBlockLogging"
$ValueData = 1   # 1 = script block logging enabled

# Create the registry key (and any missing parent keys) if it doesn't exist
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Set the EnableScriptBlockLogging DWORD value
New-ItemProperty -Path $RegPath -Name $ValueName -Value $ValueData -PropertyType DWord -Force | Out-Null

# Confirm the change
Get-ItemProperty -Path $RegPath -Name $ValueName
