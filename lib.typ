// lib.typ

// --- Packages ---
#import "@preview/physica:0.9.7": *
#import "@preview/unify:0.7.1": num, qty
#import "@preview/cetz:0.4.2": canvas, draw, vector, matrix
#import "@preview/showybox:2.0.4": showybox
#import "@preview/whalogen:0.3.0": ce

// --- User-defined Macros ---
#import "utils.typ": *

// --- Main Template ---
#let project(
  title: "",
  author: "",
  student-id: "",
  date: none,
  textbook-numbering: false,
  indent: true,
  heading-numbering: none,
  heading-supplement: none,
  body
) = {
  // --- Layout & Document Properties ---
  set page(
    paper: "us-letter",
    numbering: "1",
  )
  
  set par(
    justify: true,
    first-line-indent: (
      amount: if indent { 1em } else { 0em },
      all: indent
    ),
    leading: 0.8em,
  )

  set text(
    font: ("Harano Aji Mincho", "New Computer Modern Math"),
    size: 11pt,
    lang: "ja"
  )

  // --- Typography Rules ---
  // Ensure math font consistency
  show math.equation: set text(
    font: ("New Computer Modern Math", "Harano Aji Mincho"),
    size: 11pt
  )
  
  // Use horizontal style for inline fractions
  show math.equation.where(block: false): set math.frac(style: "horizontal")

  // --- Heading Configuration ---
  set heading(
    numbering: heading-numbering,
    supplement: heading-supplement
  )

  // Add vertical spacing around headings
  show heading: it => {
    v(0.5em)
    it
    v(0.5em)
  }

  // --- Equation Numbering Logic ---
  // If headings are numbered, equations follow section numbering (e.g., 1.1.1)
  if heading-numbering != none {
    set math.equation(
      numbering: (..nums) => {
        let h-counter = counter(heading).get()
        if h-counter.len() > 0 {
          "(" + h-counter.map(str).join(".") + "." + numbering("1", ..nums) + ")"
        } else {
          "(" + numbering("1", ..nums) + ")"
        }
      },
      supplement: [式]
    )
  } else {
    // Standard sequence (1)
    set math.equation(numbering: "(1)", supplement: [式])
  }
  
  // --- Tables & Figures ---
  set figure(supplement: [図])
  show figure.where(kind: table): set figure(supplement: [表])
  show figure.where(kind: table): set figure.caption(position: top) //

  // --- Title & Metadata Block ---
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

  // --- Main Content ---
  body
}