// テンプレートのインポート（親ディレクトリの lib.typ を読み込みます）
#import "../lib.typ": *

// ドキュメントの初期設定
#show: project.with(
  title: "Typst Template 見本ドキュメント",
  author: "Typst 太郎",
  student-id: "12345678",
  date: datetime.today().display(),
  heading-numbering: "1.1", // 章番号を有効化（数式番号も連動します）
  title-page: true, // 独立した表紙を生成
  toc: true, // 目次を生成
)

= はじめに
このファイルは，本テンプレートの各種機能を一目で確認するためのサンプルです．
本テンプレートを使用する際には，この `main.typ` や `refs.bib` を参考にすると楽に書き始められます．

日本語は明朝体（原ノ味明朝）で，英数字は LaTeX に似たフォント（New Computer Modern）に設定されています．もしお気に入りのフォントがあれば `lib.typ` のフォント部分を書き換えて利用してください．

= 数式と物理記法
この見本では `heading-numbering` を設定しているため，数式番号は自動的に「章番号.数式番号」の形式（例: 2.1 など）になります．

$
  sin x = x - x^3/3! + x^5/5! - dots
$

物理学でよく使う微分積分もインポートされている `@preview/physica` パッケージにより簡単に記述できます．

$
  pdv(f, x, y) = pdv(, x) (pdv(f, y))
$

より詳しい説明については typst 公式ドキュメントの各パッケージのベージを参照してください．

= 独自マクロの紹介
`utils.typ` に定義された便利なマクロの出力例です．

== 単位 (Units)
複雑な単位も `u` マクロを使えば `unify` パッケージによって自動で立体（upright）にフォーマットされます．
- 加速度: #u("m/s^2")
- `b: true` をつけると括弧がつきます: #u("kg*m/s", b: true)

== 順列と組合せ
日本の教科書でよく見られる記法（文字の左下に添え字）です．
$ combination(n, k) = n! / (k!(n-k)!) $
$ permutation(n, r) = n! / (n-r)! $
$ hcombination(n, r) = combination(n + r - 1, r) $

== 強調ボックス (Boxes)
最終的な答えを強調したいときは `#ans` ボックスが便利です．分数が入っても自動で高さ（ベースライン）が調整されます．

$ x = #ans($(-b +- sqrt(b^2 - 4a c)) / (2a)$) $

重要な定義や定理などは，中央揃えの枠囲み `#crect` を使用します．

#crect[
  *ニュートンの第二法則* \
  $ m vb(a) = vb(F) $
]

特定の方程式にのみ，通し番号ではなく独自のタグをつける `#eqtag` もあります．

#eqtag($ E = m c^2 $, "*")

何かしらの証明の最後に，Q.E.D を表す記号も実装されています．
#qed

= 参考文献の引用番号について
別ファイルの `refs.bib` のように参考文献を記述しておいた状態で `#bibliography("refs.bib")` のように設定しておけば，自動的に最後のページに参考文献が出力されます．また，次のように各参考文献を引用したときの番号をつけることもできます．
@feynman @einstein1905

= おわりに
このテンプレートをぜひ活用してみてください．

#pagebreak()
#bibliography("refs.bib")
