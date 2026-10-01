# 本地构建（不启动服务器）：.\scripts\build.ps1
# 优先使用系统安装的 hugo；找不到时回退到 blog\tools\hugo.exe（不存在则自动下载）
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$version = '0.167.0'

function Resolve-Hugo {
  $cmd = Get-Command hugo -ErrorAction SilentlyContinue
  if ($cmd) { return $cmd.Source }

  $local = Join-Path $root 'tools\hugo.exe'
  if (Test-Path $local) { return $local }

  Write-Host "未找到 Hugo，正在下载 v$version ..." -ForegroundColor Yellow
  $dir = Join-Path $root 'tools'
  New-Item -ItemType Directory -Force -Path $dir | Out-Null
  $zip = Join-Path $dir 'hugo.zip'
  $url = "https://github.com/gohugoio/hugo/releases/download/v$version/hugo_extended_${version}_windows-amd64.zip"
  Invoke-WebRequest -Uri $url -OutFile $zip -UseBasicParsing
  Expand-Archive -Path $zip -DestinationPath $dir -Force
  Remove-Item $zip -Force
  return $local
}

$hugo = Resolve-Hugo

Push-Location $root
try {
  & $hugo build --gc --minify
  Write-Host "构建完成，产物在 blog\public\" -ForegroundColor Green
} finally {
  Pop-Location
}
