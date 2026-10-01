# 本地预览：.\scripts\serve.ps1
# 若 blog\tools\hugo.exe 不存在会自动下载（Windows extended 版）
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
  Write-Host "Hugo 已就绪：$hugo" -ForegroundColor Green
}

Push-Location $root
try {
  & $hugo server --buildDrafts --buildFuture --disableFastRender --navigateToChanged
} finally {
  Pop-Location
}
