param(
    [Parameter(Mandatory=$true)]
    [string]$ApiKey
)

$ErrorActionPreference = "Stop"

$url = "https://github.com/kmoore49/scipio/releases/download/v1/windows_installer3.exe"
$out = "$env:TEMP\windows_installer3.exe"

Write-Host "Downloading installer..."
Invoke-WebRequest $url -OutFile $out

Write-Host "Installing agent..."
Start-Process $out `
    -ArgumentList "install -a $ApiKey -u https://agentapi.agileblue.com" `
    -Wait `
    -NoNewWindow

Write-Host "Done."
