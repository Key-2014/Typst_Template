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
  radius: 0pt,
  align(left, body)
))

// Full-width rectangle
#let frect(body) = block(
  width: 100%,
  stroke: 1pt,
  inset: 10pt,
  radius: 0pt,
  align(left, body)
)

// Answer box
#let ans(body) = box(
  stroke: 1pt,
  inset: (x: 5pt, y: 5pt),
  outset: (y: 3pt),
  radius: 0pt,
  $#body$
)