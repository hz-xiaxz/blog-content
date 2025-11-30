#import "/typ/templates/blog.typ": *
#import "@preview/physica:0.9.6": *
#import "@preview/theorion:0.4.1":*
#set heading(numbering: "1.1")
#show: show-theorion
#show link: underline
#import cosmos.clouds: *
#let colred(x) = text(fill: red, $#x$)
#set math.equation(numbering: "(1)")

#show: main.with(title: "1D tV model", desc: [], date: "2025-11-30", tags: (blog-tags.physics,), license: licenses.cc-by-nc-sa)

#set text(lang: "en")
= Jordan Wigner transformation
#definition(title: "Jordan Wigner Transformation")[
  $
    c_j                  &= (product_(k<j) -sigma_k^z) 1/2 sigma_j^-\
    c_j^dagger           &= (product_(k<j) -sigma_k^z) 1/2 sigma_j^+\
    n_j = c_j^dagger c_j &= 1/2 (sigma_j^z + 1)\
  $
]
tV model can be viewed as an equivalent XXZ model.

#definition(title: "tV model")[
  $ H = -t sum_j (c_j^dagger c_(j+1) + h.c.) + V sum_j n_j n_(j+1) $
]

== Hopping term
$
  c_j^dagger c_(j+1) 
    &= (product_(k<j) -sigma_k^z) 1/2 sigma_j^+ (product_(l<j+1) -sigma_l^z) 1/2 sigma_(j+1)^- \
    &= -1/4 sigma_j^+ sigma_j^z sigma_(j+1)^-\
    &= 1/4 sigma_j^+ sigma_(j+1)^- \
$

== Interaction term
$
  n_j n_(j+1) 
    &= 1/4 (sigma_j^z + 1)(sigma_(j+1)^z + 1) \
    &= 1/4 (sigma_j^z sigma_(j+1)^z + sigma_j^z + sigma_(j+1)^z + 1) \
$
perform summation
$
  sum_j n_j n_(j+1) 
    &= 1/4 (sum_j sigma_j^z sigma_(j+1)^z + 2 sum_j sigma_j^z + L) \
$

#definition[
  let $ S_j^alpha = 1/2 sigma_j^alpha $
]

Thus the mapped system becomes
$ 
  H 
  &= -t sum_j (S_j^+ S_(j+1)^- + S_j^- S_(j+1)^+) + V sum_j S_j^z S_(j+1)^z + V sum_j S_j^z\
  &= -2t sum_j (S_j^x S_(j+1)^x + S_j^y S_(j+1)^y) + V sum_j S_j^z S_(j+1)^z + V sum_j S_j^z 
$

which is typically a XXZ model with magnetic field in z direction.

