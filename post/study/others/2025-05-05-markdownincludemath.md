---
layout: default
title: "markdownincludemath"
date: 2025-05-05
# use_mathjax: true
# categories:
---

# 数式の入ったマークダウン記法の注意点

インライン記法で数式を利用する際, Markdown でもともと用意されている記法と被るものを使用する際はバックスラッシュを置く. 例えば, `*`, `~`, `_` など.
また, `$$` を用いた別行立て数式の前後は1行空ける. tex と異なり, マークダウンでは空白の調整がなされないため, 入力時に調整する必要がある.

コードブロックを利用することで, 別行立ての数式
```math
x^3+y^3+z^3
```
が出力されている？ -> これはローカルサーバーでの機能時のみかもしれない. 

冒頭の `use_mathjax` はfalse, もしくはコメントアウトしておく. これはバグなので, 後ほど `true` の状態で数式が利用できるようにデバッグする.

### 参考文献
- [基本的な書き方とフォーマットの構文](https://docs.github.com/ja/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)
- [Qiita で集合や添字の数式を書こうとしてブチギれるその前に](https://qiita.com/BlueRayi/items/7965798ba1127d269ebb)
