<script type="text/x-mathjax-config">MathJax.Hub.Config({tex2jax:{inlineMath:[['\$','\$'],['\\(','\\)']],processEscapes:true},CommonHTML: {matchFontHeight:false}});</script>
<script type="text/javascript" async src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.1/MathJax.js?config=TeX-MML-AM_CHTML"></script>


## Markdownについて

Markdown記法のメモ（自分用なのでまとまりがないです。使い方として誤っているものがあれば教えて下さい）

- インラインコードを記述する際はバッククオートで囲む。コードブロックはバッククオート３つで囲む
- 強調：アスタリスク２つ`**` またはアンダースコア２つ`__`で囲む
- 斜体：アスタリスク１つ`*` またはアンダースコア１つ`_`で囲む
- 打消し線：チルダ２つ`~~`で囲む
- 画像の挿入：以下の記法で表すことができる

```
![ロゴ](https://docbase.io/logo.png)
```

- チェックボックス：`- [ ]`の後にテキストを書くことで表せる。
未チェックの場合は`[]`の中に半角スペース、チェック済みの場合は`[]`の中に`x`（エックス）を入れる。
リストの中、かつ`[ ]`の後にテキストがなければ表示されない。
チェックボックスに続けて半角の`(`を書く場合、Markdownがうまくパースできず正常に表示できなくなってしまうので、以下のように`(`の前に`\`をつける。

```
`- [ ] \(abc)`
```

- 折りたたみ：`<details>`タグでコンテンツを折りたたむことができる。折りたたまれる内容は`<div>`タグで囲む。

```
<details><summary>details</summary><div>

- sushi
  - engawa
  - aburisarmon
</div></details>
```

実際には以下のように表示される。
<details><summary>details</summary><div>

- sushi
  - engawa
  - aburisarmon
</div></details>

- 数式について
  - GitHub Pagesでmarkdownファイルを静的なwebページとして公開する際、markdownファイル内に以下を記述する。これでMathJaxを入れているっぽい
  
  ```
    <script type="text/x-mathjax-config">MathJax.Hub.Config({tex2jax:{inlineMath:[['\$','\$'],['\\(','\\)']],processEscapes:true},CommonHTML: {matchFontHeight:false}});</script>
    <script type="text/javascript" async src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.1/MathJax.js?config=TeX-MML-AM_CHTML"></script>
  ```

  - ~~数式はコードブロックの言語指定をmathにすると表示される。~~
  どうもGitHub Pagesを介してサイトに表示させる場合にはうまく使えなさそう。別行立ての数式として利用するしかないかも
    
    ````
    ```math
    \begin{equation}
    sushi=
    \begin{pmatrix}
    ** & \cdots & \cdots & \cdots & \cdots & ** \\
    \cdots & L & O & V & E & \cdots &\\
    \cdots & A & N & D & \cdots & \cdots \\
    \cdots & P & E & A & C & E \\
    ** & \cdots & \cdots & \cdots & \cdots & ** \\
    \end{pmatrix}
    \end{equation}
    ```
    ````

    出力結果は以下の通り（`$$`で囲って出力させている）

    $$
    \begin{equation}
    sushi=
    \begin{pmatrix}
    ** & \cdots & \cdots & \cdots & \cdots & ** \\
    \cdots & L & O & V & E & \cdots &\\
    \cdots & A & N & D & \cdots & \cdots \\
    \cdots & P & E & A & C & E \\
    ** & \cdots & \cdots & \cdots & \cdots & ** \\
    \end{pmatrix}
    \end{equation}
    $$

  - `$`で囲むと数式をインライン表示できる
  - `$$`で囲むと別行立ての数式表示ができる
  - 他の方法もあるっぽい（cf. https://tex2e.github.io/blog/latex/mathjax-to-katex）

- テーブル：以下のように書ける。

```
|赤身|白身|軍艦|
|:---|:---:|---:|
|マグロ|ヒラメ|ウニ|
|カツオ|タイ|イクラ|
|トロ|カンパチ|ネギトロ|
```

実際の表示

|赤身|白身|軍艦|
|:---|:---:|---:|
|マグロ|ヒラメ|ウニ|
|カツオ|タイ|イクラ|
|トロ|カンパチ|ネギトロ|

  - 2行目の`-`（ハイフン）は、セルひとつにつき最低3つ書く必要がある。
  - セルのアライン指定（右寄せ、左寄せ、中央寄せ）は、アライン指定したい列の`|---|`に`:`を追加する。
    - 左寄せであれば`|:---|`
    - 中央寄せであれば`|:---:|`
    - 右寄せであれば`|---:|`

- 注釈：以下のように書く

```
今夜は寿司[^1]です。

[^1]: 酢飯の上になんか色々乗せた食べ物
```

実際の表示
今夜は寿司[^1]です。

- 目を引く形で補足説明を行う場合、以下の書き方ができる。

```
> [!NOTE]
> 補足などのメッセージ

> [!TIP]
> tipのメッセージ

> [!IMPORTANT]
> 重要なメッセージ

> [!WARNING]
> 警告のメッセージ

> [!CAUTION]
> より強い警告のメッセージ
```

実際の出力
> [!NOTE]
> 補足などのメッセージ

> [!TIP]
> tipのメッセージ

> [!IMPORTANT]
> 重要なメッセージ

> [!WARNING]
> 警告のメッセージ

> [!CAUTION]
> より強い警告のメッセージ

  - この書き方はGitHubによるもの[^2]。QiitaやZennの構文は異なる[^3]

## 参考にしたサイト
- [Markdownの書き方](https://help.docbase.io/posts/13697)：2024年6月9日閲覧
- [Markdown An option to highlight a Note and Warning using blockquote (Beta) #16925](https://github.com/orgs/community/discussions/16925)：2024年6月9日閲覧
- [Markdown記法 チートシート](https://qiita.com/Qiita/items/c686397e4a0f4f11683d)：2024年6月9日閲覧
- [GitHub Pagesで数式を書く方法と主なトラブルについて](https://qiita.com/BurnEtz/items/e79999264125eb128ae7)：2024年6月9日閲覧

#### 脚注
[^1]: 酢飯の上になんか色々乗せた食べ物
[^2]: https://github.com/orgs/community/discussions/16925
[^3]: https://roboin.io/article/2024/01/20/note-info-not-work-in-markdown/