# 新建文章骨架：.\scripts\new-post.ps1 "文章标题" -Tags "算法,笔记"
param(
  [Parameter(Mandatory = $true, Position = 0)]
  [string]$Title,
  [string]$Tags = "",
  [string]$Categories = "CSTheory"
)

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$posts = Join-Path $root 'content\posts'
New-Item -ItemType Directory -Force -Path $posts | Out-Null

# 从标题生成文件名：保留中文，其余转小写并替换空格
$slug = $Title.Trim().ToLower() -replace '\s+', '-'
$slug = $slug -replace '[\\/:*?"<>|]', ''
if ([string]::IsNullOrWhiteSpace($slug)) { $slug = 'post' }
$file = Join-Path $posts "$(Get-Date -Format 'yyyy-MM-dd')-$slug.md"

if (Test-Path $file) { throw "文件已存在：$file" }

$date = Get-Date -Format 'yyyy-MM-dd'
$tagList = if ($Tags) { ($Tags -split ',' | ForEach-Object { '"' + $_.Trim() + '"' }) -join ', ' } else { '""' }

# 单引号 here-string：内容原样写入，不解析 $ 与反引号
$template = @'
---
title: "__TITLE__"
date: __DATE__
draft: true
summary: ""
tags: [__TAGS__]
categories: ["__CATEGORIES__"]
ShowToc: true
---

在这里开始写正文。

行内公式 $O(n \log n)$，独立公式：

$$ \mathrm{P} \subseteq \mathrm{NP} $$
'@

$content = $template.
  Replace('__TITLE__', $Title).
  Replace('__DATE__', $date).
  Replace('__TAGS__', $tagList).
  Replace('__CATEGORIES__', $Categories)

Set-Content -Path $file -Value $content -Encoding UTF8
Write-Host "已创建：$file" -ForegroundColor Green
Write-Host "默认是草稿（draft: true），发布前记得改成 false。" -ForegroundColor Yellow
