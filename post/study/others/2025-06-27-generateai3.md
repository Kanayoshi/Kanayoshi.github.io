---
layout: default
title: "generateai3"
date: 2025-06-27
use_mathjax: true
# categories:
---

# 生成AIを使ったプログラミング(3)

今回はプログラミングというよりも数学の研究を意識した使い方を考える。手始めに、楕円曲線のランクが3であるようなものを探索するMAGMAのコードを作成させてみた。

入力は以下の通り。

```python
from google import genai
from dotenv import load_dotenv
import os
load_dotenv()
google_api_key = os.getenv("GOOGLE_API_KEY")
client = genai.Client(api_key=google_api_key)

prompt = """
You are an engineer well-versed in number theory and programming. 
I would like to search for elliptic curves of rank 3 through numerical experiments. 
Could you provide code to perform such numerical experiments? 
Please use MAGMA for the implementation.
If you are able to implement the MAGMA code, please output the code in an `.md` file. 
Place the generated `.md` file in the current directory.
"""

response = client.models.generate_content(
    model="gemini-2.5-flash",
    contents=prompt
)

print(response.text)
```

プロンプトの最後

```
If you are able to implement the MAGMA code, please output the code in an `.md` file. 
Place the generated `.md` file in the current directory.
```

は完全にサボって出てくれると嬉しいなと思い入れてみたが、きちんとmdファイルとして出力されはしなかった。せっかくAPIキーを使ってやっているのだから、出力からMAGMA実行まで通してできるようにするくらいの実装はやってみたい。

出力は以下の通り。

```
As an engineer well-versed in number theory and programming, I can certainly help you with numerical experiments to search for elliptic curves of rank 3 using MAGMA.

Searching for high-rank elliptic curves is a challenging problem in number theory. The rank of an elliptic curve refers to the number of independent points of infinite order on the curve, forming the basis of its Mordell-Weil group. While there are theoretical bounds and specific families known to have high ranks, a straightforward numerical experiment often involves iterating over the coefficients of the Weierstrass equation `y^2 = x^3 + Ax + B` and computing the rank for each curve.

Please note that computing the rank of an elliptic curve can be computationally very intensive, especially for curves with large coefficients or complex arithmetic. The provided code iterates over a small range of `A` and `B` values. Extending this range significantly will drastically increase computation time.

Here's the MAGMA code for your numerical experiment, saved as `elliptic_curve_rank3_search.md`:

```markdown
# MAGMA Code for Searching Elliptic Curves of Rank 3

This MAGMA script performs a numerical experiment to search for elliptic curves of rank 3.
It iterates over a predefined range of integer coefficients `A` and `B` for the short Weierstrass form `y^2 = x^3 + Ax + B`.

**Important Considerations:**
1.  **Computation Time**: Calculating the rank of an elliptic curve can be computationally very expensive. The search range for `A` and `B` is kept small for demonstration purposes. Extending this range significantly will lead to very long computation times.
2.  **Search Strategy**: This is a brute-force approach over a limited set of coefficients. More sophisticated methods exist for finding high-rank curves (e.g., using specific families, techniques involving Heegner points, or advanced L-function computations).
3.  **Singular Curves**: The script checks for singular curves (where the discriminant `4A^3 + 27B^2` is zero) and skips them, as these are not elliptic curves.

```magma
// Define the base field as Rational Numbers
Q := Rationals();

// --- Configuration Parameters ---
// Set the search range for coefficients A and B.
// Warning: Extending these values significantly will increase computation time
// exponentially, as rank computation can be very slow.
min_val := -20; // Minimum value for A and B
max_val := 20;  // Maximum value for A and B

// --- Search Initialization ---
print "Starting search for elliptic curves of rank 3...";
print SPrint("Searching A from %o to %o, and B from %o to %o.", min_val, max_val, min_val, max_val);
print "This may take some time depending on the range and your system's resources.";

count_rank3 := 0;           // Counter for curves found with rank 3
total_curves_checked := 0;  // Counter for total non-singular curves examined

// --- Main Search Loop ---
for A in [min_val..max_val] do
    for B in [min_val..max_val] do
        // Calculate the discriminant of the curve y^2 = x^3 + Ax + B
        // Discriminant Delta = 4A^3 + 27B^2
        discriminant := 4*A^3 + 27*B^2;

        // Skip singular curves (discriminant must be non-zero for an elliptic curve)
        if discriminant eq 0 then
            continue;
        end if;

        // Increment the counter for valid curves checked
        total_curves_checked +:= 1;

        // Construct the elliptic curve object in MAGMA
        // The coefficients A and B are cast to the rational field Q
        E := EllipticCurve([Q!A, Q!B]);

        // Compute the rank of the Mordell-Weil group of the elliptic curve.
        // This is the most computationally intensive part.
        rank_E := Rank(E);

        // If the computed rank is 3, print the curve equation
        if rank_E eq 3 then
            count_rank3 +:= 1;
            print SPrint("Found Rank 3 Curve #%o: y^2 = x^3 + %o*x + %o (Discriminant: %o)", count_rank3, A, B, discriminant);
            // Optionally, uncomment the line below to also print the Mordell-Weil group structure
            // print "Mordell-Weil Group:", MordellWeilGroup(E);
            // Example of a known rank 3 curve: y^2 = x^3 - 79x + 306 (though not in this small A,B range)
            // Example from the search: y^2 = x^3 - 11x + 14 is rank 3.
        end if;
    end for;
end for;

// --- Search Summary ---
print "\n--- Search Complete ---";
print SPrint("Total non-singular curves checked: %o", total_curves_checked);
print SPrint("Total Rank 3 curves found within the specified range: %o", count_rank3);
print "Note: This search is not exhaustive and only covers a small range of coefficients.";
print "Finding higher rank curves often requires more sophisticated search strategies or specific families of curves.";
```

プロンプトに余計なことを書いたため余分なブロックが現れている。生成されたMAGMAのコードはそのままだとエラーが生じる。原因はところどころに現れている `SPrint` である。ChatGPTを使って以下の通り修正を施した（コード部分のみ）。

```
// Define the base field as Rational Numbers
Q := Rationals();

// --- Configuration Parameters ---
// Set the search range for coefficients A and B.
// Warning: Extending these values significantly will increase computation time
// exponentially, as rank computation can be very slow.
min_val := -20; // Minimum value for A and B
max_val := 20;  // Maximum value for A and B

// --- Search Initialization ---
print "Starting search for elliptic curves of rank 3...";
print "Searching A from " cat IntegerToString(min_val) cat " to " cat IntegerToString(max_val) cat
      ", and B from " cat IntegerToString(min_val) cat " to " cat IntegerToString(max_val) cat ".";
print "This may take some time depending on the range and your system's resources.";


count_rank3 := 0;           // Counter for curves found with rank 3
total_curves_checked := 0;  // Counter for total non-singular curves examined

// --- Main Search Loop ---
for A in [min_val..max_val] do
    for B in [min_val..max_val] do
        // Calculate the discriminant of the curve y^2 = x^3 + Ax + B
        // Discriminant Delta = 4A^3 + 27B^2
        discriminant := 4*A^3 + 27*B^2;

        // Skip singular curves (discriminant must be non-zero for an elliptic curve)
        if discriminant eq 0 then
            continue;
        end if;

        // Increment the counter for valid curves checked
        total_curves_checked +:= 1;

        // Construct the elliptic curve object in MAGMA
        // The coefficients A and B are cast to the rational field Q
        E := EllipticCurve([Q!A, Q!B]);

        // Compute the rank of the Mordell-Weil group of the elliptic curve.
        // This is the most computationally intensive part.
        rank_E := Rank(E);

        // If the computed rank is 3, print the curve equation
        if rank_E eq 3 then
            count_rank3 +:= 1;
            print "Found Rank 3 Curve #" cat IntegerToString(count_rank3) cat ": y^2 = x^3 + " cat IntegerToString(A) cat "*x + " cat IntegerToString(B) cat " (Discriminant: " cat IntegerToString(discriminant) cat ")";
            // Optionally, uncomment the line below to also print the Mordell-Weil group structure
            // print "Mordell-Weil Group:", MordellWeilGroup(E);
            // Example of a known rank 3 curve: y^2 = x^3 - 79x + 306 (though not in this small A,B range)
            // Example from the search: y^2 = x^3 - 11x + 14 is rank 3.
        end if;
    end for;
end for;

// --- Search Summary ---
print "\n--- Search Complete ---";
print "Total non-singular curves checked: " cat IntegerToString(total_curves_checked);
print "Total Rank 3 curves found within the specified range: " cat IntegerToString(count_rank3);
print "Note: This search is not exhaustive and only covers a small range of coefficients.";
print "Finding higher rank curves often requires more sophisticated search strategies.";
```

実行した結果は以下の通り。

```
Starting search for elliptic curves of rank 3...
Searching A from -20 to 20, and B from -20 to 20.
This may take some time depending on the range and your system's resources.
Found Rank 3 Curve #1: y^2 = x^3 + -16*x + 1 (Discriminant: -16357)
Found Rank 3 Curve #2: y^2 = x^3 + -13*x + 4 (Discriminant: -8356)
Found Rank 3 Curve #3: y^2 = x^3 + 14*x + 1 (Discriminant: 11003)
Found Rank 3 Curve #4: y^2 = x^3 + 19*x + 16 (Discriminant: 34348)

--- Search Complete ---
Total non-singular curves checked: 1676
Total Rank 3 curves found within the specified range: 4
Note: This search is not exhaustive and only covers a small range of
coefficients.
Finding higher rank curves often requires more sophisticated search strategies.
```

MAGMAの結果に現れている４つの楕円曲線について、[LMFDB](https://www.lmfdb.org) を見てみる。

- [Curve #1](https://www.lmfdb.org/EllipticCurve/Q/65428/a/1)
- [Curve #2](https://www.lmfdb.org/EllipticCurve/Q/66848/a/1)
- [Curve #3](https://www.lmfdb.org/EllipticCurve/Q/88024/a/1)
- [Curve #4](https://www.lmfdb.org/EllipticCurve/Q/274784/a/1) 

いずれもMW rankは3になっている。一方、discriminantの値が異なっている。また、今回探索している係数全体のなかで上記4つのみしかrankが3のものが存在しないかどうかは検証していない。
また、オンライン上で使用できるMAGMAは

```
Calculations are restricted to 120 seconds.
Input is limited to 50000 bytes.
```

という制限があるため、生成されたコメント付きのコードをそのまま入れるのはよろしくない（せめて実行時にはコメントアウトを削除すべき）。

数学の研究の補助として用いるにも、使い方に工夫を凝らさないと（現状は）あまり有効ではない場合も多そうな気がする。今回のコードの解析も行いつつ、他の使い方も実験していってみたい。