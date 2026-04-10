param(
    [Parameter(Mandatory=$true)]
    [string]$ApiKey
)

$ErrorActionPreference = "Stop"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$url = "https://github.com/kmoore49/scipio/releases/download/v1/windows_installer3.exe"
$out = Join-Path $env:TEMP "windows_installer3.exe"

try {
    Write-Host "Downloading installer..."
    Invoke-WebRequest $url -OutFile $out -UseBasicParsing

    if (!(Test-Path $out)) {
        throw "Installer failed to download."
    }

    Write-Host "Running installer..."
    $process = Start-Process $out `
        -ArgumentList "install -a $ApiKey -u https://agentapi.agileblue.com" `
        -Wait -PassThru -NoNewWindow

    if ($process.ExitCode -ne 0) {
        throw "Installer exited with code $($process.ExitCode)"
    }

    Write-Host "Install completed successfully." -ForegroundColor Green
}
catch {
    Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
