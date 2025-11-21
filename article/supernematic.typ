#import "@preview/physica:0.9.6": *
#import "@preview/fletcher:0.5.3" as fletcher: diagram, node, edge
#import "@preview/theorion:0.4.1":*
#show: show-theorion
#show link: underline
#import cosmos.clouds: *
#let colred(x) = text(fill: red, $#x$)
#set math.equation(numbering: "(1)")

#import "/typ/templates/blog.typ": *
#show: main.with(
  title: "Supernematic",
  desc: [Studying Dan Mao's paper: https://arxiv.org/abs/2511.10642],
  date: "2025-11-16",
  tags: (blog-tags.physics,),
  license: licenses.cc-by-nc-sa,
)

= Preface
I think the math inside is exciting and the states look like the frustrated hopping ground state that I have learnt from #link("https://journals.aps.org/prl/abstract/10.1103/PhysRevLett.99.070401")[Congjun's papers], where the p-orbital ground state of hubbard model at $1/6$ filling, gives exact solvable Wigner crystal state, with a certain "chirality".

However, I believe Congjun's state never breaks rotational symmetry.


= Questions
Instead of following the paper line by line, I will first list some questions that I have in mind when reading the paper.

1. _Big Question_: Is the rotation symmetry spontaneously broken? If so, what's the order parameter? What's the Goldstone mode?
2. How is "cluster-charge" Hamiltonian motivated from the underlying physics? What are the key physical insights that lead to this Hamiltonian?


