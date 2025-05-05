---
layout: default
title: "LLLtoDiophantine"
date: 2025-05-05 00:12:31
# use_mathjax: true
# categories:
---

# LLLアルゴリズムとDiophantine近似

このノートでは以下の定理を示すことが目標である.

> 定理
> 
> $a_1, \dots, a_n\in\mathbb{Q}$ と 実数 $0<\varepsilon<1$ が与えられたとき,
> 
> $$
> \begin{aligned}
>   \begin{cases}
>     &1 \leq q \leq 2^{n(n+1)/4}\varepsilon^{-n},\\
>     &\lvert qa_i - p_i \rvert \varepsilon\quad\text{for all $i\in \{1,\dots, n\}$}
>   \end{cases}
> \end{aligned}
> $$
> 
> を満たす整数 $p_i$ 及び $q$ が存在する. また, これらの整数は, 多項式時間で計算可能である.

以下では

1. 定理の背景（Diophantine近似）
2. 記号等の準備
3. 定理の証明

の流れで述べる.

## 1. 定理の背景（Diophantine近似）

まず, 1変数の場合の Dirichlet の定理から復習する.

> 定理
> 
> $a\in\mathbb{Q}$ と 実数 $0 < \varepsilon < 1$ に対して, $1\leq q \leq \varepsilon^{-1}$ かつ $\lvert qa - p \rvert\leq\varepsilon$ を満たす整数 $p, q$ が存在する.

定理において, 整数 $p, q$ を特定するアルゴリズムは有理数 $a$ の連分数展開を考えることで与えられる. このアルゴリズムは多項式時間で計算可能なものになっている.
多変数の場合にも同様に Dirichlet の定理が存在する.[^1]

> 定理
> 
> $a_1, \dots, a_n\in\mathbb{Q}$ と 実数 $0<\varepsilon<1$ が与えられたとき,
> 
> $$
> \begin{aligned}
>   \begin{cases}
>     &1 \leq q \leq \varepsilon^{-n},\\
>     &\lvert qa_i - p_i \rvert \varepsilon\quad\text{for all $i\in \{1,\dots, n\}$}
>   \end{cases}
> \end{aligned}
> $$
> 
> を満たす整数 $p_i$ 及び $q$ が存在する.

多変数の場合は1変数の場合と異なり, 多項式時間で整数 $p_i$ 及び $q$ を特定するアルゴリズムは知られていない.[^2] しかし, 冒頭で紹介した定理では, 近似の精度を弱めると多項式時間で探索できるアルゴリズムが存在する. 冒頭の定理は非構成的に示されていた Dirichlet の定理を構成的な立場からみたものであるといえる. 

## 2. 記号の準備

証明に登場する用語や記号について述べる. 

- 行列 $A \in M_{n}(\mathbb{R})$ から生成される格子 $L(A)$ を

$$
    L = \left\{A\boldsymbol{x} \mathrel{}\middle|\mathrel{} \boldsymbol{x}\in \mathbb{Z}^{n}\right\}
$$

で定める. 格子を生成している行列 $A$ を省略して $L$ と書くこともある.
- $A$ がフルランクの場合, 格子 $L(A)$ は全次元であるという. 
- 全次元格子 $L(A)$ に対して, $\det L = \lvert \det A \rvert$ と定める. $\det L$ は格子の基底の取り方に依らない.
- $\mathbb{R}^n$ 上の順序付き基底 $B = [\boldsymbol{b}_1 \ \boldsymbol{b}_2 \ \dots \ \boldsymbol{b}_n]$ に対して, その直交化基底を $B = [\boldsymbol{b}^{\*}_1 \ \boldsymbol{b}^{\*}_2 \ \dots \ \boldsymbol{b}^{\*}_n]$ と表す. なお, 直交化基底を求める方法として, Gram--Schmidt orthogonalization

  $$
  \begin{aligned}
      \boldsymbol{b}^{*}_1 &= \boldsymbol{b}_1\\
      \boldsymbol{b}^{*}_i &= \boldsymbol{b}_i - \sum_{j=1}^{i-1}\frac{\boldsymbol{b}^{t}_i\boldsymbol{b}^{*}_j}{\lVert\boldsymbol{b}^{*}_j\rVert^2}\boldsymbol{b}^{*}_j\quad 2\leq i\leq n
  \end{aligned}
  $$

  が知られている.
- 全次元格子 $L$ の順序付き基底 $B = [\boldsymbol{b}_1 \ \boldsymbol{b}_2 \ \dots \ \boldsymbol{b}_n]$ に対して,

  $$
      \det L = \prod_{i=1}^{n} \lVert\boldsymbol{b}^{*}_i\rVert
  $$

  が成り立つ.
- 全次元格子 $L$ の順序付き基底 $B = [\boldsymbol{b}_1 \ \boldsymbol{b}_2 \ \dots \ \boldsymbol{b}_n]$ が簡約基底であるとは,

  $$
  \begin{aligned}
      &\lvert \mu_{ij} \rvert\leq \frac{1}{2}\quad 0\leq i < j \leq n,\\
      &\lVert \boldsymbol{b}^{*}_{i+1} + \mu_{i+1, i}\boldsymbol{b}^{*}_i \rVert^2 \geq (3/4)\lVert \boldsymbol{b}^{*}_{i} \rVert^2 \quad 1\leq i\leq n
  \end{aligned}
  $$

  の２つの条件が成り立つときにいう.


## 3. 定理の証明

$a_1, \dots, a_n\in\mathbb{Q}$, $0<\varepsilon<1$とする.
$\mathbb{R}^{n+1}$ の第 $i$ 番目の単位ベクトルを $\boldsymbol{e}\_{i}$ とし[^3],

$$
    \boldsymbol{a} = (a_1, \dots, a_n, 2^{-n(n+1)/4}\varepsilon^{n+1})^{t}
$$

とする.
また, $A = [\boldsymbol{e}\_1 \ \boldsymbol{e}\_2 \ \dots \boldsymbol{e}\_n \ \boldsymbol{a}] \in M\_{n+1}(\mathbb{R})$ とし, $A$ により生成される格子を $L$ とする.
このとき, $A$ の互いに異なる列に位置するベクトルはどれも直交していることに注意すると, 

$$
\begin{aligned}
    \det L = \lVert \boldsymbol{e}_1 \rVert\dots\lVert \boldsymbol{e}_n \rVert\lVert \boldsymbol{a} \rVert = 2^{-n(n+1)/4}\varepsilon^{n+1}
\end{aligned}
$$

である. 
LLLアルゴリズムによって, 
$L$ の 簡約基底[^4] $B = \{\boldsymbol{b}\_1, \boldsymbol{b}\_2, \dots, \boldsymbol{b}\_{n+1}\}$ を多項式時間で得ることができる. 
ここで, 簡約基底の定義から

$$
    \lVert \boldsymbol{b}^{*}_i \rVert \leq \frac{1}{2} \lVert \boldsymbol{b}^{*}_{i+1} \rVert
$$

なので,[^5] 

$$
    \det L = \displaystyle\prod_{i=1}^{n+1} \lVert \boldsymbol{b}^{*}_i \rVert \geq \lVert \boldsymbol{b}^{*}_1 \rVert^{n} 2^{-(1 + \dots + n)/2} = \lVert \boldsymbol{b}_1 \rVert^{n} 2^{-n(n+1)/4}.
$$

これと $\det L = 2^{-n(n+1)/4}\varepsilon^{n+1}$ より, 

$$
    \lVert \boldsymbol{b}_1 \rVert \leq \varepsilon
$$

が得られる. 
ここで, $\boldsymbol{b}_1 \in L$ より整数 $p_i, q$ を用いて

$$
    \boldsymbol{b}_1 = \sum_{i-1}^{n} p_i\boldsymbol{e}_i - q\boldsymbol{a}
$$

と表される. 
もし　$q = 0$ とすると, $\lVert \boldsymbol{b}\_1 \rVert \leq \varepsilon < 1$ より $p_1 = \dots = p_n = 0$ すなわち $\boldsymbol{b}_1  = 0$ となって矛盾. よって, $q \neq 0$. 更に, $q<0$ とすると,

$$
\begin{aligned}
        \lVert \boldsymbol{b}_1 \rVert 
        &\geq \lVert \sum_{i=1}^{n} p_i\boldsymbol{e}_i \rVert - \lVert q\boldsymbol{a}\rVert\\
        &= \lVert \sum_{i=1}^{n} p_i\boldsymbol{e}_i \rVert - q\lVert \boldsymbol{a}\rVert\\
        &\geq \lVert \sum_{i=1}^{n} p_i\boldsymbol{e}_i \rVert\\
        &= \sqrt{\sum_{i=1}^{n} p^2_i}\\
        &\geq 1
\end{aligned}
$$

であることから $\lVert \boldsymbol{b}\_1 \rVert < 1$ と矛盾.[^6] よって $q > 0$.
したがって, 

$$
    \lVert \boldsymbol{b}_1 \rVert = \sqrt{\sum_{i=1}^{n}(p_i - qa_i)^2 + (q2^{-n(n+1)/4}\varepsilon^{n+1})^2} \leq \varepsilon
$$

となり, 特に

$$
\begin{aligned}
    &(p_i - qa_i)^2 \geq 0\\
    &(q2^{-n(n+1)/4}\varepsilon^{n+1})^2 > 0
\end{aligned}
$$

に注意すると, 

$$
    \lvert p_i - qa_i \rvert < \sqrt{\sum_{i=1}^{n}(p_i - qa_i)^2 + (q2^{-n(n+1)/4}\varepsilon^{n+1})^2} \leq \varepsilon
$$

および

$$
\begin{aligned}
    &q2^{-n(n+1)/4}\varepsilon^{n+1} \leq \sqrt{\sum_{i=1}^{n}(p_i - qa_i)^2 + (q2^{-n(n+1)/4}\varepsilon^{n+1})^2} \leq \varepsilon\\
    &q \leq 2^{n(n+1)/4}\varepsilon^{-n}
\end{aligned}
$$

が得られる. 

### 参考文献
- 福田公明, 森山園子著, [凸多面体と計算](https://www.kyoritsu-pub.co.jp/book/b10105468.html), 共立出版, 2025.
- 高木剛著, [現代暗号理論](https://www.iwanami.co.jp/book/b652389.html), 岩波書店, 2024.
- 青野良範, 安田雅哉著, [格子暗号解読のための数学的基礎](https://www.kindaikagaku.co.jp/book_list/detail/9784764905986/), 近代科学社, 2019.

<!-- 脚注 -->
### 脚注
[^1]: 多分 Dirichlet の 1842 年の論文では多変数の場合で主張が述べられていそう. 文献調査を行っていないので正確な部分は把握していない.
[^2]: 現状の先行研究にてどこまでわかっているのは文献調査を行っていないため不明. わかっていないというのは福田, 森山著「凸多面体と計算」の第 12 章の記述による. 
[^3]: 特に断らない限り, ベクトルは縦ベクトルで表されているものとする.
[^4]: 呼び方は文献によって様々. LLL縮約基底, LLL簡約されている基底などと呼ばれることがある.
[^5]: 実際, $\lVert \boldsymbol{b}^{\*}\_{i+1} + \mu_{i+1, i}\boldsymbol{b}^{\*}\_i \rVert^2 \geq (3/4)\lVert \boldsymbol{b}^{\*}\_{i} \rVert^2$ 及び $(\boldsymbol{b}^{\*}\_{i})^{t}\boldsymbol{b}^{\*}\_{i+1} = 0$ から従う.
[^6]: $p_1 = \dots = p_n =0$ ではないことを用いた.

