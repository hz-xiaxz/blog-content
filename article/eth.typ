#import "/typ/templates/blog.typ": *
#import "@preview/physica:0.9.6": *
#import "@preview/theorion:0.4.1":*
#show: show-theorion
#show link: underline
#import cosmos.clouds: *
#let colred(x) = text(fill: red, $#x$)
#set math.equation(numbering: "(1)")

#show: main.with(
  title: "Eigenstate thermalization hypothesis",
  desc: [],
  date: "2025-11-30",
  tags: (blog-tags.physics,),
  license: licenses.cc-by-nc-sa,
)

#set text(lang: "en")
= ETH FETH & FP

== Statistics
equilibrium: find const and do Gibbs Statistics

#problem[How to formulate non-equilibrium Statistics in a closed system without external bath?]

Aside from the non-equilibrium case, quantum case is subtle enough.

In a quantum phase space, there is no real notion of trajectory. 

We would talk about closed system, however without external bath, how can we define equilibrium? 

=== Quantum Quench System
$ H_0 ket(psi_0) = 0 , H_0->H(t)$
$ ket(psi(t)) = exp(-i H t) ket(psi_0) $
#problem[For $t->oo$, can this be equivalent to Gibbs ensemble?]

such that 
$ E=mel(psi, H, psi) = 1/Z tr(exp(-beta H) H) $
where $beta=beta(E)$ is function of $E$

#remark[Rabi oscillation without bath coupling would not thermalize. ]

this can only holds for local observables $O$, since the whole system is pure. it can only be locally viewed as a thermal ensemble.

#remark[The large fraction of pure state could serve as the bath for small subsystem.]

#remark[eigen state should be always thermalized.]

=== Expectation value
We assume no accidental degeneracy.
$
  expval(A(t)) = sum_i abs(c_i)^2 A_(i i) + sum_(i eq.not j) c_i^* c_j exp(i(E_i - E_j)t) A_(i j)
$

we hope $ lim_(t -> oo) expval(A(t))_(beta "E") = expval(A)_("ME") $ for local observables.

$
  [A]_(oo) = lim_(T -> oo) 1/T integral_0^T dd(t) expval(A(t)) = sum_i abs(c_i)^2 A_(i i)
$

==== Random Matrix Theory (RMT)
===== Wigner Matrix

$ rho(H) = product_(i j) f(H_(i i)) g(H_(i j)) $

This is not rotational invariant.
===== Rotation invariance
$ rho(H) = rho(U^dagger H U) $
where $U$ is any unitary matrix.

===== Intersection of above two 
$ rho(H)= exp(-1/2 tr H^2) $
Can check this is both WM and RI.

Interestingly, 
$
  rho(H) = exp(-beta tr H)
$
is also both WM and RI.
===== Haar Random
$
  expval(U_(i alpha) U^dagger_(alpha' i')) = 1/D delta_(i i') delta_(alpha alpha')
$

I'm too lazy to type higher moments.

=== Back to Expectation value
If $H$ is RMT, we can average $A_(i i)$ in the random matrix ensemble.
$ expval(A_(i i)) = sum_alpha A_alpha/D$, where $A$ is diagonalized in $A=sum_alpha A_alpha ket(alpha) bra(alpha)$

Thus $expval(A_(i i))$ is independent of $i$.
$
  [A]_(oo) = sum_i abs(c_i)^2 A_(i i) = sum_alpha A_alpha/D = expval(A)_("ME")
$

This is too strong, since the thermal state *forgets* all information from the initial state.


== ETH
#let Aii = $A_(i i)$
#definition[
  $ expval(A_(i i))= A(E_i), expval(Aii^2) = A^2(E_i)\
  expval(|A_(i j)|^2) = e^(-S(E^+)) |f_A (E^+, omega)|^2 $
  where $E^+ = (E_i + E_j)/2, omega = E_i - E_j$, $f_A$ is smooth function of $E^+, omega$, and $e^(S(E^+))$ is somehow the dimension of local Hilbert space at energy $E^+$.
]

Now that,
$
  expval(A(t)) = sum_i abs(c_i)^2 A(E_i) + cal(O)(D^(-1/2))
$


== Full ETH (FETH)

== Free Probability (FP)


