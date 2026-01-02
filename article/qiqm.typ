#import "/typ/templates/blog.typ": *
#import "@preview/physica:0.9.6": *
#import "@preview/theorion:0.4.1":*
#set heading(numbering: "1.1")
#show: show-theorion
#show link: underline
#import cosmos.clouds: *
#let colred(x) = text(fill: red, $#x$)
#set math.equation(numbering: "(1)")

#show: main.with(
  title: "Notes on Quantum Information Meets
                                                                Quantum Matter",
  desc: [For discussion],
  date: "2025-12-24",
  tags: (blog-tags.physics,),
  license: licenses.cc-by-nc-sa,
)


#set text(lang: "en")

= Basic Information Theory
#quote-box[
  "Perhaps you are still quite happy with
  mean-field theory, which is valid in most cases, where no entanglement needs to be considered. This does not mean that the system is not entangled, but just perhaps not
  strongly entangled." -- P4
]

What does that mean? How do we bipartite a system after mean field approximation?

== Classical correlation
=== Joint Probability without correlations
#theorem[
  The following statements are equivalent:
  1. There is no correlation in the joint probability distribution $p_(A B) (omega_i,lambda_m)$
  2. The probability of $p_(B|A) (omega_i,lambda_m)= p_(B|A) (omega_j, lambda_m), forall i,j,m $
  3. vice versa of 2
  4. $P_(A B) (omega_i,lambda_m) = p_A (omega_i) p_B (omega_m), forall i,m $
]

=== Correlation functions from classical probability theory
#definition[
  $
    C(X,Y) = E(X,Y) - E(X) E(Y)
  $
]

==== Mutual Information
#definition[
  $
    I(X:Y) = sum_(x in X) sum_(y in Y) p(x,y) log (p(x,y) / (p(x)p(y)))
  $
]
Cute thing of mutual information is that it doesn't calculate expectation values, it's independent of the value of the variables.

===== Mutual Information and KL divergence
#definition[
  $
    D_("KL") (P||Q) = sum_i P(i) log (P(i)/Q(i))
  $
]
Thus,
$
  I(X:Y) = D_("KL") (p(x,y) || p(x)p(y))
$

====== Mutual Information and correlation

#definition[
  perfect correlation
  $
    p(x,y) = cases(0 quad x != y, p(x) quad x = y)
  $
]
In this case,
$
  I(X:Y) = sum_x p(x) log (1 / p(x)) := H(X)
$

#definition[
  entropy for joint distribution
  $
    H(X,Y) = - sum_(x in X) sum_(y in Y) p(x,y) log p(x,y)
  $
  and conditional entropy
  $
    H(X|Y=y) &= - sum_(x in X) p(x|y) log p(x|y) \

    H(X|Y)   &= sum_(y in Y) p(y) H(X|Y=y) = - sum_(x in X) sum_(y in Y) p(x,y) log p(x|y)
  $
]

In this language
$
  I(X:Y) &= H(X) + H(Y) - H(X,Y) \
         &= H(X) - H(X|Y) \
         &= H(Y) - H(Y|X) \
         &= H(X,Y) - H(X|Y) - H(Y|X)
$



== Quantum entanglement
What's different from a quantum bit comparing to a classical bit?
#remark[
  The probability distribution of a pure quantum state must be associated with a chosen measurement basis.
] 

=== Reduced density matrix 
$
  rho_B = tr_A (rho_A B) = sum_i c_(i m) c_(i n)^* ket(m_B) bra(n_B)
$

For a whole pure state $ket(psi_(A B))$, different trace basis will give different reduced density matrix.

The proof in the book seems a bit ad hoc, I copy and paste my previous note here:
#definition[
  $ ket(psi) = sum_(i=1)^(min(D_A, D_B)) sqrt(lambda_i) ket(i_A) times.circle ket(i_B) $

  $ lambda_i>=0 quad sum_i lambda_i=1 $
]


#proof[
  Write $ket(psi) = sum_(i, mu) psi_(i, mu) ket(i)_A times.circle ket(mu)_B$, define $ket(overline(i))_B = sum_mu psi_(i, mu) ket(mu)_B$

  Define $rho_A = sum_i P_i ket(i)_A times.circle bra(i)_A$
  $
    rho_A &=sum_(i j) Tr_B (ket(i)_A times.circle ket(overline(i))_B) (bra(j)_A times.circle bra(overline(j))_B)\
          &=sum_(i j) braket(overline(j), overline(i))_B ket(i)_A bra(j)_A\
          &= sum_i P_i ket(i)_A bra(i)_A
  $

  Thus, $braket(overline(j), overline(i))_B = P_i delta_(i j)$

  $ket(overline(i))_B$ and $ket(overline(j))_B$ are orthogonal! Adding a normalization constant makes them orthonormal,
  thus proving the Schimidt decomposition.
]


=== Pure bipartite state
We didn't constrain basis $ket(psi_(A B))$ before, but in the context of schmidt decomposition, we can always find a basis $ket(u_i)_A$, $ket(v_i)_B$ such that they are orthonormal 
#theorem[
  A state has no correlation iff
  1. $ket(psi_(A B)) = ket(psi_A) times.circle ket(psi_B)$, or
  2. $forall O_A, O_B, C(O_A,O_B) =0$
]

Schmidt decomposition gives a criterion of entanglement:
#theorem[
  The following statements are equivalent:
  1. $ket(psi_(A B))$ is entangled
  2. Schmidt rank $>1$
  3. Reduced density matrix $rho_A$ (or $rho_B$) is mixed state
]

=== Seperable mixed state
#definition[
  A mixed state $rho_(A B)$ is seperable iff it can be written as
  $
    rho_(A B) = sum_i p_i rho_A^(i) times.circle rho_B^(i)
  $
  with $p_i>=0$, $sum_i p_i=1$
]

This is generally an NP-hard problem to determine whether a mixed state is seperable or not. We define
#definition[
  $
    E_F = min_(sum_i p_i braket(psi_(i A B))) sum_i p_i E(ket(psi_(i A B)))
  $
  where $E(ket(psi_(i A B))) = H({lambda_j}) $ where $lambda_j$ is the schmidt coefficients of $ket(psi_(i A B))$
]

For seperable states, $E_F=0$.

=== Peres-Horodecki Criterion
also termed as PPT criterion, for positive partial transpose. It is a necessary condition for separability.
#theorem[
  If a mixed state $rho_(A B)$ is separable, then the partial transpose $rho_(A B)^(T_B)$ is positive semidefinite.
]
Take Bell state as an example,
$
  rho_(A B) = ket(psi^-) bra(psi^-) = 1/2 (ket(01) + ket(10)) (bra(01) + bra(10)) \
  = 1/2 (ket(01) bra(01) + ket(10) bra(10) + ket(01) bra(10) + ket(10) bra(01))
$
Taking partial transpose on B, you would get negative eigenvalues, thus it's entangled.
 
#remark[
  This is called *negativity* in many body context. Check it out!
]

= Open Quantum system
Sorry for personal reason I'm too lazy to read this part. Would follow up maybe.
== The orthogonalization of Kraus operators


= Quantum Error-Correcting Codes

#remark[
  In some sub Hilbert space, the projection of noise channel can be unitary.
]
#example[
  Consider Kraus Operator ${1/sqrt(2) Z_1, 1/sqrt(2) Z_2}$, in the subspace spanned by $ket(00), ket(11)$, the projection is unitary.
]

Because: 
$
  Z_1 (alpha ket(00) + beta ket(11)) = alpha ket(00) - beta ket(11) \
  Z_2 (alpha ket(00) + beta ket(11)) = alpha ket(00) - beta ket(11) \
$
So
$
  rho' = sum_i E_i rho E_i^dagger = ketbra(psi')
$
which an unitary operation on the subspace.

== Bit Flip Code
#definition[
  $
    cal(E)_("BF") (rho) = (1-p) rho + p X rho X
  $
  i.e. the Kraus operators are $E_0 = sqrt(1-p) I$, $E_1 = sqrt(p) X$
]
Thus, for $ket(phi) = alpha ket(0) + beta ket(1)$
$
  sigma = (1-p) ketbra(phi) + p X ketbra(phi) X
$

#definition[
  Probability of failure
  $
    p_("err")equiv 1-F^2 = 1- mel(phi, sigma, phi) = p(1-abs(alpha^* beta + beta^* alpha)^2)
  $
]

In general this error is inevitable. But at best we can alleviate it.

=== Repitition Code
By letting 
$
  ket(Psi) = alpha ket(000) + beta ket(111)
$

By performing orthogonal measurement with projectors
$
  P_0 = ketbra(000) + ketbra(111) \
  P_1 = ketbra(100) + ketbra(011) \
  P_2 = ketbra(010) + ketbra(101) \
  P_3 = ketbra(001) + ketbra(110)
$
we find
$
  sigma_0 &= (1-p)^3 ketbra(Psi) + p^3 X_1 X_2 X_3 ketbra(Psi) X_1 X_2 X_3 \
  sigma_1 &= (1-p)^2 p X_1 ketbra(Psi) X_1 + p^2 (1-p) X_2 X_3 ketbra(Psi) X_2 X_3 \
  sigma_2 &= (1-p)^2 p X_2 ketbra(Psi) X_2 + p^2 (1-p) X_1 X_3 ketbra(Psi) X_1 X_3 \
  sigma_3 &= (1-p)^2 p X_3 ketbra(Psi) X_3 + p^2 (1-p) X_1 X_2 ketbra(Psi) X_1 X_2
$

These $sigma$s are called the *error syndromes*.

When getting these syndromes, we can perform correction operations:
$
  sigma_0 &-> I \
  sigma_1 &-> X_1 \
  sigma_2 &-> X_2 \
  sigma_3 &-> X_3
$

After correction,
$
  sigma'_0 &= (1-p)^3 ketbra(Psi) + p^3 X_1 X_2 X_3 ketbra(Psi) X_1 X_2 X_3 \

  sigma'_1 &= (1-p)^2 p ketbra(Psi) + p^2 (1-p) X_1 X_2 X_3 ketbra(Psi) X_1 X_2 X_3 \
  sigma'_2 &= (1-p)^2 p ketbra(Psi) + p^2 (1-p) X_1 X_2 X_3 ketbra(Psi) X_1 X_2 X_3 \
  sigma'_3 &= (1-p)^2 p ketbra(Psi) + p^2 (1-p) X_1 X_2 X_3 ketbra(Psi) X_1 X_2 X_3
$
Thus the final error probability is
$
  p'_("err") = 1 - mel(Psi, sum_(i=0)^3 sigma'_i, Psi) =p(3-2p)p_("err")
$

If $p<1/2$, then $p'_("err")<p_("err")$.

The repetition of code can improve this further to $p'_("err") approx p^r p_("err")$.

== Shor's code
Shor's code can correct both bit flip and phase flip errors.

Starting from 
$
  ket(+) &= 1/sqrt(2) (ket(0) + ket(1)) \
  ket(-) &= 1/sqrt(2) (ket(0) - ket(1)) \
$

let 
$
  ket(0) &-> ket(+++) equiv ket(0_L) \
  ket(1) &-> ket(---) equiv ket(1_L) \
$

For Depolarizing channel
$
  cal(E)_("DP") (rho) = (1-p) rho + p/3 (X rho X + Y rho Y + Z rho Z)
$


#let tensor = $times.circle$
#let implies = $arrow.r$


== Error Probability Calculation (Order Estimation)

For a code that corrects any single-qubit error ($t=1$), the logical error occurs only when *at least 2 qubits* fail. 

Let the probability of a physical error on one qubit be $epsilon = p$. The probability of logical failure $P_("fail")$ is the sum of probabilities of having $k >= 2$ errors:

$
  P_("fail") &= sum_(k=2)^9 binom(9, k) (epsilon/3)^k (1-epsilon)^(9-k) \
             &= binom(9, 2) (epsilon/3)^2 (1-epsilon)^7 + O(epsilon^3) \
             &approx 36 dot epsilon^2/9 \
             &= 4 epsilon^2
$

Thus, the logical error probability is suppressed quadratically:
$ P_("logical") in O(p^2) $

#remark[
  What's the quantum part of this?
]

== Quantum Code
#definition[
  A quantum code $cal(C)$ is a subspace of the total Hilbert space $cal(H)$. The dimension of the code is $K = dim(cal(C))$, and the number of physical qubits is $n = log_2 dim(cal(H))$.
]

To distinguish different errors,
#theorem[
  Quantum error-correcting condition: A quantum code $cal(C)$ can correct a set of errors ${E_a}$ iff
  $
    bra(psi_i) E_a^dagger E_b ket(psi_j) = C_(a b) delta_(i j)
  $
]

#definition[
  Quantum Code distance
  A quantum code $cal(C)$ has distance $d$ iff it can detect all errors affecting up to $d-1$ qubits, i.e. it can correct up to $t = floor((d-1)/2)$ qubit errors.

  $ mel(psi_i, O, psi_j) = C_O delta_(i j) $ for all operators $O$ acting on up to $d-1$ qubits.
]

== Stabilizer Codes

#definition[
  A stabilizer $cal(S)$ is an abelian subgroup of the Pauli group $cal(P)_n$ that does not contain $-I$.
]

=== Shor's Code
The Stabilizer group of Shor's code is generated by
$
  g_1 = Z_1 Z_2, quad g_2 = Z_2 Z_3, \
  g_3 = Z_4 Z_5, quad g_4 = Z_5 Z_6, \
  g_5 = Z_7 Z_8, quad g_6 = Z_8 Z_9, \
  g_7 = X_1 X_2 X_3 X_4 X_5 X_6, \
  g_8 = X_4 X_5 X_6 X_7 X_8 X_9
$

The Projector onto the code space is
$
  P = product_(i=1)^8 (I + g_i)/2
$

Define $Z_L= X^(tensor 9)$ which gives $Z_L ket(0_L)= ket(0_L), Z_L ket(1_L)= -ket(1_L)$.

Thus the basis state $ket(0_L)$ is stabilized by
$
  cal(S)_0 = expval(g_1, g_2, g_3, g_4, g_5, g_6, g_7, g_8, Z_L)
$

We can also define $X_L = Z_1 Z_4 Z_6$, as $X_L ket(0_L)= ket(1_L), X_L ket(1_L)= ket(0_L)$.

Hence
$
  ketbra(0_L) = 1/(2^9) product_(i=1)^8 (I + g_i) (I + Z_L)
$

$
  ket(0_L) = 1/(2^(9/2)) sum_(g in cal(S)_0) g ket(0)^(tensor 9)
$

As we are dealing with $ket(0)^(tensor 9)$ states,
$
  ket(0_L) = 1/(2^(3/2)) (I+g_7) (I+g_8) (I+Z_L) ket(0)^(tensor 9)
$

=== Stabilizer Formalism
#definition(title: [Stabilizer Code])[
  A Stabilizer Code is defined by a Stabilizer Group $cal(S)$, such that
  $
    Q(cal(S)) ={ket(psi) | P ket(psi) = ket(psi) forall P in cal(S)}
  $
  Then $Q(cal(S))$ is the Stabilizer code and $cal(S)$ is its Stabilizer.
]

#definition(title: [Stabilizer State])[
  If a Stabilizer code of $N-$ qubit has $N$ independent generators, then the code space is one-dimensional, and the unique state in the code space is called a Stabilizer State.
]

#problem[How to exhaust all Stabilizer States of N qubits?]
