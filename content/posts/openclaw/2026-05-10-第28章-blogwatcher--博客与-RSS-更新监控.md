title: "第28章 blogwatcher —— 博客与 RSS 更新监控"
date: 2026-05-10
category: "06 builtin skills"
tags: []
collections: ["openclaw"]
weight: 28
---

你关注了多少个技术博客？10 个？20 个？还是更多？

每天打开浏览器，逐个访问这些网站，看看有没有新文章发布，这听起来是不是很枯燥？更糟糕的是，你可能会错过那些真正重要的更新——因为谁有时间和耐心每天检查几十个网站呢？

RSS 订阅确实是个解决方案，但传统的 RSS 阅读器往往功能有限，要么不支持智能过滤，要么无法与你的工作流无缝集成。你想要的是一个能够：
- 自动监控你关注的博客和 RSS feeds
- 实时检测新文章发布
- 智能管理阅读状态
- 与你的日常工作环境无缝衔接

这样的工具存在吗？

OpenClaw 内置的 `blogwatcher` skill 就是为此而生的。

## blogwatcher 是什么

当前内置 `blogwatcher` skill 的描述很直接：

> 使用 `blogwatcher` CLI 监控博客和 RSS/Atom feed 的更新。

这说明它的能力边界是：

- 跟踪 feed / 博客
- 扫描更新
- 管理文章阅读状态

## 依赖是什么

`blogwatcher` skill 当前通过 `metadata.openclaw.requires.bins` 要求本机存在：

```text
blogwatcher
```

文档里给的安装方式是：

```bash
go install github.com/Hyaxia/blogwatcher/cmd/blogwatcher@latest
```

## 当前 skill 里写明的常用命令

官方 skill 文本列出的常用操作包括：

```bash
blogwatcher add "My Blog" https://example.com
blogwatcher blogs
blogwatcher scan
blogwatcher articles
blogwatcher read 1
blogwatcher read-all
blogwatcher remove "My Blog"
```

这就是当前工程里“博客更新监控”能力的真实接口。

## 它适合干什么

最适合的场景是：

- 追博客更新
- 跟 RSS/Atom feed
- 周期性扫描新文章
- 把文章标记为已读/未读

如果要做更复杂的"摘要工作流"，可以由智能体和其他工具组合实现。

## 本章小结

- `blogwatcher` 是一个用于监控博客和 RSS/Atom feed 更新的内置 skill
- 它依赖本地 `blogwatcher` CLI，主要做 feed/blog 跟踪、扫描和阅读状态管理
- 适合追博客更新、跟 RSS/Atom feed、周期性扫描新文章等场景

