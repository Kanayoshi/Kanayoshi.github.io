---
layout: default
title: "setting_latex"
date: 2025-05-04 14:54:54
# use_mathjax: true
# categories:
---

# ローカル環境での $\LaTeX$ の設定覚書

`/Users/(username)/.latexmkrc` を作成.

2025年5月3日時点の `.latexmkrc` の内容は以下の通り.

```
$latex = 'platex -synctex=1 -halt-on-error'; # pLaTeXを使う. -halt-on-errorで初めのエラーで終わらせる. synctexは有効にしている.
$amsrefs = 'amsrefs %O %S'; #amsrefsを使う（参考文献）
$dvipdf = 'dvipdfmx %O -o %D %S'; # DVIからPDFへの変換
$max_repeat = 5; # 最大のタイプセット回数
$pdf_mode = 3; # DVI経由でPDFをビルドすることを明示
# $pdf_previewer = 'open -a Skim' ; # コンパイル後にSkimを自動的に起動し, pdfファイルを開く

$success_cmd = "open -a Skim %D"; # latexmkが成功したときにSkimを一度だけ起動
```

実行時はコンパイルしたい `tex` ファイルがあるディレクトリまで移動し, 
```
latexmk (tex_file_name).tex
``` 
を実行する. 