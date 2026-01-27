// lib.typ

// 1. パッケージの一括インポート
#import "@preview/physica:0.9.7": *
#import "@preview/unify:0.7.1": num, qty
#import "@preview/cetz:0.4.2"
#import "@preview/showybox:2.0.4": showybox
#import "@preview/whalogen:0.3.0": ce

// 2. 自作マクロの読み込み
#import "utils.typ": *

// 3. プロジェクトの基本テンプレート関数
#let project(
  title: "",
  // デフォルトであなたの情報を設定
  author: [
    学生番号: 23311420 \
    氏名: 大沼 景
  ],
  date: none,
  textbook-numbering: false, // 教科書風の数式番号にするかどうかのフラグ
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

  // Equation Numbering Logic
  if textbook-numbering {
     set math.equation(numbering: (..nums) => "(6.5." + numbering("1", ..nums) + ")", supplement: [式])
  } else {
     set math.equation(numbering: "(1)", supplement: [式])
  }
  
  // Heading Numbering
  set heading(numbering: "1.1.1.")

  // --- Figure Settings ---
  show figure.where(kind: table): set figure.caption(position: top)

  // --- Title & Author Block ---
  // タイトル部分の描画（typ-title, typ-nameの内容）
  if title != "" {
    align(center, text(17pt, weight: "bold")[#title])
    v(1em)
  }
  
  if author != none {
    align(right, author)
    v(2em)
  }

  // 本文の描画
  body
}