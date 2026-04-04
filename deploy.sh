#!/usr/bin/env bash
set -euo pipefail

PRESENTATIONS_DIR="$HOME/.openclaw/shared-space/presentations"

if [ $# -lt 1 ]; then
    echo "用法: $0 <html文件> [提交说明]"
    echo "示例: $0 /path/to/presentation.html 'Add presentation: xxx'"
    exit 1
fi

HTML_FILE="$1"
COMMIT_MSG="${2:-Add presentation}"

if [ ! -f "$HTML_FILE" ]; then
    echo "错误: 文件不存在: $HTML_FILE"
    exit 1
fi

FILENAME="$(basename "$HTML_FILE")"
TARGET="$PRESENTATIONS_DIR/$FILENAME"

cp "$HTML_FILE" "$TARGET"

cd "$PRESENTATIONS_DIR"
./generate-index.sh

git add "$FILENAME" index.html generate-index.sh deploy.sh README.md
if git diff --cached --quiet; then
    echo "没有变化，无需部署"
    echo "链接: http://shinerio.site/shinerio-presentation/$FILENAME"
    exit 0
fi

git commit -m "$COMMIT_MSG"
git push origin main

echo "部署已提交"
echo "目录页: http://shinerio.site/shinerio-presentation/"
echo "演示链接: http://shinerio.site/shinerio-presentation/$FILENAME"
echo "通常 1-2 分钟内生效"
