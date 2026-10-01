# Yiming Lu 的博客

基于 **Hugo + PaperMod** 的静态个人博客，推送到 `main` 分支后由 **GitHub Actions** 自动构建并发布到 **GitHub Pages**。

线上地址：<https://YmingLu.github.io/>

---

## 一、目录结构

```
blog/
├─ hugo.toml                    # 全站配置：标题、菜单、PaperMod 参数
├─ content/
│  ├─ posts/                    # ★ 所有文章写在这里
│  │  ├─ hello-world.md
│  │  ├─ what-is-theory-cs.md
│  │  └─ five-mistakes-freshman-year.md
│  ├─ about.md                  # 「关于」页面
│  ├─ archives.md               # 「归档」页面
│  └─ search.md                 # 「搜索」页面
├─ i18n/zh.yaml                 # 中文界面文案（可自行改词）
├─ themes/PaperMod/             # 主题（已直接提交，无需 submodule）
├─ static/                      # 原样拷贝到站点根目录的文件（图片、CNAME 等）
├─ scripts/                     # 本地预览 / 新建文章的小脚本
└─ .github/workflows/hugo.yml   # 自动部署工作流
```

## 二、本地预览

已下载 Hugo 到 `blog/tools/hugo.exe`（若不存在，脚本会自动下载）。

**Windows：**

```powershell
cd blog
.\scripts\serve.ps1          # 打开 http://localhost:1313/
```

**macOS / Linux：**

```bash
cd blog
./scripts/serve.sh
```

只想构建不预览：

```powershell
.\scripts\build.ps1          # 产物在 public/
```

## 三、写一篇新文章

在 `content/posts/` 下新建 `my-post.md`：

```toml
+++
title = "文章标题"
date = 2026-03-10
draft = false
summary = "列表页显示的一句话摘要"
tags = ["算法", "笔记"]
categories = ["CSTheory"]
+++

正文用 Markdown 写。需要公式时直接写 LaTeX：

行内公式 $O(n \log n)$，独立公式：

$$ \mathrm{P} \neq \mathrm{NP} $$
```

也可以让脚本生成骨架：

```powershell
.\scripts\new-post.ps1 "我的新文章"
```

**常用 front matter 开关**

| 字段 | 作用 |
| --- | --- |
| `draft: true` | 草稿，本地 `-D` 可见，线上不发布 |
| `ShowToc: false` | 关闭该文章的目录 |
| `cover.image: "/images/x.jpg"` | 添加封面图（图片放 `static/images/`） |
| `hidemeta: true` | 隐藏日期/作者等信息 |
| `weight` | 归档排序用（一般不用管） |

## 四、发布上线

```bash
cd blog
git add -A
git commit -m "post: 新文章"
git push
```

推送后 GitHub Actions 自动构建发布，约 1 分钟可访问。

## 五、首次部署前必须做的三件事

1. **确认用户名和仓库名**
   `hugo.toml` 里的 `baseURL` 目前是 `https://YmingLu.github.io/`。
   若你的用户名不是 `YmingLu`，把它改成 `https://<你的用户名>.github.io/`。

2. **创建仓库**
   在 GitHub 新建仓库 `YmingLu.github.io`（**必须**是这个名字，才能作为用户主页站点），
   然后：

   ```bash
   git remote add origin https://github.com/YmingLu/YmingLu.github.io.git
   git branch -M main
   git push -u origin main
   ```

3. **打开 Pages 开关**
   仓库 → `Settings` → `Pages` → `Build and deployment` → **Source 选 `GitHub Actions`**。
   （不要选 "Deploy from a branch"。）

> 如果你不想用 `用户名.github.io` 这个名字，也可以建任意仓库名（例如 `blog`），
> 此时站点地址是 `https://YmingLu.github.io/blog/`，并把 `baseURL` 同步改成该地址。

## 六、常见自定义

| 想改什么 | 改哪里 |
| --- | --- |
| 站点标题 / 简介 | `hugo.toml` 的 `title`、`[params] description` |
| 首页那段自我介绍 | `hugo.toml` 的 `[params.homeInfoParams]` |
| 顶部导航菜单 | `hugo.toml` 的 `[[menu.main]]` |
| 头像 / 社交图标 | `[params]` 下加 `[[params.socialIcons]]` |
| 中文界面用词 | `i18n/zh.yaml` |
| 主题本身的样式与模板 | `themes/PaperMod/` |

主题完整参数说明见 [PaperMod 官方文档](https://github.com/adityatelange/hugo-PaperMod/wiki/Variables)。

## 七、接入评论（可选）

PaperMod 支持 giscus / utterances。以 giscus 为例，在 `hugo.toml` 增加：

```toml
[params]
  comments = true

[params.giscus]
  repo = "YmingLu/YmingLu.github.io"
  repoId = "你的 repo id"
  category = "Announcements"
  categoryId = "你的 category id"
  mapping = "pathname"
  lang = "zh-CN"
```

## 八、主题升级

主题文件是直接复制进来的（没用 submodule，部署更省事）。升级方式：

```bash
# 下载新版主题后覆盖
# https://github.com/adityatelange/hugo-PaperMod/releases
```

或改回 submodule 方式：

```bash
git submodule add https://github.com/adityatelange/hugo-PaperMod themes/PaperMod
```

（工作流已经带了 `submodules: recursive`，两种方式都能正常部署。）

---

## License

文章内容：CC BY-NC-SA 4.0 ｜ 站点代码：MIT
