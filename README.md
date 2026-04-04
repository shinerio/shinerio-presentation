# Presentations Repository

这个目录用于存放所有演示文稿，通过 GitHub Actions 自动部署到 GitHub Pages。

## 在线访问

- **主库地址：** http://shinerio.site/shinerio-presentation/
- **单个演示文稿：** http://shinerio.site/shinerio-presentation/<文件名>.html

例如：
- `claude-code-java-lsp.html` → http://shinerio.site/shinerio-presentation/claude-code-java-lsp.html

## 如何添加新演示文稿

**方法 1：使用部署脚本（推荐）**
```bash
~/.openclaw/shared-space/presentations/deploy.sh /path/to/presentation.html "演示文稿描述"
```

**方法 2：手动操作**
```bash
# 1. 复制 HTML 文件
cp /path/to/presentation.html ~/.openclaw/shared-space/presentations/your-presentation.html

# 2. 提交并（推送到 main 分支）
cd ~/.openclaw/shared-space/presentations
git add your-presentation.html
git commit -m "Add your presentation"
git push origin main
```

3. **等待 1-2分钟，访问在线地址**
   http://shinerio.site/shinerio-presentation/your-presentation.html

## 自动部署机制

- **Git 仓库：** https://github.com/shinerio/shinerio-presentation
- **主分支：** `main` （存放所有 HTML 文件 + deploy.yml）
- **GitHub Actions：** 推送到 `main` 分支后自动触发部署
- **部署目标：** GitHub Pages
- **构建时间：** 通常 1-2 分钟

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
├
── .github/
│   └── workflows/
│       └── deploy.yml           # GitHub Actions 配置
├── .git/
├── README.md                   # 本说明文件
├── deploy.sh                   # 部署脚本
├── index.html                  # 演示文稿列表页
└── claude-code-java-lsp.html    # 示例演示文稿
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
git push origin main

# 删除某个演示文稿
rm unwanted.html
git add unwanted.html
git commit -m "Remove unwanted presentation"
git push origin main
```

## 技术细节

- **工作流：** `.github/workflows/deploy.yml`
- **触发条件：** 推送到 `main` 分支
- **部署方式：** 使用 `actions/upload-pages-artifact` + `actions/deploy-pages`
- **权限要求：** `pages: write`, `contents: read`
