#import "../lib.typ": *
#show: project.with(
  title: "title",
  author: "",
  student-id: "",
  date: auto,
)



#set math.equation(numbering: n => "(6.5." + str(n) + ")", supplement: [式])
#counter(math.equation).update(0) // The next equation will be number 0 + 1

#set math.equation(numbering: "(1)", number-align: bottom, supplement: [式])

#set math.equation(numbering: none)

#set math.equation(
  numbering: (..nums) => "(1.1." + numbering("1", ..nums) + ")",
  number-align: bottom,
  supplement: [式],
)
// #counter(math.equation).update(0)
