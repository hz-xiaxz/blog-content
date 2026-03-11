#import "/typ/templates/blog.typ": *
#import "@preview/theorion:0.4.1": *
#show: show-theorion
#show: main.with(
  title: "VPN与电脑时区",
  desc: [还有这种],
  date: "2026-03-11",
  tags: (blog-tags.random,),
  license: licenses.cc-by-nc-sa,
)
换了新电脑。始终装不上VPN。问题是Gemini告诉我的
#emph-box[
  原因二：新电脑的“系统时间”不准确（最容易踩坑）
  如果你使用的是 Vmess、Vless、Trojan 等协议的节点，这些协议对客户端的系统时间极度敏感。
  为了防止重放攻击，如果你的电脑系统时间与标准北京时间误差超过 90秒到2分钟，哪怕订阅更新成功了，节点也会全部连不上（全部显示 Timeout 或红色的 Error）。
  如何排查：在新电脑上打开 Windows 设置 -> 时间和语言 -> 日期和时间。
  解决方法：点击 “立即同步” 按钮，确保你的电脑时间是绝对准确的。这是很多换新电脑的用户最常遇到的问题。
]
