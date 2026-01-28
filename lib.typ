// lib.typ

// 1. パッケージの一括インポート
#import "@preview/physica:0.9.8": *
#import "@preview/unify:0.7.1": num, qty
#import "@preview/cetz:0.4.2"
#import "@preview/showybox:2.0.4": showybox
#import "@preview/whalogen:0.3.0": ce

// 2. 自作マクロの読み込み
#import "utils.typ": *

// 3. プロジェクトの基本テンプレート関数
#let project(
  title: "",
  author: "",      // 名前（文字列またはContent）
  student-id: "",  // 学生番号（文字列）
  body
) = {
  // --- Page & Text Settings ---
  set page(
    paper: "us-letter",
    numbering: "1",
  )
  
  set par(
    justify: true,
    first-line-indent: 1em,
    leading: 0.8em
  )

  set text(
    font: ("Harano Aji Mincho", "New Computer Modern Math"),
    size: 11pt,
    lang: "ja"
  )

  // --- Math Settings ---
  show math.equation: set text(
    font: ("New Computer Modern Math", "Harano Aji Mincho"),
    size: 11pt
  )
  
  // Inline fractions horizontal
  show math.equation.where(block: false): set math.frac(style: "horizontal")

  // --- Figure Settings ---
  show figure.where(kind: table): set figure.caption(position: top)

  // --- Title & Author Block ---
  
  // タイトルの描画
  if title != "" {
    align(center, text(17pt, weight: "bold")[#title])
    v(1em)
  }
  
  // 氏名・学生番号の描画
  // どちらか一方でも入力があればブロックを表示
  if author != "" or student-id != "" {
    align(right)[
      #if student-id != "" {
        [学生番号: #student-id \ ]
      }
      #if author != "" {
        [氏名: #author]
      }
    ]
    v(2em)
  }

  // 本文の描画
  body
}