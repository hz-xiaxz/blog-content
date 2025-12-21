#import "/typ/templates/blog.typ": *
#import "@preview/theorion:0.4.1":*
#show: show-theorion
#show link: underline
#show: main.with(
  title: "ABM: AnyRouter Backend Manager",
  desc: [仿照NVM，我用AI写了一个AnyRouter的后端管理工具],
  date: "2025-12-21",
  tags: (blog-tags.ai,),
  license: licenses.cc-by-nc-sa,
)

= AnyRouter Backend Manager
Anyrouter 是一个方便的Claude白嫖工具，但是他的后端经常断联，即使运用代理也无法避免。

收到NPM镜像管理工具 nvm 的启发，我让AI帮我写了一个AnyRouter的后端管理工具，叫做 ABM (AnyRouter Backend Manager)。

它可以让你轻松地安装、切换和管理多个AnyRouter后端。

简单的几行代码就可以完成

```python
import time
import requests
import os

# 1. 定义你想检测的后端地址
URLS = [
    "https://pmpjfbhq.cn-nb1.rainapp.top",
    "https://c.cspok.cn",
    "https://q.quuvv.cn",
    "https://anyrouter.top"
]

def check_backends():
    best_url = None
    min_latency = float('inf')

    print(f"{'URL':<40} | {'Latency':<12} | {'Status'}")
    print("-" * 65)

    for url in URLS:
        try:
            start_time = time.time()
            # 发送请求，超时设为 3 秒
            resp = requests.get(url, timeout=3)
            latency = (time.time() - start_time) * 1000 # 毫秒
            
            print(f"{url:<40} | {latency:>8.2f} ms | {resp.status_code}")

            # 记录最快的那个
            if latency < min_latency:
                min_latency = latency
                best_url = url
        except Exception:
            print(f"{url:<40} | {'Timeout':>11} | Error")

    print("-" * 65)

    # 2. 将最快的结果写入临时文件，供 Shell 读取
    if best_url:
        print(f"推荐节点: {best_url}")
        with open("/tmp/best_claude_url", "w") as f:
            f.write(best_url)
    else:
        print("没有找到可用的节点")

if __name__ == "__main__":
    check_backends()
```

然后写入一个Shell脚本来调用它，并设置环境变量
```bash
function cl-check() {
    # 1. 直接指定虚拟环境中的 python 路径
    # 假设你的脚本和 .venv 都在 ~/scripts 下
    ~/scripts/.venv/bin/python ~/scripts/abm.py
    
    # 2. 读取结果并设置环境变量
    if [ -f /tmp/best_claude_url ]; then
        export ANTHROPIC_BASE_URL=$(cat /tmp/best_claude_url)
        echo "🚀 已切换: ANTHROPIC_BASE_URL=$ANTHROPIC_BASE_URL"
    fi
}
```

此后 每次想切换后端，只需运行 `cl-check` 即可。
```bash
source ~/.zshrc  # 确保 shell 脚本已加载
cl-check
```

输出:
```bash
➜  scripts git:(master) ✗ cl-check 
URL                                      | Latency      | Status
-----------------------------------------------------------------
https://pmpjfbhq.cn-nb1.rainapp.top      |    58.80 ms | 403
https://c.cspok.cn                       |     Timeout | Error
https://q.quuvv.cn                       |     Timeout | Error
https://anyrouter.top                    |   285.82 ms | 200
-----------------------------------------------------------------
推荐节点: https://pmpjfbhq.cn-nb1.rainapp.top
🚀 已切换: ANTHROPIC_BASE_URL=https://pmpjfbhq.cn-nb1.rainapp.top
```

== TODO
也许未来可以用一个真的API key去test，目前后端还没有加这一层防护，先用着看。