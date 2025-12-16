
#import "/typ/templates/blog.typ": *
#import "@preview/theorion:0.4.1":*
#import "@preview/physica:0.9.6":*
#show: show-theorion
#show link: underline
#show: main.with(
  title: "Memory efficient Lanczos",
  desc: [https://lukefleed.xyz/posts/cache-friendly-low-memory-lanczos/],
  date: "2025-12-16",
  tags: (blog-tags.physics, blog-tags.programming),
  license: licenses.cc-by-nc-sa,
)
= Memeory efficient Lanczos
check this out! #link("https://lukefleed.xyz/posts/cache-friendly-low-memory-lanczos/")[Luke Fleed's blog post]

Though it is not user friendly yet, however, memory is a major concern in ED, so might be good to keep in mind.

#let th(body) = block(fill: luma(230), width: 100%, inset: 8pt, outset: 0pt, strong(body))
#emph-box[
  AI told me that's efficient when I need the eigenvector.
]

= AI Feedback: Two-Pass Lanczos in ED

This is an excellent question. Using this specific "Two-Pass" Lanczos approach for *Quantum Many-Body Exact Diagonalization (ED)* is actually a very standard and effective strategy, specifically when you are hitting the limits of your RAM.

Here is a breakdown of how this applies to your ED work, how it compares to the standard "on-the-fly" options, and why the comments in the screenshot (specifically Antoine's critique) might be misleading for your specific use case.

== What is the "Two-Pass" Method in ED?

In the context of the blog post and ED, the comparison is between:

- *Single-Pass (Standard):* You perform $k$ Lanczos steps. You store every vector $v_1, v_2, ..., v_k$ in memory (or on disk). At the end, you diagonalize the small tridiagonal matrix to get the ground state coefficients, and compute the linear combination of the stored vectors to get the full wavefunction $psi$.

- *Two-Pass (The approach in the post):*
  - *Pass 1:* You run the Lanczos iteration to build the tridiagonal matrix (energy), but you _discard_ the vectors as you go (keeping only the last 3).
  - *Pass 2:* Once you have the coefficients for the ground state, you run the _exact same_ Lanczos iteration again from the same random seed. This time, you generate the vectors "on the fly" and accumulate them into the final eigenvector.

== Why Antoine's critique might be wrong for you

Antoine argues the method is "useless" because short recurrence relations exist for $A x = b$ (Linear Systems) and $exp(A)$ (Time Evolution).

However, in Quantum ED, you are usually solving the *Eigenvalue Problem* ($H psi = E psi$) to find the Ground State.
- There is no "short recurrence" to magically produce the Ground State eigenvector without the basis vectors.
- You *must* reconstruct the vector basis.
- Therefore, you are forced to choose between *Storage* (Single-Pass) or *Recomputation* (Two-Pass).

== Comparison: Two-Pass vs. "On-the-Fly"

In Many-Body ED, the Hamiltonian $H$ is typically defined "on the fly" (matrix-free) because the matrix is too sparse/large to store. The bottleneck is storing the *Krylov Vectors* (the state vectors).

Here is the trade-off analysis:

#figure(table(
  columns: (auto, 1fr, 1fr),
  inset: 10pt,
  align: horizon,
  stroke: 0.5pt + luma(200),
  table.header([*Feature*], [*Single-Pass*\ (Store Vectors)], [*Two-Pass*\ (Recompute)]),
  [*RAM Usage*],
  [**Very High** \ Scales as $k times D$ \ (where $k$ is steps, $D$ is dim).],
  [**Minimal** \ Scales as $3 times D$ \ (constant, regardless of steps).],
  [*CPU Cost*],
  [**1x** \ Matrix-vector mult once per step.],
  [**2x** \ Must perform every mult twice.],
  [*I/O Bottleneck*],
  [**High** \ Swapping to disk kills performance.],
  [**Low** \ Keeps everything in RAM.],
  [*Precision*],
  [Standard.],
  [**Risk of drift** \ Pass 2 might diverge slightly due to float associativity (usually negligible).],
), caption: [Trade-offs between Single-Pass and Two-Pass strategies.])

== When should you use the Rust implementation?

*Use the Two-Pass (Post) method if:*
- *Memory is your bottleneck:* Your Hilbert space is large (e.g., $N > 16$ spins), and storing $100+$ Lanczos vectors would crash your RAM.
- *CPU is cheap:* You have plenty of compute time but limited memory bandwidth/capacity.
- *You need the Eigenvector:* If you only need the _Energy_, you never need the two-pass method. If you need to measure observables ($mel(psi, O, psi)$), you need the vector, making Two-Pass essential for large systems.

*Use the Standard (Single-Pass) method if:*
- *System size is small:* If all your Lanczos vectors fit in RAM, Single-Pass is 2x faster.
- *You are doing Time Evolution:* As noted, if calculating $e^(-i H t) ket(psi)$, there are Krylov subspace tricks that don't require recomputing the whole basis in the same way.

== Summary

The "Cute trick" discussed in the image is actually the *standard industry practice* for large-scale Exact Diagonalization codes (like those used in Condensed Matter Physics).

While Antoine is right that it's unnecessary for solving linear systems ($A x = b$), it is *critical* for finding the Ground State Eigenvector when the Hilbert space is too large to store the Krylov subspace.

#emph-box[*Recommendation:* If you are writing a Rust ED code for large systems, *porting this is a good idea.* It effectively doubles your max system size capability at the cost of doubling the runtime.]