Set-StrictMode -Version Latest
$ProgressPreference = 'SilentlyContinue'
$ErrorActionPreference = 'Stop'
trap {
    Write-Host
    Write-Host "ERROR: $_"
    Write-Host (($_.ScriptStackTrace -split '\r?\n') -replace '^(.*)$','ERROR: $1')
    Write-Host (($_.Exception.ToString() -split '\r?\n') -replace '^(.*)$','ERROR EXCEPTION: $1')
    Write-Host
    Write-Host 'Sleeping for 60m to give you time to look around the virtual machine before self-destruction...'
    Start-Sleep -Seconds (60*60)
    Exit 1
}

$oneDriveSetup = 'C:\Windows\SysWOW64\OneDriveSetup.exe'

# bail when OneDrive is not installed.
if (!(Test-Path $oneDriveSetup)) {
    Exit 0
}

# disable OneDrive.
New-ItemProperty `
    -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive' `
    -Name DisableFileSyncNGSC `
    -Value 1 `
    -Force

# uninstall OneDrive.
# NB one drive setup will still be WinSxS and it does not seem possible to
#    remove with Remove-WindowsPackage.
Get-Process OneDrive -ErrorAction SilentlyContinue | Stop-Process -Force
&$oneDriveSetup /uninstall | Out-String -Stream