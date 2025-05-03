<script type="text/x-mathjax-config">MathJax.Hub.Config({tex2jax:{inlineMath:[['\$','\$'],['\\(','\\)']],processEscapes:true},CommonHTML: {matchFontHeight:false}});</script>
<script type="text/javascript" async src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.1/MathJax.js?config=TeX-MML-AM_CHTML"></script>
 

## 参考文献  
- 前橋和弥著, 「新・標準プログラマズライブラリ　C言語　ポインタ完全制覇」, 技術評論社, 2017年.
- TBC


## メモリとアドレス  
- 現在のコンピュータで主記憶として主に使われているのはDRAMで, コンデンサやキャパシタと呼ばれる充電の有無と $0,1 = \text{bit}$ を対応させている.
- 大抵のコンピュータでは8ビットを1単位として扱う. これを1バイトと呼ぶ. 実際のメモリの仕様として, 1バイトを表現できるメモリを大量に並べて運用している.
- メモリの内容を読み書きするためには, 膨大にあるメモリのうちどこの情報にアクセスするのかを指定する必要がある. このときに用いる数値が**アドレス**である. 
- $2\text{バイト} = 2\times 8\text{ビット}$なら, $0$ から $2^16=65535$ の数を表現できる. 

<!-- 脚注 -->
