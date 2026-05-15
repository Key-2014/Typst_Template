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

// --- Main Template ---
#let project(
  title: "",
  author: "",
  student-id: "",
  date: none,
  indent: false,
  heading-numbering: none,
  heading-supplement: none,
  equation-numbering: none,
  title-page: false,
  toc: false,
  body,
) = {
  // --- Layout & Document Properties ---
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

  set text(
    font: ("New Computer Modern", "Harano Aji Mincho", "New Computer Modern Math"),
    size: 11pt,
    lang: "ja",
  )

  set bibliography(
    title: "参考文献",
    style: "ieee",
  )

  // --- Typography Rules ---
  // Ensure math font consistency
  show math.equation: set text(
    font: ("New Computer Modern Math", "Harano Aji Mincho"),
    size: 11pt,
  )

  // Use horizontal style for inline fractions
  show math.equation.where(block: false): set math.frac(style: "horizontal")

  // --- Heading Configuration ---
  set heading(
    numbering: heading-numbering,
    supplement: heading-supplement,
  )

  // Add vertical spacing and bold math in headings
  show heading: it => {
    show math.equation: math.bold
    v(0.5em)
    it
    v(0.5em)
  }

  // --- Equation Numbering Logic ---
  // Determine actual equation numbering style based on user choice and heading setting
  let actual-eq-numbering = if equation-numbering == "1.1" {
    if heading-numbering != none {
      "1.1"
    } else {
      "1"
    }
  } else {
    equation-numbering
  }

  if actual-eq-numbering == "1.1" {
    // Reset equation counter at every level 1 heading
    show heading.where(level: 1): it => {
      counter(math.equation).update(0)
      it
    }
    set math.equation(
      numbering: (..numbers) => {
        let h = counter(heading).at(here())
        if h.len() > 0 {
          "(" + str(h.at(0)) + "." + numbering("1", ..numbers) + ")"
        } else {
          "(" + numbering("1", ..numbers) + ")"
        }
      },
      supplement: [式],
    )
  } else if actual-eq-numbering != none {
    set math.equation(
      numbering: actual-eq-numbering,
      supplement: [式],
    )
  }

  // --- Tables & Figures ---
  set figure(supplement: [図])
  show figure.where(kind: table): set figure(supplement: [表])
  show figure.where(kind: table): set figure.caption(position: top) //

  // --- Title & Metadata Block ---
  if title-page {
    page(numbering: none, align(center + horizon)[
      #if title != "" [ #text(24pt, weight: "bold")[#title] \ ]
      #v(2em)
      #if student-id != "" [ #text(14pt)[学生番号: #student-id] \ ]
      #if author != "" [ #text(14pt)[氏名: #author] \ ]
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

  // --- Table of Contents ---
  if toc {
    align(center)[#text(16pt, weight: "bold")[目次]]
    v(1em)
    outline(title: none, indent: auto)
    pagebreak()
  }

  // --- Main Content ---
  body
}
