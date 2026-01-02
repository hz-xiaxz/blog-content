#import "@preview/physica:0.9.6": *
#import "@preview/theorion:0.4.1":*
#show: show-theorion
#show link: underline
#import cosmos.clouds: *
#let colred(x) = text(fill: red, $#x$)
#set math.equation(numbering: "(1)")

#import "/typ/templates/blog.typ": *
#show: main.with(
  title: "Quantum Geometry Driven Crystallization",
  desc: [Reading 2512.07947v1],
  date: "2026-1-1",
  tags: (blog-tags.physics,),
  license: licenses.cc-by-nc-sa,
)

#emph-box[
  Happy New Year!
]

== Why VMC?
This model is in continuum so DMRG as well as other lattice-based methods are not applicable. For hall like problem, which breaks time-reversal symmetry, QMC suffers from the sign problem. Therefore VMC is a natural choice. 

For any reason, Hall is extremmely hard!

