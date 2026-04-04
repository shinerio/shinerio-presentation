#!/bin/bash

# 演示文稿部署脚本
# 用法: ./deploy.sh <html-file文件> <描述>

set -e

PRESENTATIONS_DIR="$HOME/.openclaw/shared-space/presentations"

if [ $# -lt 1 ]; then
    echo "用法: $0 <html文件> [描述]"
    echo "示例: $0 /path/to/presentation.html \"我的新演示文稿\""
    exit 1
fi

HTML_FILE="$1"
DESCRIPTION="${2:-添加演示文稿}"

if [ ! -f "$HTML_FILE" ]; then
    echo "错误: 文件不存在: $HTML_FILE"
    exit 1
fi

# 生成文件名（使用文件名的 basename）
FILENAME=$(basename "$HTML_FILE")

# 复制到演示文稿目录
echo "📁 复制 $FILENAME 到演示文稿目录..."
cp "$HTML_FILE" "$PRESENTATIONS_DIR/$FILENAME"

# 提交并推送
cd "$PRESENTATIONS_DIR"
git add "$FILENAME"
git commit -m "$DESCRIPTION"
git push origin main

# 获取在线链接
echo "✅ 部署完成!"
echo "🌐 在线地址: http://shinerio.site/shinerio-presentation/$FILENAME"
echo "⏳ 等待 1-2 分钟后访问"
