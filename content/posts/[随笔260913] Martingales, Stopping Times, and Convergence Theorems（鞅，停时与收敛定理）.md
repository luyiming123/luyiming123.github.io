---
title: "[随笔260913] Martingales, Stopping Times, and Convergence Theorems（鞅，停时与收敛定理）"
date: 2026-10-02
draft: false
summary: "test"
tags: ["随笔"]["数学"]
categories: ["随笔"]["数学"]
ShowToc: true
---
手伤了，直接用 AI 了。
## 1. 滤子、条件期望与鞅的定义

### 1.1 概率空间与滤子 (Filtered Probability Space)
设 $(\Omega, \mathcal{F}, \mathbb{P})$ 为完备概率空间。
*   **滤子 (Filtration)**：称一族递增的子 $\sigma$-代数流 $\mathbb{F} = \{\mathcal{F}_n\}_{n \in \mathbb{N}_0}$ 为滤子，若其满足：
    $$\mathcal{F}_0 \subseteq \mathcal{F}_1 \subseteq \cdots \subseteq \mathcal{F}_n \subseteq \cdots \subseteq \mathcal{F}$$
    赋予滤子的概率空间记为 $(\Omega, \mathcal{F}, \mathbb{F}, \mathbb{P})$。记 $\mathcal{F}_\infty = \sigma\left(\bigcup_{n=0}^\infty \mathcal{F}_n\right)$。
*   **适应过程 (Adapted Process)**：随机过程 $X = \{X_n\}_{n \in \mathbb{N}_0}$ 称为适应于 $\mathbb{F}$ 的，若对每个 $n \in \mathbb{N}_0$，$X_n$ 均为 $\mathcal{F}_n$-可测随机变量。

### 1.2 鞅的严格定义
设实值随机过程 $X = \{X_n\}_{n \in \mathbb{N}_0}$ 适应于 $\mathbb{F}$，且满足对任意 $n \in \mathbb{N}_0$ 均有 $X_n \in L^1(\mathbb{P})$（即 $\mathbb{E}[|X_n|] < \infty$）。

1.  **鞅 (Martingale)**：若对任意 $n \in \mathbb{N}_0$，
    $$\mathbb{E}[X_{n+1} \mid \mathcal{F}_n] = X_n \quad \text{a.s.}$$
2.  **下鞅 (Submartingale)**：若对任意 $n \in \mathbb{N}_0$，
    $$\mathbb{E}[X_{n+1} \mid \mathcal{F}_n] \ge X_n \quad \text{a.s.}$$
3.  **上鞅 (Supermartingale)**：若对任意 $n \in \mathbb{N}_0$，
    $$\mathbb{E}[X_{n+1} \mid \mathcal{F}_n] \le X_n \quad \text{a.s.}$$

> **性质 1.1 (期望单调性)**：
> * 若 $X$ 为鞅，则对任意 $m \ge n \ge 0$，$\mathbb{E}[X_m \mid \mathcal{F}_n] = X_n$ a.s.，从而 $\mathbb{E}[X_m] = \mathbb{E}[X_n] = \mathbb{E}[X_0]$。
> * 若 $X$ 为下鞅（上鞅），则映射 $n \mapsto \mathbb{E}[X_n]$ 单调递增（单调递减）。

### 1.3 凸变换与下鞅生成
**定理 1.1 (Jensen 条件不等式应用)**
1.  设 $X$ 为鞅，$\phi: \mathbb{R} \to \mathbb{R}$ 为凸函数。若对任意 $n$，$\mathbb{E}[|\phi(X_n)|] < \infty$，则 $\phi(X) = \{\phi(X_n)\}_{n \in \mathbb{N}_0}$ 为**下鞅**。
    *   *特例*：若 $X$ 为鞅，则 $|X|$ 为下鞅；若进一步 $X_n \in L^p(\mathbb{P})$ ($p \ge 1$)，则 $|X|^p$ 为下鞅。
2.  设 $X$ 为下鞅，$\phi: \mathbb{R} \to \mathbb{R}$ 为**非减**凸函数。若 $\mathbb{E}[|\phi(X_n)|] < \infty$，则 $\phi(X)$ 为**下鞅**。

---

## 2. 停时与可选抽样定理 (Optional Stopping Theorem)

### 2.1 停时及其代数结构
*   **定义 (停时)**：映射 $\tau: \Omega \to \mathbb{N}_0 \cup \{\infty\}$ 称为关于 $\mathbb{F}$ 的**停时 (Stopping Time)**，若满足：
    $$\forall n \in \mathbb{N}_0, \quad \{\omega \in \Omega : \tau(\omega) \le n\} \in \mathcal{F}_n$$
    （在离散时间情形下，该条件等价于 $\{\tau = n\} \in \mathcal{F}_n$）。
*   **停时 $\sigma$-代数**：定义 $\mathcal{F}_\tau = \{A \in \mathcal{F} : A \cap \{\tau \le n\} \in \mathcal{F}_n, \; \forall n \in \mathbb{N}_0\}$。它刻画了系统在随机时刻 $\tau$ 之前所积累的历史信息。

### 2.2 停止过程 (Stopped Process)
设 $X$ 为随机过程，$\tau$ 为停时。定义**停止过程** $X^\tau = \{X_n^\tau\}_{n \in \mathbb{N}_0}$ 为：
$$X_n^\tau(\omega) := X_{n \wedge \tau(\omega)}(\omega), \quad \text{其中 } a \wedge b := \min\{a, b\}$$

**定理 2.1 (稳定性定理)**
若 $X$ 是关于 $\mathbb{F}$ 的鞅（相应地下鞅、上鞅），$\tau$ 是 $\mathbb{F}$-停时，则停止过程 $X^\tau$ 亦是关于 $\mathbb{F}$ 的鞅（相应地下鞅、上鞅）。
特别地，对任意有穷常数 $n$：
$$\mathbb{E}[X_{n \wedge \tau}] = \mathbb{E}[X_0]$$

### 2.3 杜布可选抽样定理 (Doob's Optional Stopping Theorem)
一般情况下，$\lim_{n \to \infty} \mathbb{E}[X_{n \wedge \tau}] = \mathbb{E}[X_\tau]$ 不必然成立（极限与期望积分不可随意交换次序）。

**定理 2.2 (可选抽样定理的标准形式)**
设 $X$ 为鞅，$\tau$ 为停时。若满足下列条件之一：
1.  **有界性**：$\tau$ 本质有界，即存在常数 $K < \infty$，使得 $\mathbb{P}(\tau \le K) = 1$。
2.  **过程在停止前一致有界**：$\mathbb{P}(\tau < \infty) = 1$，且存在常数 $M < \infty$，使得对所有 $n \in \mathbb{N}_0$ 均有 $|X_{n \wedge \tau}| \le M$ a.s.。
3.  **期望停时有限且增量有界**：$\mathbb{E}[\tau] < \infty$，且存在常数 $c < \infty$，使得 $\mathbb{E}[|X_{n+1} - X_n| \mid \mathcal{F}_n] \le c$ 对所有 $n < \tau$ 成立。
4.  **一致可积性**：停止过程族 $\{X_{n \wedge \tau}\}_{n \in \mathbb{N}_0}$ 是一致可积的 (Uniformly Integrable)。

则 $X_\tau \in L^1(\mathbb{P})$，且有：
$$\mathbb{E}[X_\tau] = \mathbb{E}[X_0]$$

> **广义形式（两停时比较）**：
> 若 $\sigma \le \tau$ 为两个停时，且上述适当的可积性条件得到满足，则对下鞅有：
> $$X_\sigma \le \mathbb{E}[X_\tau \mid \mathcal{F}_\sigma] \quad \text{a.s.}$$
> 若为鞅，则等式成立。

---

## 3. 杜布极大值不等式与穿越引理

收敛性分析依赖于对样本路径震荡的量化控制。

### 3.1 杜布下鞅极大值不等式 (Doob's Maximal Inequality)
设 $X$ 为非负下鞅。记 $X_n^* = \max_{0 \le k \le n} X_k$。

1.  **弱型不等式 ($L^1$ 极大值不等式)**：
    对任意 $\lambda > 0$ 与 $n \in \mathbb{N}_0$：
    $$\lambda \mathbb{P}\left( X_n^* \ge \lambda \right) \le \mathbb{E}\left[ X_n \mathbf{1}_{\{X_n^* \ge \lambda\}} \right] \le \mathbb{E}[X_n]$$
2.  **强型不等式 (Doob's $L^p$ 不等式)**：
    设 $p > 1$。若 $X_n \in L^p(\mathbb{P})$，则有：
    $$\| X_n^* \|_p \le \frac{p}{p - 1} \| X_n \|_p$$
    即 $\mathbb{E}\left[(X_n^*)^p\right] \le \left(\frac{p}{p-1}\right)^p \mathbb{E}[X_n^p]$。

### 3.2 杜布向上穿越引理 (Doob's Upcrossing Lemma)
设 $X$ 为下鞅，$a < b$ 为实数。定义在时间段 $\{0, 1, \dots, N\}$ 内过程 $X$ 对区间 $[a, b]$ 的**向上穿越次数** $U_N[a, b]$：
*   $S_1 = \inf\{k \ge 0: X_k \le a\}$
*   $T_1 = \inf\{k \ge S_1: X_k \ge b\}$
*   $S_{m+1} = \inf\{k \ge T_m: X_k \le a\}$, $T_{m+1} = \inf\{k \ge S_{m+1}: X_k \ge b\}$
*   $U_N[a, b] = \sup\{m: T_m \le N\}$

**引理 3.1**
$$(b - a) \mathbb{E}[U_N[a, b]] \le \mathbb{E}[(X_N - a)^+] - \mathbb{E}[(X_0 - a)^+]$$
其中 $x^+ = \max\{x, 0\}$。

---

## 4. 鞅收敛定理 (Martingale Convergence Theorems)

### 4.1 几乎必然收敛：杜布前向收敛定理
**定理 4.1 (Doob's Martingale Convergence Theorem)**
设 $X$ 为下鞅。若满足 $L^1$ 有界性条件：
$$\sup_{n \in \mathbb{N}_0} \mathbb{E}[X_n^+] < \infty \quad (\text{对鞅而言，等价于 } \sup_{n \in \mathbb{N}_0} \mathbb{E}[|X_n|] < \infty)$$
则存在可积随机变量 $X_\infty \in L^1(\mathbb{P})$，使得：
$$X_n \xrightarrow{\text{a.s.}} X_\infty \quad (n \to \infty)$$

*证明思路草图*：
令 $U_\infty[a, b] = \lim_{N \to \infty} U_N[a, b]$。由单调收敛定理与向上穿越引理，$\mathbb{E}[U_\infty[a, b]] \le \frac{\sup_n \mathbb{E}[(X_n - a)^+]}{b - a} < \infty$。
这蕴含 $\mathbb{P}(U_\infty[a, b] = \infty) = 0$。
由于事件 $\{\liminf_{n} X_n < a < b < \limsup_{n} X_n\} \subseteq \{U_\infty[a, b] = \infty\}$，取遍所有有理数对 $a < b$，得到：
$$\mathbb{P}\left(\liminf_{n \to \infty} X_n < \limsup_{n \to \infty} X_n\right) = 0$$
故极限 $\lim_{n \to \infty} X_n$ a.s. 存在。由 Fatou 引理可证极限的绝对可积性。

---

### 4.2 均值收敛与一致可积性 ($L^1$ 收敛)
几乎必然收敛一般无法推出 $L^1$ 范数收敛（即 $\mathbb{E}[|X_n - X_\infty|] \to 0$ 不一定成立）。二者的充要衔接条件为一致可积性。

**定义 (一致可积族, UI)**：随机变量族 $\{X_i\}_{i \in I}$ 称为一致可积的，若：
$$\lim_{R \to \infty} \sup_{i \in I} \mathbb{E}\left[|X_i| \mathbf{1}_{\{|X_i| \ge R\}}\right] = 0$$

**定理 4.2 ($L^1$-鞅收敛定理 / 闭鞅判定)**
设 $X$ 为鞅。则以下陈述等价：
1.  $\{X_n\}_{n \in \mathbb{N}_0}$ 在 $(\Omega, \mathcal{F}, \mathbb{P})$ 上一致可积。
2.  存在 $X_\infty \in L^1(\mathbb{P})$，使得 $X_n \xrightarrow{\text{a.s.}} X_\infty$ 且 $X_n \xrightarrow{L^1} X_\infty$。
3.  存在随机变量 $Y \in L^1(\mathbb{P})$，使得对任意 $n \in \mathbb{N}_0$：
    $$X_n = \mathbb{E}[Y \mid \mathcal{F}_n] \quad \text{a.s.}$$
    （若此条件成立，则必有 $X_\infty = \mathbb{E}[Y \mid \mathcal{F}_\infty]$ a.s.，此即**闭鞅 (Closed Martingale)**）。

---

### 4.3 $L^p$ 收敛定理 ($p > 1$)
当 $p > 1$ 时，由杜布 $L^p$ 极大值不等式，对一致可积性的要求可由 $L^p$ 范数有界直接保证。

**定理 4.3 ($L^p$-鞅收敛定理)**
设 $p > 1$，$X$ 为鞅。若：
$$\sup_{n \in \mathbb{N}_0} \mathbb{E}[|X_n|^p] < \infty$$
则：
1.  存在 $X_\infty \in L^p(\mathbb{P})$，使得：
    $$X_n \xrightarrow{\text{a.s.}} X_\infty \quad \text{且} \quad X_n \xrightarrow{L^p} X_\infty \quad (n \to \infty)$$
2.  极大值随机变量 $X^* = \sup_{n \ge 0} |X_n| \in L^p(\mathbb{P})$，且满足：
    $$\| X^* \|_p \le \frac{p}{p - 1} \sup_{n \ge 0} \| X_n \|_p$$
