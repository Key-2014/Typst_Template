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

// --- Main Template Setup ---
#let slides(
  title: [],
  subtitle: none,
  author: [],
  date: none,
  logo: none,
  aspect-ratio: "16-9",
  handout: false,
  font-size: 20pt,
  font-family: ("New Computer Modern", "Harano Aji Gothic", "New Computer Modern Math"),
  math-font-family: "New Computer Modern Math",
  footer-a: [],
  footer-b: [],
  footer-c: self => {
    h(1fr)
    context utils.slide-counter.display() + "/" + utils.last-slide-number
    h(1fr)
  },
  body,
) = {
  // Configure Japanese Gothic fonts for slides explicitly
  set text(
    font: font-family,
    size: font-size,
  )
  
  // Follow math font of original template
  show math.equation: set text(font: math-font-family)

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
      logo: logo,
    ),
    config-store(
      footer-a: footer-a,
      footer-b: footer-b,
      footer-c: footer-c,
    ),
  )

  body
}
