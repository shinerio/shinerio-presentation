# Presentations Repository

这个目录用于存放所有演示文稿，自动部署到 GitHub Pages。

## 在线访问

- **主库地址：** http://shinerio.site/shinerio-presentation/
- **单个演示文稿：** http://shinerio.site/shinerio-presentation/<文件名>.html

例如：
- `claude-code-java-lsp.html` → http://shinerio.site/shinerio-presentation/claude-code-java-lsp.html

## 如何添加新演示文稿

1. **将 HTML 文件复制到这个目录**
   ```bash
   cp /path/to/new-presentation.html ~/.openclaw/shared-space/presentations/your-presentation.html
   ```

2. **提交并推送**
   ```bash
   cd ~/.openclaw/shared-space/presentations
   git add your-presentation.html
   git commit -m "Add your presentation"
   git push origin gh-pages
   ```

3. **等待 1-2分钟，访问在线地址**
   http://shinerio.site/shinerio-presentation/your-presentation.html

## 命名建议

- 使用有意义的文件名，如：
  - `claude-code-java-lsp.html`
  - `python-async-guide.html`
  - `architecture-overview.html`
- 避免使用中文文件名（URL 编码问题）
- 使用小写字母和连字符

## 目录结构

```
~/.openclaw/shared-space/presentations/
├── .git/                    # Git 仓库（gh-pages 分支）
├── README.md                 # 本说明文件
├── claude-code-java-lsp.html # 示例演示文稿
└── your-presentation.html     # 你的演示文稿
```

## 常用命令

```bash
# 查看当前状态
cd ~/.openclaw/shared-space/presentations
git status

# 查看所有演示文稿
ls *.html

# 更新某个演示文稿
cp new-file.html existing-file.html
git add existing-file.html
git commit -m "Update existing presentation"
git push origin gh-pages

# 删除某个演示文稿
rm unwanted.html
git add unwanted.html
git commit -m "Remove unwanted presentation"
git push origin gh-pages
```

## 技术细节

- **Git 仓库：** https://github.com/shinerio/shinerio-presentation
- **部署分支：** gh-pages
- **自动部署：** 推送到 gh-pages 分支后自动触发 GitHub Pages 构建
- **构建时间：** 通常 1-2 分钟
