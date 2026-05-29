// lib.typ

// --- Packages ---
#import "@preview/physica:0.9.8": *
#import "@preview/unify:0.8.0": num, qty
#import "@preview/cetz:0.5.2": canvas, draw, matrix, vector
#import "@preview/showybox:2.0.4": showybox
#import "@preview/whalogen:0.3.0": ce
// #import "@preview/lilaq:0.5.0" as lq

// --- User-defined Macros ---
#import "utils.typ": *

// --- Language & Caption Mappings ---
// Defines localized labels for figures, tables, equations, and bibliography titles.
#let supplement-labels = (
  ja: (
    fig: "図",
    tab: "表",
    eq: "式",
    citation: "参考文献"
  ),
  en: (
    fig: "Fig.",
    tab: "Table",
    eq: "Eq.",
    citation: "References"
  ),
  en-full: (
    fig: "Figure",
    tab: "Table",
    eq: "Equation",
    citation: "References"
  ),
)

// --- Main Template Setup---
// Configures global document rules such as margins, fonts, paragraphs, and heading spacing.
#let project(
  lang: "ja",
  supplement-lang: "ja",
  heading-numbering: none,
  equation-numbering: none,
  indent: false,
  body,
) = {
  // Select labels dynamically based on the language
  let labels = supplement-labels.at(supplement-lang, default: supplement-labels.ja)

  // --- Page & Document Properties ---
  set page(
    paper: "a4",
    margin: (x: 25mm, y: 30mm),
    numbering: "1",
  )

  set par(
    justify: true,
    first-line-indent: (
      amount: if indent { 1em } else { 0em },
      all: indent,
    ),
    leading: 0.8em,
  )

  // Configure fallback fonts depending on the language
  let font-family = if lang == "ja" {
    ("New Computer Modern", "Harano Aji Mincho", "New Computer Modern Math")
  } else {
    ("New Computer Modern", "New Computer Modern Math")
  }

  let math-font-family = if lang == "ja" {
    ("New Computer Modern Math", "New Computer Modern", "Harano Aji Mincho")
  } else {
    ("New Computer Modern Math", "New Computer Modern")
  }

  set text(
    font: font-family,
    size: 11pt,
    lang: lang,
  )

  // --- Bibliography Configuration ---
  set bibliography(
    title: labels.citation,
    style: "ieee",
  )

  // --- Typography Rules for Math---
  show math.equation: set text(
    font: math-font-family,
    size: 11pt,
  )

  // Use horizontal style for inline fractions
  show math.equation.where(block: false): set math.frac(style: "horizontal")

  // Allow block equations to break across pages
  show math.equation.where(block: true): set block(breakable: true)

  // --- Heading Configuration ---
  set heading(
    numbering: heading-numbering,
  )

  // Add vertical spacing and bold math in headings
  show heading: it => {
    show math.equation: math.bold
    v(0.5em)
    it
    v(0.5em)
  }

  // --- Equation Numbering Logic ---
  // Reset equation counter at level-1 headings if equation-numbering is "1.1"
  show heading.where(level: 1): it => {
    if equation-numbering == "1.1" and heading-numbering != none {
      counter(math.equation).update(0)
    }
    it
  }

  // Format equation numbers (e.g., "(1)" or "(1.1)")
  let target-numbering = if equation-numbering == "1" {
    "(1)"
  } else if equation-numbering == "1.1" {
    (..nums) => {
      let h = counter(heading).at(here())
      if h.len() > 0 and h.at(0) != 0 and heading-numbering != none {
        "(" + str(h.at(0)) + "." + numbering("1", ..nums) + ")"
      } else {
        "(" + numbering("1", ..nums) + ")"
      }
    }
  } else {
    equation-numbering
  }

  set math.equation(
    numbering: target-numbering,
    supplement: labels.eq,
  )

  // --- Tables & Figures ---
  set figure(supplement: labels.fig)
  show figure.where(kind: table): set figure(supplement: labels.tab)
  show figure.where(kind: table): set figure.caption(position: top)

  // --- Main Content ---
  body
}

#let cover(
  title: "",
  affiliation: "", // 所属（大学・学部・学科など）
  supervisor: "",  // 指導教員
  student-id: "",
  author: "",
  date: none,
  title-page: false,
) = {
  // このページだけページ番号を非表示にする設定
  set page(numbering: none)
  
  // --- Title & Metadata Block ---
  if title-page {
      page(numbering: none, align(center + horizon)[
        #if title != "" [ #text(24pt, weight: "bold")[#title] \ ]
        #v(2em)
        #if affiliation != "" [#text(14pt)[所属： #affiliation] \ ]
        #if student-id != "" [ #text(14pt)[学生番号: #student-id] \ ]
        #if author != "" [ #text(14pt)[氏名: #author] \ ]
        #if supervisor != "" [#text(14pt)[指導教員： #supervisor] \ ]
        #if date != none [ \ #text(12pt)[#date] ]
      ])
      // Reset page counter after title page
      counter(page).update(1)
  } else {
    if title != "" {
      align(center, text(17pt, weight: "bold")[#title])
      v(1em)
    }
      if author != "" or student-id != "" or date != none {
      align(right)[
        #if student-id != "" [学生番号: #student-id \ ]
        #if author != "" [氏名: #author \ ]
        #if date != none [#date]
      ]
      v(2em)
    }
  }
}

#let thesis-toc() = {
  set page(numbering: "i")
  counter(page).update(1)

  align(center)[#text(16pt, weight: "bold")[目次]]
  v(1em)
  outline(title: none, indent: auto)

  pagebreak()
}