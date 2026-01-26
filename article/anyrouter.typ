#import "/typ/templates/blog.typ": *
#import "@preview/theorion:0.4.1":*
#show: show-theorion
#show link: underline
#show: main.with(
  title: "AnyRouter 返回520",
  desc: [Claude Code],
  date: "2026-01-25",
  tags: (blog-tags.ai,),
  license: licenses.cc-by-nc-sa,
)
= AnyRouter 返回520
AnyRouter 白嫖Claude，偶尔会遇到520错误。
参见这个#link("https://github.com/millylee/anyrouter-check-in/issues/57#issuecomment-3588931093")[github comment]

首先 Clash要设置为TUN模式，然后删除
```bash
rm -rf ~/.claude/statsig/*
```

按照其建议设置环境变量
```bash
echo 'export DISABLE_TELEMETRY=1' >> ~/.zshrc
source ~/.zshrc
```

暂时解决了！

== AI解释
不能全靠别人一张嘴，也许应该知道一下原理

#emph-box[
关掉 TELEMETRY（遥测/数据统计）的核心原因很简单：因为它的连接失败导致了整个程序崩溃。
这里是更深层的技术解释，帮你理解发生了什么：
1. 根本原因：网络环境问题
claude 这个命令行工具集成了 Statsig（一个用于功能开关管理和用户行为统计的第三方服务）。
在国外：工具启动 -> 连接 Statsig 服务器 -> 上报“用户启动了程序” -> 成功 -> 程序继续运行。
在国内：工具启动 -> 连接 Statsig 服务器 -> 被防火墙阻断或连接极其不稳定 -> 返回 520 错误或超时。
2. 为什么会导致程序挂掉？（520 Error）
理论上，统计数据上传失败不应该影响主程序使用。但 Claude CLI 的某些版本在错误处理上写得不够好：
它把连接 Statsig 当作了一个“必须完成”的启动步骤。
当服务器返回 520 (Web Server Returned an Unknown Error) 或者连接被重置时，程序抛出了异常，导致整个工具直接退出。
你看到的 API Error: 520，其实不是 DeepSeek 或 Claude 的 AI 接口坏了，而是后台偷偷上传数据的那个接口挂了。
3. DISABLE_TELEMETRY=1 做了什么？
当你设置这个环境变量为 1 时，相当于给程序下达了“静默模式”指令。
程序启动时，检测到这个变量。
直接跳过 Statsig 初始化和数据上传的代码块。
程序就不会去请求那个连不通的服务器，自然就不会报错，直接进入正常的 AI 对话功能。
4. 形象的比喻
想象你要开一辆车（启动 Claude 工具）：
默认情况：车子设计逻辑是“启动前必须向厂家发送一条短信汇报位置”。如果你的手机没信号（网络不通），短信发不出去，车子的电脑就报错，锁死引擎不让你开。
关掉 Telemetry：相当于剪断了那根发短信的电线，或者告诉车载电脑“别发短信了，直接点火”。车子就不再检查短信是否发送成功，直接就能开了。
总结
关掉它有百利而无一害：
修复报错：解决 520/Timeout 导致无法使用的问题。
加快启动：省去了建立网络连接的时间，工具启动更快。
保护隐私：你的使用习惯、报错日志不会被上传到服务器。
功能无损：这完全不影响你调用 DeepSeek 或 Claude 的 AI 核心功能。
]

= Doomed
AnyRouter is doomed? Track #link("https://check.linux.do")[here]