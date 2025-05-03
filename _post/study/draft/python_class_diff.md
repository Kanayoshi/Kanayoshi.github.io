# Pythonでの`dataclass`について

Pythonの`dataclass`についてまとめる. 

## 使い方

次のようなクラスを考える.
```python
class Person:
    def __init__(self, number, name='XXX'):
        self.number = number
        self.name = name

person = Person(0, 'Alice')

print(person.number) #0
print(person.name) #Alice
```
`dataclass`を用いると, 
以下のように書ける. 

```python
import dataclass

@dataclasses.dataclass
class DataclassPerson:
    number: int
    name: str = 'XXX'

person = DataclassPerson(0, 'Alice')

print(person.number) #0
print(person.name) #Alice
```

## `dataclass`の初歩的な注意点
- dataclassデコレータはPython3.7から用意されている.
- `__init__()`で引数をインスタンス変数に代入する必要がない (`__init__()`を自動的に作る). 
- 型アノテーションが必須になっている. 型が分かって嬉しい (型アノテーションは必須でなくてもつける癖をつけておいた方が良い). 

## 類似の機能との比較

### 辞書を用いる
先ほど紹介したクラスだけに着目すると, 
以下のようにdict形式で実装することができる.

```python
person = {'number': 0, 'name': 'Alice'}
print(person.number) #0
print(person.name) #Alice
```

しかし, dict形式には以下のようなデメリットがある.
- ドットアクセスが出来ない
- メソッドが入らない
- 型アノテーションができない
- 決まった形になっていることがコードからつかみにくい
- 継承, 参照などの操作が出来ない
- 変更に強くない (コードの変更が生じた際, 修正箇所が増加する)
保守性の観点からも, 
クラスを使用する場面でdict形式を用いるべきではない. 

### `namedtuple`
ドットアクセスができるtuple = イミュータブルなインスタンスは以下のように作成できる.

```python
from collections import namedtuple

Person = namedtuple('Person', ('number', 'name'))

person = Person(number=0, name='Alice')

print(person.number) #0
print(person.name) #Alice
```

これと`dataclass`はかなりよく似ている. 
しかし, 例えば以下の通り同じ要素を持つtupleとの比較で`True`になる.

```python
from collections import namedtuple

Person = namedtuple('Person', ('number', 'name'))

person = Person(number=0, name='Alice')
print(person == ('0', 'Alice')) #True
```

一方, `dataclass`の場合はこのような事は生じない. 
また, `namedtuple`はtupleなためアンパック代入ができる. `dataclass`ではアンパック代入は出来ない. 

```python
from collections import namedtuple

Person = namedtuple('Person', ('number', 'name'))

person = Person(number=0, name='Alice')
hoge, geho = persion
print(hoge) #0
print(geho) #Alice
```

以下, 使い分けの指針
1. `dataclass`を用いる場合
- データの変更が必要な場合
- 複雑なデフォルト値やフィールドの制約が必要な場合
- クラスに多くのメソッドを追加したい場合
- 継承を活用したい場合

2. `namedtuple`を用いる場合
- イミュータブルなデータ構造が必要な場合
- メモリ効率を最大化したい場合
- 主にデータの保持が目的の場合
- タプルの機能（アンパッキング）を活用したい場合

## 更に詳しい知識

追記予定


## 参考文献
- [Pythonカスタムデータ型の作成: dataclassesとNamedTupleの比較と使い分け](https://qiita.com/Tadataka_Takahashi/items/fd4dcd54d4ec2c9780fe) (最終閲覧日: 2024年8月29日)
- [Python3.7以上のデータ格納はdataclassを活用しよう](https://qiita.com/ttyszk/items/01934dc42cbd4f6665d2) (最終閲覧日: 2024年8月29日)
- [dataclasses --- Data Classes, Python3.12.5 Documentation](https://docs.python.org/3.12/library/dataclasses.html#module-dataclasses) (最終閲覧日: 2024年8月29日)