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

$config = "$path\config"
$database = "$path\test"
Write-Host "Create infobase"
New-Item -ItemType Directory -Force -Path "$database" | Out-Null
Start-Process "bin\1cv8t.exe" -ArgumentList "CREATEINFOBASE File=$database" -Wait
Write-Host "Load config..."
Start-Process "bin\1cv8t.exe" -ArgumentList "DESIGNER /F $database /LoadConfigFromFiles $config /UpdateDBCfg"  -Wait
Write-Host "Process autotest..."
Start-Process "bin\1cv8ct.exe" -ArgumentList "ENTERPRISE /F $database" -Wait
Write-Host "Autotest finished"
