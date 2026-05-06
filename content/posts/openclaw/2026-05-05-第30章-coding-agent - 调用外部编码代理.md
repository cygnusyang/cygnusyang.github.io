---
title: 第30章：coding-agent —— 调用外部编码代理
date: 2026-05-05
category: 06 builtin skills
tags: [06 builtin skills]
collections: ["openclaw"]
weight: 30
---

面对一个复杂的新功能开发任务，你是否有过这样的经历：

- 需要深入理解整个代码库的结构和设计模式
- 要在多个文件之间来回切换，理解上下文关系
- 编写代码时需要不断查阅文档和参考实现
- 代码写完后还要进行全面的测试和 review

这些工作如果完全靠人工完成，不仅耗时耗力，还容易出错。你可能会想：如果有一个专业的编码助手能够帮我处理这些复杂的编码任务，那该多好？

现在市面上确实有很多优秀的编码工具——Codex、Claude Code、Pi、OpenCode 等等。但问题是，它们各自独立运行，无法与你的工作流无缝集成。你需要在不同的工具之间切换，打断你的开发节奏。

如果能够把这些强大的编码代理统一纳入你的工作流，让它们在你需要的时候自动介入，处理那些复杂的编码任务，那会是一种怎样的体验？

OpenClaw 内置的 `coding-agent` skill 就能帮你实现这一点。

## `coding-agent` 是什么

当前 `coding-agent` skill 的描述非常明确：

> 通过后台进程委托 Codex、Claude Code、Pi、OpenCode 这类编码代理处理复杂编码任务。

这说明它的本质不是“营销工作台”，而是**把外部编码代理纳入 OpenClaw 工作流**。

## 它什么时候适合用

skill 文本里列出的典型场景包括：

- 新功能开发
- PR review
- 大型重构
- 需要大量文件探索和迭代的编码任务

同时也明确写了不适合：

- 很小的一行修复
- 纯读代码问题
- 在 `~/clawd` 工作区里乱开代理

## 当前依赖

这个 skill 需要宿主机至少有一个可用编码代理二进制，例如：

- `claude`
- `codex`
- `opencode`
- `pi`

并且特别强调：

> 运行这类编码代理时要使用 `pty:true`

这和当前 exec / process 工具的 PTY 支持是严格对应的。

## 当前 skill 反映出的真实实践

`coding-agent` skill 里反复强调三件事：

1. 用 `bash` / `exec` 驱动外部编码代理
2. 长任务放后台执行
3. 通过 `process` 轮询、写入、终止会话

这与当前 OpenClaw 的工具面完全对齐：

- `exec`
- `process`
- `pty`
- `background`

## 本章小结

- `coding-agent` 是一个用于调用外部编码代理处理复杂编码任务的内置 skill
- 它用于把 Codex、Claude Code、Pi、OpenCode 等编码代理纳入 OpenClaw 编排
- 它和当前 `exec` / `process` / PTY / 后台任务模型完全一致
- 适合新功能开发、PR review、大型重构等复杂编码任务
