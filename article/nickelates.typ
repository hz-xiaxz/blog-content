#import "/typ/templates/blog.typ": *
#import "@preview/physica:0.9.6": *
#import "@preview/theorion:0.4.1":*
#set heading(numbering: "1.1")
#show: show-theorion
#show link: underline
#import cosmos.clouds: *
#let colred(x) = text(fill: red, $#x$)
#set math.equation(numbering: "(1)")

#show: main.with(title: "Nickelates", desc: [], date: "2026-03-09", tags: (blog-tags.physics,), license: licenses.cc-by-nc-sa)

= Questions
- What is infinite-layer nickelate? 
#emph-box[
  Finite vs. Infinite Stacking:

  In many other superconducting crystals, you will find a finite number of these planes (usually 1, 2, or 3 layers) sandwiched between thick, complex "blocking layers" made of other atoms (like heavy layers of bismuth, strontium, and oxygen). For example, a crystal might have two conducting layers, a thick non-conducting blocking layer, two more conducting layers, and so on.

  However, in the RNiO₂ structure, there are no thick blocking layers. The structure is remarkably simple and uninterrupted.

  Because these active NiO₂ sheets stack continuously and uniformly along the vertical axis of the crystal without ever being interrupted by a complex insulating block, scientists refer to it as an "infinite layer" structure
]

- Why Hund coupling?

== RP phase
$
  "Ln"_(n+1) "Ni"_(n) O_(3n+1)
$

== Unconventional Magnetism
$(pi/2, pi/2)$ density wave order.

Could be a double stripe phase, or a $(pi,pi)$ charge order with a $(pi/2, pi/2)$ spin order, that makes intermediate total spin completely zero.

However, STM is not applicable to high pressure nickelates, so we don't have direct evidence of the charge order.

But, they are dealing with ambient pressure nickelates, so they can do STM, why not? 

Well, there might not be much meaning in doing so.

== 1D kondo ferromagnets
Even with antiferromagnetic kondo coupling.

Rigourously under $T=0$ (MW theorem prohibits any $T>0$ long-range order in 1D)

== DMRG reliablity?
Is DMRG still reliable for this cylinder stripe order?

