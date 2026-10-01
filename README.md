# Yiming Lu 的博客

基于 **Hugo + PaperMod** 的静态个人博客，推送到 `main` 分支后由 **GitHub Actions** 自动构建并发布到 **GitHub Pages**。

线上地址：<https://luyiming123.github.io/>

---

## 一、目录结构

```
blog/
├─ hugo.toml                    # 全站配置：标题、菜单、PaperMod 参数
├─ content/
│  ├─ posts/                    # ★ 所有文章写在这里
│  │  ├─ _index.md              # 「文章」栏目页（勿删，删了 /posts/ 会 404）
│  │  └─ math-test.md           # 公式示例（draft: true，不发布）
│  ├─ about.md                  # 「关于」页面
│  ├─ archives.md               # 「归档」页面
│  └─ search.md                 # 「搜索」页面
├─ i18n/                        # （已移除自定义文案，中文界面用主题内置翻译）
├─ layouts/
│  ├─ _markup/render-passthrough.html   # 数学公式渲染钩子（KaTeX）
│  ├─ partials/extend_head.html         # 含公式的页面才加载 KaTeX 样式
│  └─ partials/toc.html                 # 覆盖主题目录模板，使标题里的公式在目录中正常显示
├─ assets/css/extended/toc-math.css     # 目录里公式的样式（隐藏 MathML 副本）
├─ themes/PaperMod/             # 主题（已直接提交，无需 submodule）
├─ static/                      # 原样拷贝到站点根目录的文件
│  ├─ katex/                    # 公式样式与字体（自托管，不依赖境外 CDN）
│  └─ favicon*                  # 站点图标
├─ scripts/                     # 本地预览 / 新建文章的小脚本
└─ .github/workflows/hugo.yml   # 自动部署工作流
```

## 二、本地预览

本机已用 winget 装好 Hugo extended 0.167（若换机器，重装命令：`winget install Hugo.Hugo.Extended`）。

**Windows（推荐，最简单）：**

在资源管理器里进入 `blog\scripts\`，**双击 `serve.cmd`**；或在命令行执行：

```powershell
cd blog
.\scripts\serve.cmd          # 打开 http://localhost:1313/
```

`.cmd` 直接调用 `hugo.exe`，**不受 PowerShell 执行策略限制**，也不需要任何配置。

只想构建不预览，双击 `scripts\build.cmd`（产物在 `public\`）。

<details>
<summary>也可以直接用 PowerShell 脚本（需要先放行执行策略）</summary>

这台机器的执行策略是 `Restricted`，且系统层面会拦截未签名脚本，因此 `.ps1` 需要用 Bypass 方式运行：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\serve.ps1
powershell -ExecutionPolicy Bypass -File .\scripts\build.ps1
powershell -ExecutionPolicy Bypass -File .\scripts\new-post.ps1 "文章标题"
```

换一台普通 Windows 机器的话，一次性放行即可直接运行：
`Set-ExecutionPolicy -Scope CurrentUser RemoteSigned`

</details>

脚本会优先用系统里的 `hugo`（winget 装在 `%LOCALAPPDATA%\Microsoft\WinGet\Links`），
找不到就回退到 `blog\tools\hugo.exe`。预览已带 `--buildDrafts`，草稿也能看到。

**macOS / Linux：**

```bash
cd blog
./scripts/serve.sh
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

## 三·五、数学公式（LaTeX / KaTeX）

已配好，**构建时渲染**（Hugo 内置 KaTeX 引擎），页面不需要加载任何 JS。

| 写法 | 效果 |
| --- | --- |
| `$O(n \log n)$` | 行内公式 $O(n \log n)$ |
| `\(a^2 + b^2\)` | 行内公式（等价写法） |
| `$$ ... $$` | 独立成行、居中的公式 |
| `\[ ... \]` | 独立公式（等价写法） |

多行对齐、矩阵、求和、概率等复杂写法都支持：

```latex
$$
\begin{aligned}
T(n) &= 2T(n/2) + O(n) \\
     &= O(n \log n)
\end{aligned}
$$

$$ A = \begin{pmatrix} a & b \\ c & d \end{pmatrix}, \qquad
   \Pr[X \ge t] \le \exp\left(-\frac{2t^2}{n}\right) $$
```

**三个注意点**

1. **美元符号要转义**：正文里写钱数用 `\$100`，否则 `$100 和 $200` 之间会被当成公式。
2. **公式写错会让构建失败**：GitHub Actions 会变红叉，日志里给出具体位置（好处是不会把错公式发出去）。
3. **样式按需加载**：只有含公式的页面才引入 `static/katex/`（约 1 MB），其他页面零开销。

想要预览效果，`content/posts/math-test.md` 是一篇公式示例（`draft: true`，不发布）。

**标题里也能写公式**（例如 `### 4.3 $L^p$ 收敛定理`），目录会一并渲染。
主题原版会把目录里的公式拆散，因此本站覆盖了 `layouts/partials/toc.html`：
它保留标题的渲染结果，公式隐藏的 MathML 副本由 `assets/css/extended/toc-math.css` 隐藏。
换主题版本时记得对比主题的 `_partials/toc.html`，差异只有两行（已加注释标注）。

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
   `hugo.toml` 里的 `baseURL` 是 `https://luyiming123.github.io/`。
   若换了 GitHub 账号，改成 `https://<你的用户名>.github.io/`。

2. **创建仓库**
   在 GitHub 新建仓库 `luyiming123.github.io`（**必须**是这个名字，才能作为用户主页站点），
   然后：

   ```bash
   git remote add origin git@github.com:luyiming123/luyiming123.github.io.git
   git branch -M main
   git push -u origin main
   ```

3. **打开 Pages 开关**
   仓库 → `Settings` → `Pages` → `Build and deployment` → **Source 选 `GitHub Actions`**。
   （不要选 "Deploy from a branch"。）

> 如果你不想用 `用户名.github.io` 这个名字，也可以建任意仓库名（例如 `blog`），
> 此时站点地址是 `https://luyiming123.github.io/blog/`，并把 `baseURL` 同步改成该地址。

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
  repo = "luyiming123/luyiming123.github.io"
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
