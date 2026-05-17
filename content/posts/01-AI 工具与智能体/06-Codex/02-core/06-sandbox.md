---
title: "06-sandbox"
date: 2026-05-18
category: "01 AI 工具与智能体"
---

Codex 的一个重要特性是**沙箱执行**，确保 AI 执行命令时不会破坏你的系统。

## 沙箱模式

Codex 支持三种沙箱模式：

### 1. read-only（默认）

只能读文件，不能写，不能访问网络。最安全。

```bash
codex --sandbox read-only
```

### 2. workspace-write

可以读写当前工作区，但不能访问网络。

```bash
codex --sandbox workspace-write
```

### 3. danger-full-access

完全访问，没有限制。只有在你已经在容器/隔离环境里才用这个。

```bash
codex --sandbox danger-full-access
```

## 配置文件设置

在 `~/.config/codex/config.toml` 里：

```toml
sandbox_mode = "workspace-write"  # 或 "read-only"、"danger-full-access"
```

## 测试沙箱

Codex 提供了命令来测试沙箱：

### macOS

```bash
codex sandbox macos ls
```

### Linux

```bash
codex sandbox linux ls
```

### Windows

```bash
codex sandbox windows dir
```

## 沙箱实现

- **macOS**：Seatbelt sandbox
- **Linux**：Landlock + namespaces
- **Windows**：Windows sandbox

可以在 `source/codex/codex-rs/execpolicy/`、`source/codex/codex-rs/linux-sandbox/`、`source/codex/codex-rs/windows-sandbox-rs/` 看到实现。

## 本章小结

**一句话记住**：默认用 read-only，需要写文件用 workspace-write，完全信任才用 danger-full-access。

