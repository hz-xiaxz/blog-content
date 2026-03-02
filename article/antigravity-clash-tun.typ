#import "/typ/templates/blog.typ": *
#show: main.with(
  title: "antigravity Clash TUN",
  desc: [探讨 Antigravity 对 Clash TUN 模式的依赖及其底层实现原理。],
  date: "2026-02-26T17:14:55+08:00",
  tags: (blog-tags.random,),
  license: licenses.cc-by-nc-sa,
)
#import "@preview/theorion:0.4.1": *
#show: show-theorion

Antigravity 似乎要clash的tun模式才能进入
TODO : TUN模式干了啥

== Tun模式
Gemini 回复：
#emph-box[为什么 Antigravity 非要 Tun 模式？
  普通的“系统代理”模式（System Proxy）本质上只是在系统设置里写了一行字，告诉软件：“请把 HTTP 请求发到这个端口”。但 Antigravity 这种复杂的开发工具不听这一套：
  独立的进程与验证流：Antigravity 登录时，通常会跳到浏览器授权，然后浏览器把 Token 回传给客户端。在普通模式下，客户端（Antigravity 进程本身）往往不读取系统代理设置，导致它在后台尝试连接 Google 服务器时被墙拦截，表现为*“一直转圈”或“登录无反应”*。
  非 HTTP 流量：Antigravity 内部集成了大量工具（如 Gemini CLI、语言服务器 Language Servers、模拟终端等）。这些底层工具很多使用原生 TCP 直接连接，或者使用特殊的端口，它们完全无视系统的 HTTP 代理设置。
  DNS 污染：Google 的服务在国内通常伴随严重的 DNS 污染。普通代理模式下，软件可能先尝试在本地解析 Google 域名，拿到一个错误的 IP 导致连接失败。而 Tun 模式会接管系统的 DNS 请求，确保解析出正确的地址。
  开启 Tun 模式后，Clash 会在系统里建一张虚拟网卡。Antigravity 的所有数据包（不管是登录验证、模型加载还是代码补全）都会被强制丢进这张网卡进行分流，它想不走代理都难，所以就能“进去”了。
]
