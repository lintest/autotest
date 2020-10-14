$url1c = $env:URL_1CV8T
$path = $env:APPVEYOR_BUILD_FOLDER

$dist1c = "$path\1cv8t.7z"
if (!(Test-Path $dist1c)) {
  Write-Host "Download 1cv8t.7z ..."
  Invoke-WebRequest -Uri $url1c -OutFile $dist1c
}
Write-Host "Expand archive 1cv8t.7z ..."