# 本地构建（不启动服务器）
# 若 blog\tools\hugo.exe 不存在会自动下载
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$hugo = Join-Path $root 'tools\hugo.exe'
$version = '0.167.0'

if (-not (Test-Path $hugo)) {
  Write-Host "未找到 Hugo，正在下载 v$version ..." -ForegroundColor Yellow
  $dir = Join-Path $root 'tools'
  New-Item -ItemType Directory -Force -Path $dir | Out-Null
  $zip = Join-Path $dir 'hugo.zip'
  $url = "https://github.com/gohugoio/hugo/releases/download/v$version/hugo_extended_${version}_windows-amd64.zip"
  Invoke-WebRequest -Uri $url -OutFile $zip -UseBasicParsing
  Expand-Archive -Path $zip -DestinationPath $dir -Force
  Remove-Item $zip -Force
}

Push-Location $root
try {
  & $hugo build --gc --minify
  Write-Host "构建完成，产物在 blog\public\" -ForegroundColor Green
} finally {
  Pop-Location
}
