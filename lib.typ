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

  // Allow block equations to break across pages
  show math.equation.where(block: true): set block(breakable: true)

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
  // If headings are numbered, equations follow section numbering
  show heading.where(level: 1): it => {
    if equation-numbering == "1.1" and heading-numbering != none {
      counter(math.equation).update(0)
    }
    it
  }

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
    supplement: [式],
  )

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
      align(center)[
        #if student-id != "" [ #student-id ]
        #if student-id != "" and author != "" [ #h(2em) ]
        #if author != "" [ #author ]
        #if (student-id != "" or author != "") and date != none [ \ ]
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
