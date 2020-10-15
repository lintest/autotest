$path = $env:APPVEYOR_BUILD_FOLDER
$url1c = $env:URL_1CV8T
$dist1c = "$path\1cv8t.7z"
if (!(Test-Path $dist1c)) {
  Write-Host "Download 1cv8t.7z ..."
  Invoke-WebRequest -Uri $url1c -OutFile $dist1c
}
Set-Content -Path app_port.txt -Value ([uri] "$env.APPVEYOR_API_URL").Port
