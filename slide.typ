// slide.typ

// --- Report/Document Base Packages & Macros ---
#import "@preview/physica:0.9.8": *
#import "@preview/unify:0.8.1": num, qty
#import "@preview/cetz:0.5.2": canvas, draw, matrix, vector
#import "@preview/showybox:2.0.4": showybox
#import "@preview/whalogen:0.3.0": ce
#import "utils.typ": *

// --- Slide/Touying Packages ---
#import "@preview/touying:0.7.4": *
#import themes.university: *
#import "@preview/fletcher:0.5.8" as fletcher
#import fletcher: edge, node
#import "@preview/numbly:0.1.0": numbly
#import "@preview/theorion:0.6.0": *

// --- Specialized Reducers for Slides ---
#let fletcher-diagram = touying-reducer.with(
  reduce: fletcher.diagram,
  cover: fletcher.hide,
)
#let cetz-canvas = touying-reducer.with(
  reduce: canvas,
  cover: draw.hide.with(bounds: true),
)

// --- Language & Caption Mappings ---
// Defines localized labels for figures, tables, equations, and bibliography titles.
#let supplement-labels = (
  ja: (
    fig: "図",
    tab: "表",
    eq: "式",
    citation: "参考文献",
  ),
  en: (
    fig: "Fig.",
    tab: "Table",
    eq: "Eq.",
    citation: "References",
  ),
  en-full: (
    fig: "Figure",
    tab: "Table",
    eq: "Equation",
    citation: "References",
  ),
)

// --- Main Template Setup ---
#let slides(
  lang: "ja",
  supplement-lang: "ja",
  title: [],
  subtitle: [],
  author: [],
  date: none,
  institution: [],
  logo: none,
  aspect-ratio: "16-9",
  handout: false,
  font-size: 19pt,
  footer-a: [],
  footer-b: [],
  footer-c: self => {
    h(1fr)
    context utils.slide-counter.display() + "/" + utils.last-slide-number
    h(1fr)
  },
  body,
) = {
  // Select labels dynamically based on the language
  let labels = supplement-labels.at(supplement-lang, default: supplement-labels.ja)

  // Configure fallback fonts depending on the language
  let font-family = if lang == "ja" {
    ("New Computer Modern", "Harano Aji Gothic", "New Computer Modern Math")
  } else {
    ("New Computer Modern", "New Computer Modern Math")
  }

  let math-font-family = if lang == "ja" {
    ("New Computer Modern Math", "New Computer Modern", "Harano Aji Gothic")
  } else {
    ("New Computer Modern Math", "New Computer Modern")
  }

  // Configure theorion theorems/environments
  show: show-theorion

  // Configure the university theme of Touying
  show: university-theme.with(
    aspect-ratio: aspect-ratio,
    config-common(
      handout: handout,
      frozen-counters: (theorem-counter,),
    ),
    config-info(
      title: title,
      subtitle: subtitle,
      author: author,
      date: date,
      institution: institution,
      logo: logo,
    ),
    config-store(
      footer-a: footer-a,
      footer-b: footer-b,
      footer-c: footer-c,
    ),
  )

  // Configure Japanese Gothic fonts for slides explicitly
  set text(
    font: font-family,
    size: font-size,
    lang: lang,
  )

  // Follow math font of original template
  show math.equation: set text(
    font: math-font-family,
    size: font-size,
  )

  // Use horizontal style for inline fractions
  show math.equation.where(block: false): set math.frac(style: "horizontal")

  // Allow block equations to break across pages
  show math.equation.where(block: true): set block(breakable: true)

  set math.equation(
    supplement: labels.eq,
  )

  // --- Tables & Figures ---
  set figure(supplement: labels.fig)
  show figure.where(kind: table): set figure(supplement: labels.tab)
  show figure.where(kind: table): set figure.caption(position: top)

  body
}
