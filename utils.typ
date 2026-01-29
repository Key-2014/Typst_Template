// utils.typ

// --- Utils ---
#let bk = h(1em)
#let qed = h(1fr) + $qed$
#let rhs = [(右辺)]
#let lhs = [(左辺)]

// --- Math Notations ---
#let combination(n, r) = math.attach(math.upright("C"), bl: n, br: r)
#let permutation(n, r) = math.attach(math.upright("P"), bl: n, br: r)

// --- Boxes ---
// Centered rectangle
#let crect(body) = align(center, block(
  stroke: 1pt,
  inset: 10pt,
  radius: 4pt,
  align(left, body)
))

// Full-width rectangle
#let frect(body) = block(
  width: 100%,
  stroke: 1pt,
  inset: 10pt,
  radius: 4pt,
  align(left, body)
)

// Answer box
#let ans(body) = box(
  stroke: 1pt,
  inset: (x: 5pt, y: 5pt),
  outset: (y: 3pt),
  radius: 2pt,
  $#body$
)

// unit
#let u(unit, b: false) = {
  // 1. Construct the unit part (body)
  let body = if type(unit) == str {
    if unit.contains("^") {
      let parts = unit.split("^")
      let base = parts.at(0)
      let exponent = parts.at(1)
      // Combine as a string and render in math mode with upright style
      $upright(#base)^#exponent$
    } else {
      $upright(#unit)$
    }
  } else {
    // Apply upright style if the input is content (e.g., $mu$)
    $upright(#unit)$
  }

  // 2. Handle brackets [ ]
  let content = if b { $[#body]$ } else { body }

  // 3. Output with a thin space (1/6 em)
  $#h(0.16667em) #content$
}

// Manually tag a specific equation without affecting the global equation counter
#let eqtag(content, tag) = {
  math.equation(content, block: true, numbering: _ => "(" + tag + ")")
}