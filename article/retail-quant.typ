#import "/typ/templates/blog.typ": *
#show: main.with(
  title: "[AI生成] 散户量化之路：从A股到美股",
  desc: [A股散户为什么难赚钱？美股数据抓取、回测框架与Seeking Alpha调研。],
  date: "2026-03-10T07:16:14+08:00",
  tags: (blog-tags.stock, blog-tags.python,),
  license: licenses.cc-by-nc-sa,
)

= 为什么写这篇

作为一个只熟悉A股的人，我越来越觉得A股不适合散户进军。这不是情绪化的判断——数据摆在那里。与其继续在A股当韭菜，不如认真调研一下美股的量化分析和回测生态。

= A股散户的残酷现实

A股投资者总数突破2.4亿户，个人投资者占99.76%。但只有约19%实现盈利，"七亏二平一赢"的规律多年未变。10万元以下账户亏损率接近98.7%。

散户亏钱的核心原因：

+ *信息劣势*：机构有300人研究团队，能实地调研供应链。65%的散户通过微信群、股吧获取信息，滞后平均3天。
+ *过度交易*：散户交易频率是机构的3-5倍，年化交易成本高达本金的12%。72%的散户认为自己选股能力超过市场平均——但数据打脸。
+ *处置效应*：盈利股平均持有23天就卖，亏损股死扛178天。人性的弱点被市场无限放大。
+ *量化降维打击*：2025年量化交易占比提升至30%，AI算法0.01秒完成散户需要5分钟的决策。

2025年市场甚至呈现"指数繁荣、个股失血"的特征——3000余只中小盘股下跌，仅权重股拉动指数。散户看着大盘涨，自己的账户在亏。

= A股 vs 美股

#table(
  columns: 3,
  [*对比维度*], [*A股*], [*美股*],
  [散户交易占比], [60-70%], [\<10%],
  [市场特征], [牛短熊长], [牛长熊短],
  [换手率], [\~428%], [\~116%],
  [5年退市数量], [27只], [1438只],
)

美股已经完成了"去散户化"。美国养老金资产总规模28.2万亿美元，是GDP的1.45倍，大量机构资金入市降低了换手率，增强了市场稳定性。散户主要通过基金和ETF间接参与。

A股的问题不只是散户多——而是制度层面：信息披露不透明、退市制度形同虚设、壳资源炒作盛行。这些都让价值投资在A股很难实施。

= 什么是 Seeking Alpha?

#link("https://seekingalpha.com")[Seeking Alpha] 是美国最大的众包式投资研究平台，2004年创立，2000万+活跃用户，7000+认证作者。可以理解为一个高质量版的"雪球+东方财富研报"。

核心功能：
- *Quant 评级系统*：算法对10000+只美股打分（Strong Buy → Strong Sell），基于value/growth/profitability/momentum/EPS revisions五个维度
- *众包分析文章*：专业和业余投资者都可以发布深度个股分析
- *Factor Grades*：对每只股票给出量化因子评分

订阅分三档：Basic免费（基础筛选器）、Premium \$239/年（完整分析和评级）、PRO面向专业投资者。独立学术研究发现其评级系统能有效预测未来1个月到3年的股票回报。

对于做美股研究来说，这是一个非常好的信息源。

= 数据抓取方案

做量化的第一步是拿到数据。以下是从免费到专业的美股数据API：

== 免费/低成本

- *yfinance*（Python库）：最简单，`pip install yfinance`，一行代码拉数据。入门首选。
- *Alpha Vantage*：免费tier，内置50+技术指标API，适合历史回测。
- *Finnhub*：实时行情+基本面+另类数据。
- *Alpaca*：免佣交易+API，可以直接从回测接到实盘。

== 专业级

- *Polygon.io*：tick级数据，分钟线，适合高频回测。
- *Databento*：全订单簿深度，覆盖美国15个交易所。
- *EODHD*：全球股票价格+基本面+新闻，性价比高。

在中国使用这些API需要代理。可以通过 `requests` 的 `proxies` 参数解决：

```python
import yfinance as yf
import os
os.environ['HTTP_PROXY'] = 'http://127.0.0.1:7897'
os.environ['HTTPS_PROXY'] = 'http://127.0.0.1:7897'
data = yf.download('AAPL', '2024-01-01', '2026-01-01')
```

= 回测框架

== Backtrader（入门首选）

事件驱动，支持佣金/滑点建模，社区最大。一个最小的双均线回测：

```python
import backtrader as bt

class SmaCross(bt.Strategy):
    params = dict(fast=10, slow=30)
    def __init__(self):
        sma1 = bt.ind.SMA(period=self.p.fast)
        sma2 = bt.ind.SMA(period=self.p.slow)
        self.crossover = bt.ind.CrossOver(sma1, sma2)
    def next(self):
        if self.crossover > 0: self.buy()
        elif self.crossover < 0: self.sell()

cerebro = bt.Cerebro()
cerebro.addstrategy(SmaCross)
cerebro.broker.setcash(100000)
cerebro.run()
```

== 其他框架

- *Backtesting.py*：更轻量，交互式图表，适合快速验证想法
- *Zipline*：Quantopian出品，事件驱动，适合深入理解量化逻辑
- *vectorbt*：向量化计算，极快，适合大规模参数优化

== 一站式平台

- #link("https://openbb.co/")[OpenBB]：开源金融分析终端，集成数十个数据源，有AI辅助
- #link("https://www.quantconnect.com/")[QuantConnect]：云端回测+实盘，免费tier够用

= 我的想法

美股的优势在于市场制度更成熟、长期趋势更明确、ETF体系完善。即使不做量化，简单的指数定投（SPY/QQQ）长期回报也远好于A股散户炒个股。

对于想入门量化的路线：
+ `yfinance + backtrader` 跑通一个简单回测
+ 注册 Seeking Alpha 了解美股投研生态
+ 用 Alpaca 的 paper trading 接入模拟盘
+ 需要更精细数据时升级到 Polygon.io

核心不是要成为量化高手，而是*用系统性的方法替代拍脑袋决策*。
