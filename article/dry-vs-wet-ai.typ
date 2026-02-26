#import "/typ/templates/blog.typ": *
#show: main.with(
  title: "DRY vs WET # AI",
  desc: [AI时代代码可能更贴近底层，人类调试将转向需求描述的精确性。],
  date: "2026-02-26T22:05:56+08:00",
  tags: (blog-tags.random,),
  license: licenses.cc-by-nc-sa,
)

这是cloudfare在总结自己如何使用1100美刀就在Vite上重写了NEXT.JS https://blog.cloudflare.com/vinext/

#image("assets/dry-vs-wet-ai/img_1.jpg")

这里提到一个很好的问题。Code Quality中注重的DRY（Don't repeat yourself）推崇代码复用，逻辑抽象，这是因为“人类的上下文有限”。而对于AI，抽象和推理反而是复杂的，在上下文中，遵循WET（Write Everything Twice）的原则似乎能干得更好

这导致了新的问题，AI以后写出来的代码，还会是“高级语言”的样子吗?还是他可以直接触碰底层?（现在不擅长写底层是因为缺少足够多的人类数据）

人类为了解耦会加很多接口（Interface），AI 可能会直接调用实现，因为它能“看穿”整个调用栈。

== 后果

1. 调试的消失：你很少会去调试编译器生成的汇编指令，你通常是检查你的 C++ 源码。
未来，人类可能不再纠结于“代码里这个变量名起得好不好”，而是纠结于“我的需求描述（Spec）是否精确”。当代码运行报错，你会要求 AI “重新生成一份”，而不是在那几千行平铺的代码里人肉修 Bug。这意味着Test Driven Development要登上舞台了吗

​2. 性能与可读性的终极博弈
​过去，由于人类需要阅读代码，我们不得不牺牲一部分性能来换取可读性（比如过度封装带来的开销）。如果代码是给 AI 看的，AI 可以写出逻辑极其扭曲、充满特殊优化、人类完全看不懂但在机器上跑得飞快的代码。
​

== 另一条路

但这些问题很大程度上是因为，AI的推理依赖于CoT（Chain of Thought），对于计算机语言，这是非常消耗token的。我的疑惑：Claude Code加入了LSP支持，但很多人说它没有什么用，这是怎么回事

Maybe 大模型巨大的上下文已经抹平了LSP的效益。

基于ast的代码模型很可能遇到训练数据不足的问题

我们需要的还是大量数据深度学习出来的智能，而且强化学习出来被约束的做特定事情的能力
