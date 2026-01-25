#import "@preview/physica:0.9.6": *
#import "@preview/theorion:0.4.1":*
#show: show-theorion
#show link: underline
#import cosmos.clouds: *
#let colred(x) = text(fill: red, $#x$)
#set math.equation(numbering: "(1)")

#import "/typ/templates/blog.typ": *
#show: main.with(
  title: "Magic in Fermionic System",
  desc: [Reading arXiv:2412.05367v2],
  date: "2026-01-25",
  tags: (blog-tags.physics,),
  license: licenses.cc-by-nc-sa,
)

= What is Magic?

I would like to put things short. Magic, in the context of quantum computation, is to describe how far a quantum system is from a *stablizer state*, and stablizer state is a state that can be prepared by *Clifford gates*.

However, this definition seems untractable for me to extend to Fermionic systems. As stated in the main paper, _Free Fermionic states(Fermion Gaussian States)_ are classically simulatable and thus not magic. If this is the starting point, then it seems to me that the word "magic" is abused. 

From now on I would like to state that we are trying to understand the `non-Stabilizer-ness` of a Fermionic state, which doesn't make a lot of sense to me.

However, there are some topological states that are hard, or impossible to prepare in tensor network ansatz #link("https://arxiv.org/pdf/2511.19612")[arxiv2511.19612]. We want to know if these states have high "magic" content.


