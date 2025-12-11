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
  date: "2025-12-11",
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

