$url1c = $env:URL_1CV8T
$path = $env:APPVEYOR_BUILD_FOLDER

$dist1c = "$path\1cv8.zip"
if (!(Test-Path $dist1c)) {
  Write-Host "Download 1cv8.zip ..."
  Invoke-WebRequest -Uri $url1c -OutFile $dist1c
}

Write-Host "Expand archive 1cv8.zip ..."
Expand-Archive -Force -Path $dist1c -DestinationPath $path
Set-Content "$path\bin\conf\conf.cfg" "DisableUnsafeActionProtection=.*;"

Write-Host "Process autotest..."
Start-Process "bin\1cv8ct.exe" -ArgumentList "ENTERPRISE /F $path\Test" -Wait

Write-Host "Autotest finished"
