---
layout: default
title: "parigp_note1"
date: 2025-07-06
use_mathjax: true
# categories:
---

# Pari/GP を使う際の注意

Pari/GP を用いて外部ファイルに記載したコードを実行しようとした際にハマった点があったためメモ。
簡単に述べると、gp にて外部ファイルを実行する際に、バックスラッシュを挿入することなくインデントを用いると、エラーが生じる。

例えば、以下のようなコードは正常に実行される。

```gp
is_gaussian_prime(a, b) =
{
if (a == 0 && b == 0, return(0)); my(n = a^2 + b^2);
if ( a == 0 || b == 0, return (isprime(n) && (n % 4 == 3)); , return (isprime(n)); );
};

for ( x = -M, M, { print(is_gaussian_prime(x,2)) } );
```

一方、インデントを設けた以下のコードは実行するとエラーが生じた。

```gp
is_gaussian_prime(a, b) =
{
    if (a == 0 && b == 0, return(0)); 
        my(n = a^2 + b^2);
    if ( a == 0 || b == 0, 
    return (isprime(n) && (n % 4 == 3)
    );
     ,
    return (isprime(n)); );
};

for ( x = -M, M, 
    {
        print(is_gaussian_prime(x,2))
    }
);
```

以下は実行時のエラー文。

```text
***   syntax error, unexpected end of file, expecting )-> or ',' or ')': 
***   for(x=-M,M,
***             ^-
***   at top-level: print(is_gaussian_prime(x,2))
***                       ^-----------------------
***   in function is_gaussian_prime: ...me(n)&&(n%4==3));,return(
***   isprime(n));)
***   ^-------------
*** isprime: incorrect type in BPSW_psp (t_POL).
***   Break loop: type 'break' to go back to GP prompt
```

各行の先頭に空白を設けるとうまく読み取ってくれないっぽい。
今後 Pari/GP のコードを書く際は注意が必要そう。

更に、`{}` を入れ子にすることも不可。例えば、

```gp
f() = { for(i = 1, 5, { print(i); }); }
```

を実行すると、

```
sorry, embedded braces (in parser) is not yet implemented.
```

というエラーが生じる。GP の構文パーサは、中括弧のネストをサポートしていない。
もし上記のコードを実行する際は、以下のように修正する。

```gp
f() = { for(i = 1, 5, print(i); ); }
```

上記の内容を踏まえると、2重 `for` 文を回す際には以下のように書く必要がある。

```gp
M = 5;

is_gaussian_prime(a, b) =
{
if (a == 0 && b == 0, return(0));
my(n = a^2 + b^2);
if (a == 0 || b == 0, return (isprime(n) && (n % 4 == 3)); , return (isprime(n)););
};

for (a1 = -M, M, for (b1 = -M, M, if (!is_gaussian_prime(a1, b1), next()); my(p1 = a1 + b1 * I); print(p1); ); );
```

これはいささか読みづらい。せめて改行を挟みたいが、以下の書き方はすべてエラーが生じる。

```gp
\\ エラーが生じる例１
for (
a1 = -M, M, for (b1 = -M, M,
if (!is_gaussian_prime(a1, b1), next()); my(p1 = a1 + b1 * I); print(p1); );
);

\\ エラーが生じる例２
for (a1 = -M, M, for (b1 = -M, M, if (!is_gaussian_prime(a1, b1), next());
my(p1 = a1 + b1 * I);
print(p1););
);

\\ エラーが生じる例３
for (a1 = -M, M, for (b1 = -M, M, if (!is_gaussian_prime(a1, b1), next());
my(p1 = a1 + b1 * I); print(p1););
);
```

改行を行いたい場合、バックスラッシュを明示すると良い。例えば以下は正常に実行される。

```gp
for (a1 = -M, M,\
    for (b1 = -M, M,\
        if (!is_gaussian_prime(a1, b1), next());\
        my(p1 = a1 + b1 * I);\
        print(p1);\
    );\
);
```

# 参考：ChatGPTの回答

以下は「外部ファイルからコードを実行する際、インデントありだとうまく読み込まれないが、インデントを含めたコードを実行する方法はないか？」と ChatGPT に質問した回答

## Pari/GPでインデント付きコードを外部ファイルから実行する方法

Pari/GP (`gp`) において、**インデント付きのコードを外部ファイルから実行するとエラーになる**のは既知の制限です。これはGPスクリプトが、インデント（スペース）を構文的に許容しないためです。

---

### ❌ インデント付きで失敗するコードの例

```gp
for(i=1, 5,
    print(i);
)
```

これを `test.gp` に保存して以下を実行すると：

```bash
gp < test.gp
```

次のようなエラーが出る：

```
  ***   unexpected character:   (空白)
```

---

### ✅ 解決策1：インデントを避けて1行ずつ書く

```gp
for(i=1, 5,
print(i);
)
```

---

### ✅ 解決策2：`\`（バックスラッシュ）で複数行を明示

```gp
for(i=1, 5, \
    print(i); \
)
```

---

### ✅ 解決策3：Bashのヒアドキュメントを使う

```bash
gp -q <<EOF
for(i=1, 5,
    print(i);
);
EOF
```

標準入力からの読み込みになるため、インデントも許容されやすい。

---

### ✅ 解決策4：インデント付きスクリプトを整形ツールで変換

インデント付きの `.gp` ファイルを自動で「非インデント形式」に変換するPythonスクリプトなどを使うことで、スクリプト全体の可読性と実行可能性を両立できる。

---

### 🔚 まとめ

| 方法                             | インデント保持 | 推奨度     | 備考                   |
|----------------------------------|----------------|------------|------------------------|
| インデントを使わない書き方       | ✗              | ⭐️⭐️⭐️⭐️⭐️ | 最も安定               |
| `\` を使って複数行を明示         | △              | ⭐️⭐️⭐️⭐️   | 中程度の可読性         |
| Bashの `<<EOF` でヒアドキュメント | ◯              | ⭐️⭐️⭐️     | 短いコード向き         |
| 整形ツールで変換                 | ◯              | ⭐️⭐️       | 自動変換が必要         |
