---
title: "07-mcp-client"
date: 2026-05-18
category: "01 AI 工具与智能体"
---

Codex 是一个 **MCP（Model Context Protocol）客户端**，可以连接各种 MCP 服务器。

## 什么是 MCP

MCP（Model Context Protocol）是一个开放协议，让 AI 代理能够连接外部工具和数据源。

## 配置 MCP 服务器

在 `~/.config/codex/config.toml` 里配置：

```toml
[mcp-servers]
[mcp-servers.my-server]
command = "node"
args = ["/path/to/server.js"]
```

## 管理 MCP 服务器

Codex 提供了 `codex mcp` 命令来管理：

```bash
# 列出已配置的 MCP 服务器
codex mcp list

# 添加 MCP 服务器
codex mcp add my-server "node /path/to/server.js"

# 移除 MCP 服务器
codex mcp remove my-server
```

## Codex 作为 MCP 服务器

Codex 也可以作为 MCP 服务器运行：

```bash
codex mcp-server
```

这样其他 MCP 客户端就能用 Codex 作为工具了。

## 测试 MCP 服务器

用 MCP Inspector 测试：

```bash
npx @modelcontextprotocol/inspector codex mcp-server
```

## 本章小结

**一句话记住**：Codex 既是 MCP 客户端（连接外部工具），也可以作为 MCP 服务器（给别人用）。

