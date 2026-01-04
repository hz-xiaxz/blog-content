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
  date: "2026-1-3",
  tags: (blog-tags.physics,),
  license: licenses.cc-by-nc-sa,
)
#set text(lang: "en")
#emph-box[
  #align(center)[Happy New Year!]
]

== Why VMC?
This model is in continuum so DMRG as well as other lattice-based methods are not applicable. For hall like problem, which breaks time-reversal symmetry, QMC suffers from the sign problem. Therefore VMC is a natural choice. 

For any reason, Hall is extremmely hard!

== $lambda$-jellium model
#definition(
  title: [$lambda$-jellium model],
)[
  $lambda$-jellium model is a simple two-band generalization of the jellium model,
  $
    hat(H) = Delta sum_(i=1)^N mat(-lambda^2 gradient^2, i lambda partial_i;i lambda overline(partial)_i, 1;delim: "[") - sum_(i=1)^N hat(I)_2 gradient^2_i/(r_s^2) + 2/r_s sum_(i<j)^N 1/(|bold(r)_i - bold(r)_j|)
  $
  where $Delta$ is a large and positive constsant, $ partial = partial_x - i partial_y$
]

==== Fast check of hermicity of $hat(h)$
$
  hat(h) = Delta mat(-lambda^2 gradient^2, i lambda partial_i;i lambda overline(partial)_i, 1;delim: "[")\
$
$
  (i lambda partial_i)^dagger = i lambda overline(partial)_i
$
since $i partial$ is hermitian operator.


=== Construction of $lambda$-jellium
We start from the Dirac hamiltonian and add a mass term to open a gap.

I'm so naive so step by step 
==== Massless dirac dispersion
In $k$-space
$
  hat(h)_0(bold(k)) = Delta mat(0, k_x - i k_y;k_x + i k_y, 0;delim: "[")
$

Diagonalize it
$
  E = plus.minus Delta sqrt(k_x^2 + k_y^2)
$

Making a linear dispersion. 

You could imagine adding a uniform mass term that gaps the dirac point out and creates two separate quadratic bands.

==== Flat band 
#problem[
  Why do they say this flat band has *identical interaction* to plain jellium?
]

answer: because the single particle wavefunction is not changed with jellium kinetic term.

Adding a non-uniform mass term gives
$
  hat(h)_0(bold(k)) = Delta mat(lambda^2 (k_x^2 + k_y^2), lambda (-k_x + i k_y);lambda(-k_x - i k_y), 1;delim: "[")
$

gives
$
  (lambda^2(k_x^2+k_y^2) - E)(1 - E) - lambda^2(k_x^2 + k_y^2) = 0
$
Thus
$
  E = 0 , quad Delta (1+ lambda^2 k^2 )
$
where $k^2 = k_x^2 + k_y^2$

The band gap is tuned by $Delta$, we would focus on the lower flat band and its topology from now on.

The wavefunction is
$
  phi(bold(r)) = 1/sqrt(A) integral dd(q, 2) phi_bold(q) e^(i bold(q) dot bold(r))\
  phi_bold(q) = 1/sqrt(1 + lambda^2 q^2) mat(1;lambda (q_x + i q_y);delim: "[")
$

Adding the jellium term back we have

$
  hat(h) = hat(h)_0 - hat(I)_2 gradient^2/(r_s^2)
$
which gives the same jellium dispersion and same wavefunction.

#remark[
  Take-away lesson: Topology lies in the wavefunction which is kinetical part, not in the dynamical dispersion part.

  This dispersion matching is essential to convince that the wigner crystallization is driven by quantum geometry not kinetical difference.

]

=== Berry phase of this single particle hamiltonian
Would be pretty straightforward for $2times 2$ hamiltonian.
$
  H(bold(k)) = d_0 (bold(k)) hat(I)_2 + bold(d)(bold(k)) dot bold(sigma)
$

In this system
$
  d_0 &= Delta/2 (lambda_s^2 k^2+1)\
  d_x &= - Delta lambda_s k_x\
  d_y &= - Delta lambda_s k_y\
  d_z &= Delta/2 (lambda_s^2 k^2 -1)
$

Thus we have
$
  d(bold(k)) = Delta vec(-lambda_s k_x, - lambda_s k_y, (lambda_s^2 k^2 -1)/2)
$

$
  |d(bold(k))| = Delta/2 (lambda_s^2 k^2 + 1)
$

#theorem[
  For two-band model, the Berry curvature is given by
  $
    Omega(bold(k)) &= -1/2 hat(d) dot (partial_(k_x) hat(d) times partial_(k_y) hat(d))\
    hat(d)         &= bold(d)/(|bold(d)|)
  $
]

$
  (diff hat(d))/(diff k_x) &= Delta/(abs(d)) vec(-lambda_s, 0, lambda_s^2 k_x)\
  (diff hat(d))/(diff k_y) &= Delta/(abs(d)) vec(0, -lambda_s, lambda_s^2 k_y)\
$

Thus
$
  Omega(bold(k)) 
    &= Delta^3/( 2|d|^3) det mat(
    -lambda_s k_x, -lambda_s, 0;-lambda_s k_y, 0, -lambda_s;(lambda_s^2 k^2 -1)/2, lambda_s^2 k_x, lambda_s^2 k_y;delim: "["
  )\
    &= Delta^3/( 2|d|^3) (- lambda_s^4 k_x^2 + lambda_s (-lambda_s^3 k_y^2 + lambda_s/2 (lambda_s^2k^2-1) )) \
    &= Delta^3/(2 |d|^3) (- lambda_s^2) (lambda_s^2 k^2+1)/2 \
    &= 2lambda_s^2/(lambda_s^2 k^2 + 1)^2
$
which peaks at $k=0$ and decays as $1/k^4$ for large $k$.

That's very much the topological details in $lambda$-jellium model.

#problem[But, why would berry curvature concentration drive crystallization?]

#problem[
  I'm also interested in why there is a *Quantum Critical Point*.
]

=== Comparison to Landau level

Landau level has flat berry curvature distribution.
$
  Omega_(LL)(bold(k)) = l_B^2
$

jellium model has a localized berry curvature distribution in $k$ space.

