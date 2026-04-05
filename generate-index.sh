#!/usr/bin/env bash
set -euo pipefail

PRESENTATIONS_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$PRESENTATIONS_DIR"

TMP_FILE="$(mktemp)"
trap 'rm -f "$TMP_FILE"' EXIT

cat > "$TMP_FILE" <<'EOF'
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>演示文稿 - shinerio</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: #0d1117;
            color: #c9d1d9;
            min-height: 100vh;
            padding: 2rem;
        }
        .container { max-width: 900px; margin: 0 auto; }
        h1 { color: #58a6ff; margin-bottom: 0.5rem; }
        .subtitle { color: #8b949e; margin-bottom: 2rem; }
        .presentation-list { list-style: none; }
        .presentation-item {
            background: #161b22;
            border: 1px solid #30363d;
            border-radius: 10px;
            padding: 1.25rem 1.5rem;
            margin-bottom: 1rem;
            transition: all 0.2s ease;
        }
        .presentation-item:hover {
            border-color: #58a6ff;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(88, 166, 255, 0.12);
        }
        .presentation-link {
            color: #58a6ff;
            text-decoration: none;
            font-size: 1.1rem;
            font-weight: 600;
            display: block;
            margin-bottom: 0.45rem;
        }
        .presentation-link:hover { text-decoration: underline; }
        .presentation-desc { color: #8b949e; font-size: 0.95rem; line-height: 1.55; }
        .presentation-path { color: #6e7681; font-size: 0.8rem; margin-top: 0.4rem; }
        .footer {
            margin-top: 3rem;
            color: #6e7681;
            font-size: 0.85rem;
            text-align: center;
        }
        .footer a { color: #8b949e; text-decoration: none; }
        .footer a:hover { color: #58a6ff; }
    </style>
</head>
<body>
    <div class="container">
        <h1>📊 演示文稿目录</h1>
        <p class="subtitle">shinerio 的在线演示文稿集合</p>
        <ul class="presentation-list">
EOF

find . -maxdepth 1 -type f -name '*.html' ! -name 'index.html' | sort | while read -r file; do
    name="$(basename "$file")"
    slug="${name%.html}"
    title="$(printf '%s' "$slug" | sed 's/[-_]/ /g')"
    cat >> "$TMP_FILE" <<EOF
            <li class="presentation-item">
                <a href="$name" class="presentation-link">$title</a>
                <p class="presentation-desc">演示文稿文件：$name</p>
                <div class="presentation-path">/shinerio-presentation/$name</div>
            </li>
EOF
done

cat >> "$TMP_FILE" <<'EOF'
        </ul>
        <div class="footer">
            <p>GitHub Pages 自动发布 · <a href="https://github.com/shinerio/shinerio-presentation">源码仓库</a></p>
        </div>
    </div>
</body>
</html>
EOF

mv "$TMP_FILE" index.html
echo "index.html 已更新"
