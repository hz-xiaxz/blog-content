#import "@preview/physica:0.9.6": *
#import "@preview/theorion:0.4.1":*
#show: show-theorion
#show link: underline
#import cosmos.clouds: *
#let colred(x) = text(fill: red, $#x$)
#set math.equation(numbering: "(1)")

#import "/typ/templates/blog.typ": *
#show: main.with(
  title: "我与我的申请",
  desc: [冠冕堂皇以外的——为什么？],
  date: "2026-01-30",
  tags: (blog-tags.physics,blog-tags.emotions,blog-tags.improvement),
  license: licenses.cc-by-nc-sa,
)
