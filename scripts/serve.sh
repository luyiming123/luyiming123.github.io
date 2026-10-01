#!/usr/bin/env bash
# 本地预览：./scripts/serve.sh
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

"$HUGO" server --buildDrafts --buildFuture --disableFastRender --navigateToChanged
