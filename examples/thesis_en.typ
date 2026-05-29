// Import the template and utilities
#import "../lib_v2.0.0.typ": *

// 1. Initialize global document rules (Configured for English)
#show: project.with(
  lang: "en",
  supplement-lang: "en",
  heading-numbering: "1.1",
  equation-numbering: "1.1",
)

// 2. Render the cover page (English)
#thesis-cover(
  academic-year: "2025",
  title: "Development of a Typst Template for Physics Papers",
  affiliation: "Department of Physics",
  student-id: "12345678",
  author: "Taro Typst",
  supervisor: "Professor Albert Einstein",
  date: "March 2026",
  lang: "en",
)

// 3. Render the abstract (English)
#thesis-abstract(lang: "en")[
  This paper describes the design and implementation of a document template for typesetting physics papers and laboratory reports using the Typst typesetting system. By leveraging Typst's modern styling features, we propose a component-oriented architecture that separates document-wide rules from specific page layouts such as cover sheets and tables of contents.
]

// 4. Render the table of contents (English)
#thesis-toc(lang: "en")

// 5. Main Body
= Introduction
In scientific publishing, typesetting tools play a crucial role in presenting complex mathematical expressions. Historically, LaTeX has been the de facto standard. However, Typst @feynman has emerged as a promising alternative, providing fast compilation and human-friendly syntax.

= Methodology
We formulate the physical properties using block equations.

== Equation of Motion
The fundamental equation of motion in a potential field $V(r)$ is given by the Schrödinger equation:

$
  i hbar pdv(psi, t) = [ - hbar^2 / (2m) laplacian + V(r) ] psi
$

== Math Macros Demo
Here we show the permutation macro defined in `utils.typ`:
$ permutation(n, r) = n! / (n-r)! $

And using the unit formatter macro:
- Velocity: #u("m/s")
- Momentum unit with brackets: #u("kg*m/s", b: true)

#bibliography("ex-refs.bib")
