// Import the template and utilities
#import "../lib_v2.0.0.typ": *

// 1. Initialize global document rules
#show: project.with(
  lang: "ja",
  supplement-lang: "ja",
  heading-numbering: "1.1",
  equation-numbering: "1.1",
)

// 2. Render the cover page
#thesis-cover(
  academic-year: "令和7",
  title: "Typstによる物理学論文用テンプレートの構築と検証",
  affiliation: "理学部 物理学科",
  student-id: "12345678",
  author: "Typst 太郎",
  supervisor: "アインシュタイン 教授",
  date: "2026年3月",
  lang: "ja",
)

// 3. Render the abstract (TOC page numbering "i" starts here)
#thesis-abstract(lang: "ja")[
  本論文では、組版システム「Typst」を用いて、日本語の物理学論文およびレポートを効率的かつ美しく作成するためのテンプレート設計について述べる。
  従来の LaTeX に比べ、Typst は軽量かつ高速にコンパイル可能であり、本テンプレートのコンポーネント指向設計によって、表紙や目次といった構成要素を容易にカスタマイズできるようにした。
]

// 4. Render the table of contents (Resets numbering to "1" after page break)
#thesis-toc(lang: "ja")

// 5. Main Body
= はじめに
本章では、研究の背景および本研究の目的について述べる。

近年、学術論文の執筆において Markdown ライクな軽量マークアップ言語の人気が高まっており、特に Typst @feynman はそのリアルタイムプレビュー機能とシンプルな構文から注目を集めている。

= 物理表記と数式の検証
本章では、本テンプレートにおける数式表現の検証結果を報告する。

== マクスウェル方程式
電磁気学の基本方程式であるマクスウェル方程式は、`physica` パッケージを用いて以下のように簡潔に記述できる。

$
  div vb(E) = rho / epsilon_0
$

$
  curl vb(B) - 1/c^2 pdv(vb(E), t) = mu_0 vb(j)
$

== 独自マクロの利用例
`utils.typ` に定義された組み合わせの数式マクロの出力例である。
$ combination(n, k) = n! / (k!(n-k)!) $

#bibliography("ex-refs.bib")
