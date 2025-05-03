---
layout: default
title: "楕円曲線のランクについて"
date: 2025-05-03
<!-- categories: CATEGORY-1 CATEGORY-2 -->
---

# 楕円曲線のランクについて

<!-- Mathjaxを使用するためのもの -->
<script type="text/x-mathjax-config">MathJax.Hub.Config({tex2jax:{inlineMath:[['\$','\$'],['\\(','\\)']],processEscapes:true},CommonHTML: {matchFontHeight:false}});</script>
<script type="text/javascript" async src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.1/MathJax.js?config=TeX-MML-AM_CHTML"></script>
<!-- ここまで -->

## この記事について

2024年8月, 
（代数的な）ランクが $29$ の楕円曲線がElkiesとKlagsbrunによって構成されたことが報告[^1]され, 
久々に楕円曲線のランクの下限値が更新された[^2]. 
楕円曲線のランクに関しては, 先行研究は多々あるもののまだまだ分かっていないことも多い. 
ここでは, 現状でどのようなことが分かっているのかを備忘録程度にまとめておく. 

なお, 同様の趣旨の文献としてSilverbergの文献[^3]がある. 
本記事の内容は殆どこの文献の内容と同様であることに注意する.

## 基礎事項

- 体 $K$ 上の楕円曲線 $E$ とは, 滑らかな射影曲線で, アファインの定義方程式として
$$
    y^2 + a_1xy + a_3y = x^3 + a_2x^2 + a_4x + a_6 \ (a_i \in K)
$$
を持つもののことを指す.

- 特に定義方程式の形が $y^2 = x^3+Ax+B$ のとき, 
$E$のdiscriminantを
$$
    \Delta(E) = -16(4A^3+27B^2)\neq 0
$$
と定める.

- $K$が素体[^4]上有限生成のとき, Mordell-Weil群 $E(K)$ は有限生成アーベル群になる. すなわち
$$
    E(K) \cong \mathbb{Z}^{\mathrm{rank}(E)} \oplus E(K)_{\text{tors}}
$$
である. 

- Tate--Shafarevich群は
$$
    \mathrm{Sha}(E/K) = ker\left[H^1(K, E) \to \prod_{v} H^1(K_v, E) \right] 
$$
と定められる.[^5]
ただし, $H^1(F, E) = H^1(\mathrm{Gal}(\overline{F}/F), E(\overline{F}))$.  
Tate--Shafarevich群は有限であることが予想されている. 



## ランクの上界

ランクの上界については1960年にHonda[^6]によって以下の予想が提出された:

> $E$ を $\mathbb{Q}$ 上の楕円曲線とする. 
> このとき, $E$ のみに依存する定数 $C_E$が存在して, 全ての $d$ に対して
> $$ \mathrm{rank}(E_d(\mathbb{Q})) \leq C_E$$
> が成り立つ. ただし, $E_d$ は $E$ のquadratic twist.

一方, 関数体上ではShafarevich--Tate[^7]によってrankが非有界な楕円曲線のquadratic twistの族が構成された.
同様の現象は $\mathbb{Q}$上でも生じることが見込まれ, したがってHondaの予想は正しくないだろうと信じられている. 
最近Park--Poonen--Voight--Wood[^8]によって楕円曲線のランクには上界があるというheuristicが提案されている. 




[^1]: https://web.math.pmf.unizg.hr/~duje/tors/rankhist.html
[^2]: 脚注1のサイトによると18年ぶり. 前回のrecordを構成したのもElkiesだった. すごい. 
[^3]: https://www.math.uci.edu/~asilverb/bibliography/RanksCheatSheet.pdf
[^4]: 自分自身以外に部分体を持たない体のこと. 同型の違いを除いて$\mathbb{Q}$ か $\mathbb{F}_p$ しか無い. 
[^5]: Tate--Shafarevich群は通常キリル文字のШ（シャー）を用いて表される. また, よっぽどの事情がない限り人名はアルファベット順に並べるのが通例なため, Shafarevich--Tate群と呼ばれることもある. 
[^6]: https://doi.org/10.4099/jjm1924.30.0_84
[^7]: Shafarevich--Tate, "The rank of eliptic curves", Dokl. Akad. Nauk SSSR 175(1967), no.4, 770-773
[^8]: "A heuristic for boundedness of ranks of elliptic curves"