#!/usr/bin/env bash
# 构建站点：./scripts/build.sh
set -euo pipefail
cd "$(dirname "$0")/.."

if command -v hugo >/dev/null 2>&1; then
  HUGO=hugo
elif [ -x ./tools/hugo ]; then
  HUGO=./tools/hugo
else
  echo "未找到 Hugo，请先安装：https://gohugo.io/installation/" >&2
  exit 1
fi

"$HUGO" build --gc --minify
echo "构建完成，产物在 public/"
