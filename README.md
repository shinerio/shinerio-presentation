# Presentations Repository

这个目录用于存放所有演示文稿，push 到 `main` 后由 GitHub Pages 自动发布。

## 在线访问

- 目录页：http://shinerio.site/shinerio-presentation/
- 单个演示文稿：http://shinerio.site/shinerio-presentation/<文件名>.html

## 工作流

1. 把新的 HTML 放进这个目录
2. 运行 `deploy.sh`
3. 脚本会自动：
   - 复制/覆盖 HTML 文件
   - 扫描全部演示文稿并重建 `index.html`
   - 提交并 push 到 `main`
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
- 后续我只需要返回最终链接给你

## 目录结构

```bash
~/.openclaw/shared-space/presentations/
├── claude-code-java-lsp.html
├── deploy.sh
├── generate-index.sh
├── index.html
└── README.md
```
