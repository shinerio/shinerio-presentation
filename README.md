# Presentations Repository

这个目录用于存放所有演示文稿，统一发布到仓库 `shinerio/shinerio-presentation`。

## 当前稳定发布方案

- **GitHub Pages source**：`gh-pages` 分支
- **本地工作目录**：`~/.openclaw/shared-space/presentations/`
- **总目录页**：`http://shinerio.site/shinerio-presentation/`
- **单个演示文稿**：`http://shinerio.site/shinerio-presentation/<文件名>.html`

这样做的原因很简单：
`gh-pages` 这条链路已经验证过能稳定发布，避免 main / workflow / Pages source 混用导致“push 成功但线上 404”。

## 工作流

1. 生成新的 HTML 文件
2. 运行 `deploy.sh`
3. 脚本会自动：
   - 切换到 `gh-pages`
   - 拉取最新内容
   - 复制/覆盖 HTML 文件
   - 自动重建 `index.html`
   - commit + push 到 `gh-pages`
4. GitHub Pages 自动上线

## 推荐用法

```bash
~/.openclaw/shared-space/presentations/deploy.sh /path/to/your-presentation.html "Add presentation: your-presentation"
```

## 自动目录页

`generate-index.sh` 会扫描当前目录下所有 `.html` 文件（排除 `index.html`），并自动重建总目录首页。

这意味着：
- 新增演示文稿时，首页会自动出现入口
- 每个文稿 URL 都由文件名决定
- 后续只需要返回最终链接给用户

## 目录结构

```bash
~/.openclaw/shared-space/presentations/
├── claude-code-java-lsp.html
├── deploy.sh
├── generate-index.sh
├── index.html
└── README.md
```
