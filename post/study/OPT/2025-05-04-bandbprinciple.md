---
layout: default
title: "BandBprinciple"
date: 2025-05-04 14:54:54
use_mathjax: true
# categories:
---

# 分枝限定法の原理

分子限定法の原理を整理する. 

## 問題

以下, 最小値問題 $(P_0)$

> $$
> \begin{aligned}
> \min \ f(\boldsymbol{x})\\
> \text{s.t.} \ \ &\boldsymbol{x} \in X
> \end{aligned}
> $$

を考える.[^1] ただし, 関数 $f\colon \mathbb{R}^{n} \to \mathbb{R}$ は線形関数とする.[^2]

## 解法

問題 $(P_0)$ を解く設計思想は以下の通り. 

1. 実行可能領域 $X$ を分割し, 子問題 $(P_i)$ を作成する 
2. 各子問題 $(P_i)$ の緩和問題 $(P'_i)$ を解く
3. $(P'_i)$ の解を利用して「効率的」に $(P_0)$ を解く

以下, 各段階の詳細について述べる. 

### 1. 実行可能領域 $X$ を分割し, 子問題 $(P_i)$ を作成する 

文字通り
$$
    X = \bigcup_{1\leq i\leq k} X_i
$$ 
と分割する.
ここで, 分割の際は disjoint な分割を考える.[^3] すなわち
$$
    i\neq j \Rightarrow X_i \cap X_j = \emptyset
$$
を満たしているとする.
各分割に対して, $(P_0)$ の子問題 $(P_i)$ を

> $$
> \begin{aligned}
> \min \ f(\boldsymbol{x})\\
> \text{s.t.} \ \ &\boldsymbol{x} \in X_i
> \end{aligned}
> $$

と定める. 

### 2. 各子問題 $(P_i)$ の緩和問題 $(P'_i)$ を解く

$X_i \subset X'_i$ を考えると, $(P_i)$ の緩和問題 $(P'_i)$

> $$
> \begin{aligned}
> \min \ f(\boldsymbol{x})\\
> \text{s.t.} \ \ &\boldsymbol{x} \in X'_i
> \end{aligned}
> $$

が考えられる. この緩和問題の解を $\boldsymbol{x}'_{i}$ と表す.[^4]

### 3. $(P'_i)$ の解を利用して「効率的」に $(P_0)$ を解く

これまでの設定より, 
$$
\begin{aligned}
    \displaystyle\inf_{\boldsymbol{x} \in X} f(\boldsymbol{x}) = \displaystyle\inf_{\boldsymbol{x} \in \bigcup_{1\leq i\leq k} X_i} f(\boldsymbol{x}) = \inf_{1\leq i\leq k}\left(\inf_{\boldsymbol{x}\in X_i} f(\boldsymbol{x})\right)
\end{aligned}
$$
が成り立つ. 
ここで, 

> $\displaystyle \inf_{\boldsymbol{x}\in X_i} f(\boldsymbol{x})$ の解 $\boldsymbol{x}_i$ が得られた (ただし, $f(\boldsymbol{x}_i) \neq \pm\infty$)

と仮定する. このとき, 

> $$
>   \inf_{x\in X'_j} f(\boldsymbol{x}) > f(\boldsymbol{x}_i) \Rightarrow \inf_{\boldsymbol{x} \in X} f(\boldsymbol{x}) = \inf_{\boldsymbol{x} \in X\setminus X_{j}} f(\boldsymbol{x})
> $$

が成り立つ. 
実際, 
$$
    \displaystyle \inf_{\boldsymbol{x}\in X_i} f(\boldsymbol{x}) \leq f(\boldsymbol{x}_i) < \inf_{x\in X'_j} f(\boldsymbol{x}) \leq  \inf_{x\in X_j} f(\boldsymbol{x})
$$
より,
$$
\begin{aligned}
    \displaystyle\inf_{\boldsymbol{x} \in X} f(\boldsymbol{x})
    &= \displaystyle\inf_{\boldsymbol{x} \in \bigcup_{1\leq l\leq k} X_l} f(\boldsymbol{x})\\
    &= \inf_{1\leq l\leq k}\left(\inf_{\boldsymbol{x}\in X_l} f(\boldsymbol{x})\right)\\
    &= \inf\left(\inf_{\substack{1\leq l\leq k\\ l\neq i, j}} \left(\inf_{\boldsymbol{x}\in X_{l}} f(\boldsymbol{x})\right),  \inf_{\boldsymbol{x}\in X_{i}} f(\boldsymbol{x}), \inf_{\boldsymbol{x}\in X_{j}} f(\boldsymbol{x})\right)\\
    &= \inf\left(\inf_{\substack{1\leq l\leq k\\ l\neq i, j}} \left(\inf_{\boldsymbol{x}\in X_{l}} f(\boldsymbol{x})\right),  \inf_{\boldsymbol{x}\in X_{i}} f(\boldsymbol{x})\right)\\
    &= \inf_{\substack{1\leq l\leq k\\ l\neq j}} \left(\inf_{\boldsymbol{x}\in X_{l}} f(\boldsymbol{x})\right)\\
    &= \inf_{\boldsymbol{x} \in X\setminus X_{j}} f(\boldsymbol{x})
\end{aligned}
$$
である.
これより, もともと考えていた最小値問題 $(P_0)$ について, $\displaystyle \inf_{\boldsymbol{x} \in X}$ での探索範囲を削減することが見て取れる. 上記で登場した $i, j$ に相当するものを「適切に」見つけることで, $(P_0)$ を効率的に解くことができる. 上記の流れで $(P_0)$ を解く方法を分子限定法といい, 
- 子問題に分割する操作を分子操作
- 上記 $j$ に相当する子問題 $(P_j)$ を探索し, その緩和問題 $(P'_j)$ の解を利用して探索する子問題を削減する操作を限定操作
という.

なお, 実際に分枝限定法用いて $(P_0)$ の解を得るためには, 上記解法を再帰的に適用する必要がある. というのも, $(P_0)$ を分割した子問題 $(P_l)$ はなお解くことが難しいことが常なので, 子問題 $(P_l)$ に対して再び子問題に分割し, 限定操作を行うことを繰り返すことになるのである. この操作は, 「解く必要のある子問題が解ける」まで繰り返される.

## 注意

分枝限定法の原理は上記の通りであるが, 実装の際は上記以外でも様々な部分で計算量を意識しつつ考慮しなければならない点がある. もう少し実装を意識した分枝限定法については改めてまとめる.
また, ソルバー内部で分枝限定法が適用されている場合は, 分枝限定法に切除平面法を組み合わせた分子カット法が基本適用されている. 上記原理から発展したアルゴリズムの原理も改めて整理したい.

<!-- 脚注 -->
[^1]: 実行可能領域 $X$ について, 変数の添字を適切に入れ替えると $X \subset \mathbb{R}^{n_1}\times \mathbb{Z}^{n_2}$ とみなせるもの (つまり混合整数計画問題または整数計画問題) を想定している.
[^2]: 原理的には $f$ として線形なもの以外でも分枝限定法は適用可能だが, 以降の説明で単体法 or 内点法を用いている箇所を考えている関数に応じて適切に変更する必要がある. 分枝限定法は「子問題を考えると解ける」場合に威力を発揮する.
[^3]: disjoint にしているのは, 実装の際の計算コストを削減するためというが１つの理由. 理論的にはdisjointにしていなくても問題ない.  
[^4]: もし子問題 $(P_i)$ が直接解ける場合はこのステップは不要. 現実的には子問題が直接解けることは少なく（子問題にしても IP または MIP のまま）, このステップで離散変数を連続変数に緩和する. 今の問題設定では, 連続変数に緩和すれば単体法や内点法によって解が得られる場合が多いことに注意する. 
