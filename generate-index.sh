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

        :root {
            --bg: #050505;
            --bg-soft: #0f0f0f;
            --text: #f5f5f5;
            --muted: rgba(255,255,255,0.62);
            --line: rgba(255,255,255,0.12);
            --glass: rgba(255,255,255,0.08);
            --glass-strong: rgba(255,255,255,0.12);
            --shadow: 0 20px 60px rgba(0,0,0,0.32);
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', sans-serif;
            min-height: 100vh;
            color: var(--text);
            background:
                radial-gradient(circle at top left, rgba(255,255,255,0.08), transparent 28%),
                radial-gradient(circle at bottom right, rgba(255,255,255,0.05), transparent 32%),
                linear-gradient(180deg, #0a0a0a 0%, #050505 100%);
            padding: clamp(20px, 4vw, 48px);
        }

        .container {
            max-width: 980px;
            margin: 0 auto;
        }

        .hero {
            margin-bottom: clamp(28px, 4vw, 48px);
        }

        h1 {
            font-size: clamp(2rem, 6vw, 4.2rem);
            line-height: 0.96;
            letter-spacing: -0.05em;
            margin-bottom: 0.8rem;
            font-weight: 800;
        }

        .subtitle {
            max-width: 44rem;
            color: var(--muted);
            font-size: clamp(0.95rem, 1.8vw, 1.15rem);
            line-height: 1.7;
        }

        .presentation-list {
            list-style: none;
            display: grid;
            gap: 16px;
        }

        .presentation-item {
            list-style: none;
        }

        .presentation-card {
            display: block;
            width: 100%;
            text-decoration: none;
            color: inherit;
            border: 1px solid var(--line);
            border-radius: 24px;
            background: linear-gradient(180deg, var(--glass-strong), var(--glass));
            backdrop-filter: blur(18px);
            -webkit-backdrop-filter: blur(18px);
            box-shadow: var(--shadow);
            padding: clamp(18px, 2.4vw, 28px);
            transition: transform 0.22s ease, border-color 0.22s ease, background 0.22s ease;
            position: relative;
            overflow: hidden;
        }

        .presentation-card::before {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(135deg, rgba(255,255,255,0.08), transparent 42%);
            pointer-events: none;
        }

        .presentation-card:hover {
            transform: translateY(-4px);
            border-color: rgba(255,255,255,0.24);
            background: linear-gradient(180deg, rgba(255,255,255,0.14), rgba(255,255,255,0.09));
        }

        .presentation-title {
            font-size: clamp(1.08rem, 2vw, 1.35rem);
            font-weight: 700;
            line-height: 1.3;
            letter-spacing: -0.02em;
            margin-bottom: 0.55rem;
        }

        .presentation-desc {
            color: var(--muted);
            font-size: 0.95rem;
            line-height: 1.65;
            margin-bottom: 0.85rem;
        }

        .presentation-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 16px;
            flex-wrap: wrap;
        }

        .presentation-path {
            color: rgba(255,255,255,0.4);
            font-size: 0.82rem;
            word-break: break-all;
        }

        .presentation-arrow {
            font-size: 0.9rem;
            color: rgba(255,255,255,0.8);
            white-space: nowrap;
        }

        .footer {
            margin-top: 40px;
            color: rgba(255,255,255,0.4);
            font-size: 0.9rem;
            text-align: center;
        }

        .footer a {
            color: rgba(255,255,255,0.76);
            text-decoration: none;
        }

        .footer a:hover { text-decoration: underline; }

        @media (max-width: 640px) {
            body { padding: 18px; }
            .presentation-meta { align-items: flex-start; }
        }
    </style>
</head>
<body>
    <div class="container">
        <section class="hero">
            <h1>Presentation<br>Index</h1>
            <p class="subtitle">shinerio 的演示文稿目录。每一张卡片都可直接点击跳转到对应演示页面。</p>
        </section>
        <ul class="presentation-list">
EOF

find . -maxdepth 1 -type f -name '*.html' ! -name 'index.html' | sort | while read -r file; do
    name="$(basename "$file")"
    slug="${name%.html}"
    title="$(printf '%s' "$slug" | sed 's/[-_]/ /g')"
    cat >> "$TMP_FILE" <<EOF
            <li class="presentation-item">
                <a href="$name" class="presentation-card">
                    <div class="presentation-title">$title</div>
                    <p class="presentation-desc">演示文稿文件：$name</p>
                    <div class="presentation-meta">
                        <div class="presentation-path">/shinerio-presentation/$name</div>
                        <div class="presentation-arrow">打开演示 ↗</div>
                    </div>
                </a>
            </li>
EOF
done

cat >> "$TMP_FILE" <<'EOF'
        </ul>
        <div class="footer">
            GitHub Pages 自动发布 · <a href="https://github.com/shinerio/shinerio-presentation">查看源码仓库</a>
        </div>
    </div>
</body>
</html>
EOF

mv "$TMP_FILE" index.html
echo "index.html 已更新"
