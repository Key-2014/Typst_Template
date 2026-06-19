#import "/lib.typ": *
#show: project.with(
  title: "title",
  author: "",
  student-id: "",
  heading-numbering: none,
  equation-numbering: none,
)



= first<fir>
#lorem(30)

$
  x^2 + y^2 = z^2
$

== first-bash

#lorem(30)
#set math.equation(numbering: (..nums) => "(" + "1." + numbering("1", ..nums) + ")")
#counter(math.equation).update(0)



$
  F = m a
$

= second
#lorem(30)

#set math.equation(numbering: (..nums) => "(" + "6.5." + numbering("1", ..nums) + ")")
//#counter(math.equation).update(0)

$
  L = K + U
$

$
  y - a x^2
$


#figure(
  ```python
  import numpy
  x = y + z
  ```,
  // caption: [Source code description]
) <label>


$
  "あいうえお" \
  "*あいうえお*" \
  #[*あいうえお*] \
  bold("あいうえお") \
  #text("あいうえお", weight: "bold") \
  #[あいうえお]
$
