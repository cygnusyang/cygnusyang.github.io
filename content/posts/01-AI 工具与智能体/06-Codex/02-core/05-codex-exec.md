---
title: "05-codex-exec"
date: 2026-05-18
category: "01 AI 工具与智能体"
---

除了交互式 TUI，Codex 还支持非交互式执行：`codex exec`。

## 基本用法

```bash
codex exec "帮我重构这个 Python 脚本"
```

## 从 stdin 读取

```bash
echo "这个输出是什么意思？" | codex exec "分析一下"
```

或者结合起来：

```bash
git diff | codex exec "帮我写一个提交消息"
```

## 不保存会话（Ephemeral）

```bash
codex exec --ephemeral "快速任务"
```

这样不会在磁盘上保存会话记录。

## 实际例子

### 例子 1：代码审查

```bash
git diff HEAD~1 HEAD | codex exec "审查这些改动有没有问题"
```

### 例子 2：生成文档

```bash
codex exec "给 src/ 目录下的所有文件生成文档"
```

### 例子 3：修复 bug

```bash
codex exec "tests/ 目录下的测试失败了，帮我看看是什么问题"
```

## 日志输出

设置 `RUST_LOG` 环境变量看详细日志：

```bash
RUST_LOG=debug codex exec "任务"
```

## 本章小结

**一句话记住**：`codex exec` 用于自动化脚本和一次性任务。

