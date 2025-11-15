#import "/typ/templates/blog.typ": *
#show: main.with(
  title: "SCFQFT",
  desc: [Self-Consistent Quantum Field Theory notes. Ref Haussmann 2003. Thanks Jiaxin and Yutai for discussion and guidance.],
  date: "2025-04-14",
  tags: (blog-tags.physics,),
  license: licenses.cc-by-nc-sa,
)

#import "@preview/physica:0.9.6": *
#import "@preview/fletcher:0.5.3" as fletcher: diagram, node, edge
#import "@preview/theorion:0.4.1": *
#set text(lang: "en")
#let colred(x) = text(fill: red, $#x$)
#set math.equation(numbering: "(1)")

#let feynman(body) = math.cancel(angle: 15deg, body)
// #show: note_page.with(title, author, professor, creater, time, abstract)

= SCF equations

Anomalous Green's function

$
  (G_(sigma_1 sigma_2)^(alpha_1 alpha_2)) = mat(
    delta_(sigma_1 sigma_2) G(bold(r),tau), epsilon_(sigma_1 sigma_2) F(bold(r),tau);-epsilon_(sigma_1 sigma_2) F^(*)(-bold(r),tau), -delta_(sigma_1 sigma_2) G(bold(-r), -tau);
  )
$

The spin index $sigma_1, sigma_2$ can be omitted, since the $2times 2$ spin sector can be always block diagonalized.

$
  (G_(alpha_1 alpha_2)(bold(r), tau)) = mat(G(bold(r),tau), F(bold(r),tau);F^(*)(-bold(r),tau), -G(bold(-r), -tau);)
$ <Green-function>

Dyson equation

$
  G^(-1)_(alpha_1 alpha_2)(bold(k),omega_n) = -i hbar omega_n delta_(alpha_1 alpha_2) + (epsilon_(bold(k))-mu) gamma_(alpha_1 alpha_2) - Sigma_(alpha_1 alpha_2)(bold(k), omega_n)
$ <Dyson>

where $ (gamma_(alpha_1 alpha_2)) = mat(1, 0;0, -1) $

With ladder approximation, the self energy equation is
$
  Sigma_(alpha_1 alpha_2)(bold(r),tau) = Sigma_(alpha_1 alpha_2)^1 delta(bold(r)) hbar delta(tau) + G_(alpha_2 alpha_1) (-bold(r), -tau) Gamma_(alpha_1 alpha_2) (bold(r),tau)
$ <self-energy>

Do Fourier
$
    &Sigma_(alpha_1 alpha_2)(bold(k), omega_n) = \
    &integral dd(bold(r), 3) dd(tau) exp(-i bold(k) bold(r) +i omega_n tau) (Sigma^(1)_(alpha_1 alpha_2) delta(bold(r)) delta(tau) + G_(alpha_2 alpha_1)(-bold(r),-tau) Gamma_(alpha_1 alpha_2)(bold(r),tau))\
    &= Sigma^1_(alpha_1 alpha_2) + \
    &integral dd(bold(r), 3) dd(tau) exp(-i bold(k) bold(r) +i omega_n tau) integral dd(bold(k)_1, 3) / ((2pi)^3) 1 / beta sum_(omega^1_n) exp(i bold(k)_1 bold(r) -i omega^1_n tau) G_(alpha_2 alpha_1)(bold(k)_1,omega^1_n)\
    & integral dd(bold(k)_2, 3) / ((2pi)^3) 1 / beta sum_(omega^2_n) exp(i bold(k)_2 bold(r) -i omega^2_n tau) Gamma_(alpha_1 alpha_2)(bold(k)_2, omega^2_n)\
    & = Sigma^1_(alpha_1 alpha_2) + \
    & integral (dd(bold(k)_1, 3) dd(bold(k)_2, 3)) / ((2pi)^6) 1 / beta^2 sum_(omega^1_n, omega^2_n) delta(bold(k) - bold(k)_1 - bold(k)_2) delta(omega_n - omega^1_n - omega^2_n) G_(alpha_2 alpha_1)(bold(k)_1,omega^1_n) Gamma_(alpha_1 alpha_2)(bold(k)_2, omega^2_n)\
    & = Sigma^1_(alpha_1 alpha_2) + integral (dd(bold(k)_1, 3)) / ((2pi)^3) 1 / beta sum_(omega^1_n) G_(alpha_2 alpha_1)(bold(k)_1,omega^1_n) Gamma_(alpha_1 alpha_2)(bold(k)-bold(k)_1,omega_n-omega^1_n)
$

where
$
  Sigma_(alpha_1 alpha_2)^1(bold(k), omega_n) = mat(0, V F(bold(r)=0,tau=0);V F^(*)(bold(r)=0,tau=0), 0)
$

The non-diagonal part is actually the order parameter in standard BCS. This may be our starting point?

$
  Sigma_(alpha_1 alpha_2)^1 = mat(0, Delta;Delta^*, 0)
$

The Bethe-Salpeter equation
$
  Gamma_(alpha_1 alpha_2)^(-1)(bold(K),Omega_n) = T^(-1)delta_(alpha_1 alpha_2) + M_(alpha_1 alpha_2)(bold(K),Omega_n)
$ <Bethe-Salpeter>
where
$
    &M_(alpha_1 alpha_2)(bold(K),Omega_n) = \
    &integral dd(k, [d]) / (2pi)^d [1 / beta sum_(omega_n) G_(alpha_1 alpha_2)(1 / 2 bold(K)-bold(k),Omega_n-omega_n)G_(alpha_1 alpha_2)(1 / 2 bold(K)+bold(k),omega_n)-m / (hbar^2 k^2) delta_(alpha_1 alpha_2)]
$ <pair-propagator-K>
is the regularized pair propagator. Note here the $bold(K)$ is the total momentum of the pair, and $Omega_n$ is the #strong[Bosonic] Matsubara
frequency, $Omega_n = (2pi n)/(beta hbar)$ corresponding to the total energy of the pair.

Denote $bold(K) = (K sin Theta cos Phi, K sin Theta sin Phi, K cos Theta)$, $bold(k) = (k sin theta cos phi, k sin theta sin phi, k cos theta)$,
then
$
  abs(bold(K)/2 plus.minus bold(k)) &= sqrt(1/4 K^2 + k^2 plus.minus bold(K) dot bold(k))\
                                    &= sqrt(1/4 K^2 + k^2 plus.minus K k (sin Theta sin theta cos(Phi-phi) + cos Theta cos theta))
$

Decompose @pair-propagator-K into spherical coordinates, we get
$
  M_(alpha_1 alpha_2) (bold(K),Omega_n) = \
  integral_0^Lambda k^2 dd(k) / (2 pi)^3 integral_(0)^pi sin theta dd(theta) integral_(0)^(2pi) dd(phi) [...]
$
In numerics we need to substitute all $dd(k), dd(theta), dd(phi)$ into $Delta k, Delta theta, Delta phi$

#remark[
  $Omega_n-omega_m = (pi)/(beta hbar) (2n - (2m+1))$ could be $<0$. I would choose to calculate it manually instead of
  reading from the pre-computed Green function mesh.
]

in real Space
$
  M_(alpha_1 alpha_2)(bold(r),tau) = [G_(alpha_1 alpha_2)(bold(r),tau)]^(2) - c delta_(alpha_1 alpha_2) delta(bold(r)) hbar delta(tau)
$ <pair-propagator>
where $c$ is defined as a constant with ultraviolet momentum cutoff $Lambda -> infinity$.
$
  c       &= Omega_d / (2pi)^d m / hbar^2 Lambda^(d-2) / (d-2)\
  Omega_d &= (2pi^(d / 2)) / Gamma(d/2)
$
$c$ goes to infinity when $d>2, Lambda -> infinity$.

#remark[
  This UV divergence only occur in continuous system. In lattice model, the momentum cutoff is naturally chosen as $Lambda=(2pi)/a$

  If we want to compare with results on the Tianyuan Quantum Simulator, what is the suitable model to use?
]

Arguably I think continuous model might be better, since the spacing of cold atoms are not as uniform as in the real
material.

== necessary explanation for SCF equations

The Bethe-Salpeter @Bethe-Salpeter is introduced since we need to describe the two particle correlations.
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  align(center)[#math.equation(numbering: none)[$ G^(2)_(X X' Y Y')= $]],
  [#diagram($
      X                    & Y\
      X' edge("u", "-|>-") & Y' edge("u", "-|>-")
    $)
  ],
  [
    #diagram($
      X                    & Y \
      X' edge("ru", "-|>") & Y' edge("lu", "-|>")
    $)
  ],
  [
    #diagram(
      node((0, 0), $X$),
      node((1, 0), $Y$),
      node((0, 1), $X'$),
      node((1, 1), $Y'$),
      node((0.5, 0.5), radius: 0.5em, fill: black, stroke: 0.5pt),
      edge((0, 1), (0.5, 0.5), "-|>-"),
      edge((1, 1), (0.5, 0.5), "-|>-"),
      edge((0.5, 0.5), (1, 0), "-|>-"),
      edge((0.5, 0.5), (0, 0), "-|>-"),
    )
  ],
)
The third term contains a vertex, we define the vertex as $-Gamma_(U U', W W')$

The node is painted black, meaning it is resummed by irreducible vertex functions.

If we introduce the pair propagator
$ chi_(X X', Y Y') = plus.minus G_(X Y') G_(X' Y) $
which is exactly the second column diagram.

The vertex function can be obtained by
$ Gamma = Gamma_1 - Gamma_1 chi Gamma $
where $Gamma_1$ is the irreducible vertex function. or equivalently
$ Gamma^(-1) = Gamma_(1)^(-1) +chi $
This is the Bethe-Salpeter equation.

An approximation we made here is to substitute the irreducible vertex function with
$ Gamma_1= Gamma_0 = s+t+u $ <BS-bare-assumption>
where $s,t,u$ are the s,t,u channels at tree level.

We will see that @BS-bare-assumption leads to a ladder approximation.

The matrix form of pair propagator is
$
  chi_(alpha_1 alpha_(1'), alpha_2 alpha_(2')) = - G_(alpha_1 alpha_(2'))(bold(r)_1-bold(r)_2, tau_1-tau_2) G_(alpha_2 alpha_(1'))(bold(r)_2-bold(r)_1 , tau_2-tau_1)
$

Because of the localization nature of the vertex function, we treat it in the $K$ space, where
$Gamma_0(bold(K),Omega_n) = Gamma_0$
is a constant.

Thus
$ Gamma^(-1)(bold(K),Omega_n) = Gamma_0^(-1) + chi(bold(K), Omega_n) $

#remark[
  These equations include space-time non-homogenous parameters, the number of parameters depends on the discretization of
  space-time.
]

#remark[
  The question is, it will be more clear to discretize in $k$ and $omega_n$ space, more problematic in real space?
]

== mean-field Green's function
Take the weak coupling limit, $a_(F)->0^-$. Because $T^(-1)= m/(4 pi hbar^2 a_(F))$, in our unit, $T^(-1)=v/(8 pi epsilon_F) k_F$,
the leading order of Bethe-Salpeter @Bethe-Salpeter is
$
  Gamma_(alpha_1 alpha_2)(bold(K),Omega_n) = (4 pi hbar^2 a_(F)) / (m) delta_(alpha_1 alpha_2)
$

Fourier transform the self-energy @self-energy, we get
$
    &integral dd(k, [d]) / (2 pi)^d 1 / beta sum_(omega_(n)) exp(i(k r - omega_(n) tau)) Sigma_(alpha_1 alpha_2)(bold(k),omega_(n)) \
    &= integral dd(k, [d]) / (2 pi)^d 1 / beta sum_(omega_(n)) exp(i(k r - omega_(n) tau)) Sigma_(alpha_1 alpha_2)^1(bold(k),omega_(n)) hbar delta(bold(r)) delta(tau) \
    &+ integral dd(k_1, [d]) / (2 pi)^d dd(k_2, [d]) / (2 pi)^d 1 / beta^2 sum_(omega_(n) omega_m) exp(i((-k_1+k_2)r) - (-omega_n+omega_m) tau) G_(alpha_1 alpha_2)(k_1,omega_n) Gamma_(alpha_1 alpha_2)(k_2,omega_m)\
    & = integral dd(k, [d]) / (2 pi)^d 1 / beta sum_(omega_(n)) exp(i(k r - omega_(n) tau)) Sigma_(alpha_1 alpha_2)^1(bold(k),omega_(n)) hbar delta(bold(r)) delta(tau) \
    &+ integral dd(k_1, [d]) / (2 pi)^d 1 / beta sum_(omega_(n) ) exp(i((-k_1)r) - (-omega_n) tau) G_(alpha_1 alpha_2)(k_1,omega_n) T delta_(alpha_1 alpha_2) delta(bold(r)) delta(tau)
$

Thus (because of the orthogonality of the basis functions)
$
  Sigma_(alpha_1 alpha_2)(bold(k),omega_(n)) = \
  Sigma_(alpha_1 alpha_2)^1(bold(k),omega_(n)) hbar delta(bold(r)) delta(tau) + G_(alpha_1 alpha_2)(-bold(k),-omega_n) T delta_(alpha_1 alpha_2) delta(bold(r)) delta(tau)
$

The Fourier transform of self-energy is non-zero only when $r=0$ and $tau=0$.

The $bold(r)=0$, $tau=0^(-)$ component of the normal green function $G$ can be obtained by
$ n_(F) = -2 G(bold(r)=0,tau=0^(-)) $

Thus
$
  (Sigma_(alpha_1 alpha_2)(bold(k),omega_(n)) ) = mat(- (2pi hbar^2)/m n_(F) a_(F), Delta;Delta^*, (2pi hbar^2)/m n_(F) a_(F);)
$

Insert this into the Dyson @Dyson, we get
$
  G_(alpha_1 alpha_2)^(-1)(bold(k),omega_(n)) = mat(
    -i hbar omega_n + (epsilon_(bold(k))-mu) + (2pi hbar^2)/m n_(F) a_(F), -Delta;-Delta^*, -i hbar omega_n - (epsilon_(bold(k))-mu) - (2pi hbar^2)/m n_(F) a_(F);
  )
$

By Fourier transform of @Green-function, we get
$
  G_(alpha_1 alpha_2)(bold(k),omega_n) = mat(G(bold(k),omega_n), F(bold(k),omega_n);F^(star)(bold(k),-omega_n), - G(-bold(k),-omega_n);)
$ <k-green>

#remark[
  There is a deduction gap in the inversion procedure. Solve it or ask!
]

You are believed to reproduce this (with a Bogoliubov transformation of the Nambu spinor I think)
$
  G(bold(k),omega_n) = u_(k)^2 / (-i hbar omega_n + E_(bold(k))-mu) - v_(k)^2 / (i hbar omega_n + E_(bold(k))-mu)
$ <mean-field-green>

And the anomalous Green's function
$
  F(bold(k),omega_n) = - Delta / abs(Delta)u_(k) v_(k) [1 / (-i hbar omega_n + E_(bold(k))-mu) + 1 / (i hbar omega_n + E_(bold(k))-mu)]
$ <mean-field-anomalous-green>
where
$
  cases(E_(bold(k)) = sqrt((overline(epsilon)_(bold(k))-mu)^2 + abs(Delta)^2) \
  overline(epsilon)_(bold(k)) = epsilon_(bold(k)) + (2pi hbar^2)/m n_(F) a_(F) \
  u_(bold(k))^2 = 1/2 (1 + (overline(epsilon)_(bold(k))-mu)/(E_(bold(k))-mu)) \
  v_(bold(k))^2 = 1/2 (1 - (overline(epsilon)_(bold(k))-mu)/(E_(bold(k))-mu)))
$

Scale the equation of $overline(epsilon)_(bold(k))$ with respect to $epsilon_F$ and $k_F$
$
  overline(epsilon)_(bold(k)) / epsilon_F = epsilon_(bold(k)) / epsilon_F + (4 ) / (3 pi) 1 / v \
$

#corollary[
  @mean-field-green @mean-field-anomalous-green are mean-field Green's function and anomalous Green's function, at weak
  coupling limit.
]

== Scale invariance
The SCF equations @Dyson @self-energy @Bethe-Salpeter @pair-propagator-K have 3 parameters, temperature $beta$ (hidden
in Matsubara summation), the Fermion density $n_(F)$ (hidden in the chemical potential $mu$ in Dyson @Dyson), the
coupling strength $a_(F)^(-1)$ in Bethe-Salpeter @Bethe-Salpeter.

Because the quadratic energy dispersion $epsilon(bold(k)) = (hbar^2 bold(k)^2 )/(2m)$ and the contact potential (in the
context of discrete lattice model, i.e. Hubbard model), the interaction term doesn't depend on relative distance, the
SCF equations are scale invariant.

$
  G_(alpha_1 alpha_2)(bold(k), omega_n) = epsilon_(F)^(-1) g_(alpha_1 alpha_2)(bold(k) / k_(F), (hbar omega_n) / epsilon_(F))
$
$
  Sigma_(alpha_1 alpha_2)(bold(r), tau) = bold(k)_(F)^(3) epsilon_(F)^(2) sigma_(alpha_1 alpha_2)(k_(F) bold(r) , (epsilon_(F) tau) / hbar)
$
The $Sigma_(alpha_1 alpha_2)(bold(k), omega_n)$ is of the dimension of energy, transform to real space and imaginary
time gives dimension of $bold(k)_(F)^(3) epsilon_(F)$

$
  M_(alpha_1 alpha_2)(bold(r), tau) = epsilon_(F)^(-2) m_(alpha_1 alpha_2)(k_(F) bold(r) , (epsilon_(F) tau) / hbar)
$

$
  Gamma_(alpha_1 alpha_2)(bold(K), Omega_n) = bold(k)_(F)^(-3) epsilon_(F) gamma_(alpha_1 alpha_2)(bold(K) / k_(F), (hbar Omega_n) / epsilon_(F))
$

Thus we can define dimensionless parameters for SCF equations
#definition[
  Define dimensionless temperature as
  $ theta = 1 / (beta epsilon_(F) ) $
  Define dimensionless coupling strength as
  $ v = 1 / (k_(F) a_(F)) $
]
Symbols of temperature and the renormalized interaction strength are abused in the book. From now on I will only use $beta$ to
represent the temperature.

#remark[
  However, our SCF equations are derived in the dilute limit where $k_F r_0 -> 0$. As the $k_F r_0$ reaches 1 or be much
  larger than 1, the Pauli blocking will be extremely relevant.
]

Tuning the coupling strength, we can see the BCS-BEC crossover.

#remark[
  #strong[Assumptions used in SCF equations]
  #list[
    In @BS-bare-assumption, the irreducible vertex function $Gamma_1$ is replaced by the bare interaction vertex $Gamma_0$
  ]
  #list[
    The interaction is assumed local in botsh real space and imaginary time.
  ]
]

These assumptions lead to a ladder approximation.
#figure(image("assets/scqft/ladder.jpg"), caption: "Ladder approximation") <Figure-ladder>

In @Figure-ladder (a) direct and interchange lattice diagrams are considered
#remark[
  Why don't we have diagrams including multiple interchange vertex?
]
I think maybe it's because two $u$ channel interaction may go back to the ordinary ladder diagram.

== SCF procedure
To study the BCS-BEC crossover region, neither the weak coupling limit nor the strong coupling limit is valid.

We start with inserting the mean-field Green's function @mean-field-green @mean-field-anomalous-green into the pair
propagator @pair-propagator-K, we get (All in the $k , omega_n$ space)

#remark[
  We used bare vertex to substitute the irreducible vertex. Does it mean the Green function can be also treated freely
  with this order of approximation?
]

According to the book, I think the answer is probably NO.

=== Note on Fourier transform
We use the convention
#definition[
  $
    G_(alpha_1 alpha_2)(bold(r), tau) = integral dd(k, [d]) / (2pi)^d 1 / beta sum_(omega_n) exp(i (bold(k) bold(r) - omega_n tau)) G_(alpha_1 alpha_2)(bold(k), omega_n)
  $
]

