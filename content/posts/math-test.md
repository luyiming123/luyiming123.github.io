---
title: "数学公式渲染测试"
date: 2026-10-01
draft: true
summary: "草稿：用来验证 $...$ 与 $$...$$ 公式是否正常渲染。正文写好后把 draft 改成 false 即可发布。"
tags: ["测试"]
categories: ["CSTheory"]
ShowToc: true
---

> 这是一篇 **草稿**（`draft: true`），只在本地 `hugo server -D` 时可见，不会发布到线上。
> 换掉标题、写自己的内容，把 `draft` 改成 `false` 就是一篇正式文章。

## 行内公式

时间复杂度可以写成 $O(n \log n)$，也可以用另一种写法 \(O(n^2)\)，两种都能渲染。

判别式 $\Delta = b^2 - 4ac$ 决定了二次方程根的个数。

## 独立公式

$$
\mathrm{P} \subseteq \mathrm{NP} \subseteq \mathrm{PSPACE} \subseteq \mathrm{EXP}
$$

带对齐的多行公式：

$$
\begin{aligned}
T(n) &= 2T(n/2) + O(n) \\
     &= O(n \log n)
\end{aligned}
$$

求和与极限：

$$
\sum_{i=1}^{n} i = \frac{n(n+1)}{2}, \qquad
\lim_{n \to \infty} \left(1 + \frac{1}{n}\right)^n = e
$$

## 矩阵与概率

$$
A = \begin{pmatrix} a & b \\ c & d \end{pmatrix}, \qquad
\Pr[X \ge t] \le \exp\left(-\frac{2t^2}{n}\right)
$$

## 代码里不受影响

```python
def fib(n):
    # 这里的 $ 符号不会触发公式渲染
    return n if n < 2 else fib(n - 1) + fib(n - 2)
```

## 注意：钱数要转义

正文里如果真的要写美元符号，用反斜杠转义：`\$100`，渲染结果是 \$100。
不转义的话（比如写 `$100 和 $200`）两个 `$` 之间的内容会被当成公式。

## 写错了会怎样

公式语法有误会**直接让构建失败**（GitHub Actions 变红叉），日志里会给出具体位置。
好处是：不会把写错的公式悄悄发布出去。
