---
title: "19-configuration-system"
date: 2026-05-18
category: "01 AI 工具与智能体"
---

你的团队需要 Codex 默认使用 workspace-write 沙箱，并且在项目根目录的 `refactor` 技能。编辑 `~/.config/codex/config.toml` 就可以做到。

Codex 使用 TOML 配置文件，配合自动生成的 JSON Schema 提供类型安全的配置。

## 配置文件位置

- **macOS/Linux**: `~/.config/codex/config.toml`
- **Windows**: `%APPDATA%\codex\config.toml`

## 配置 Schema

Codex 从 Rust 类型自动生成 JSON Schema：

```bash
just write-config-schema
```

这保证了配置文档与实际代码始终同步。

## 完整的配置例子

```toml
# ~/.config/codex/config.toml

# 沙箱模式
sandbox_mode = "workspace-write"  # 可选: "read-only", "workspace-write", "danger-full-access"

# 认证配置
[auth]
# 使用 ChatGPT 账号时不需要额外配置
# 使用 API Key 时:
# type = "api-key"
# api_key = "sk-..."

# UI 配置
[ui]
# 主题配置
# theme = "dark"

# 执行配置
[exec]
# 超时设置
# timeout_seconds = 60

# MCP 服务器配置
[mcp-servers]
# GitHub MCP
[mcp-servers.github]
command = "npx"
args = ["-y", "@modelcontextprotocol/server-github"]

# 文件系统 MCP（有限访问）
[mcp-servers.filesystem]
command = "npx"
args = ["-y", "@modelcontextprotocol/server-filesystem", "/path/to/allowed/dir"]

# 自定义 MCP
[mcp-servers.my-team-tools]
command = "uvx"
args = ["my-team-mcp-server"]
```

## 配置层级

Codex 支持多级别配置，优先级从高到低：

1. **命令行参数**（如 `codex --sandbox workspace-write`）
2. **环境变量**（如 `CODEX_CONFIG=...`）
3. **项目级配置**（工作区根目录的 `.codex/config.toml`）
4. **全局配置**（`~/.config/codex/config.toml`）
5. **默认值**

这允许团队共享基础配置，同时个人可以覆盖特定选项。

## MCP 服务器配置

在 `config.toml` 中配置 MCP 服务器：

```toml
[mcp-servers.my-server]
command = "node"
args = ["/path/to/server.js"]
```

也可以用 CLI 管理：
```bash
codex mcp add my-server "node /path/to/server.js"
codex mcp list
codex mcp remove my-server
```

列出已配置的 MCP 服务器：
```
$ codex mcp list
github          enabled
filesystem      enabled
my-team-tools   disabled
```

## 官方配置文档

- [基础配置](https://developers.openai.com/codex/config-basic)
- [高级配置](https://developers.openai.com/codex/config-advanced)
- [完整配置参考](https://developers.openai.com/codex/config-reference)
- [示例配置](https://developers.openai.com/codex/config-sample)

## 本章小结

**一句话记住**：Codex 使用 TOML 配置 + 自动生成的 JSON Schema，支持多级别配置和 MCP 服务器管理。

