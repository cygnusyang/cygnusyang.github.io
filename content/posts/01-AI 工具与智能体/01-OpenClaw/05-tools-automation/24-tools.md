---
title: "24-tools"
date: 2026-05-18
category: "01 AI 工具与智能体"
---

OpenClaw 的工具体系是**按内置工具名、工具组和策略配置**来组织的。

## 当前工具系统的几个核心点

### 1. 工具是一级能力

当前官方文档明确列出的内置重点包括：

- 文件工具：`read`、`write`、`edit`、`apply_patch`
- 运行时工具：`exec`、`bash`、`process`
- 会话工具：`sessions_list`、`sessions_history`、`sessions_send`、`sessions_spawn`、`session_status`
- Web 工具：`web_search`、`web_fetch`
- UI 工具：`browser`、`canvas`
- 自动化工具：`cron`、`gateway`
- 其他：`message`、`nodes`

## 2. 现在强调的是工具策略，不是工具是否内置

当前配置里，最重要的是：

```json5
{
  tools: {
    profile: "coding",
    allow: ["group:fs", "browser"],
    deny: ["group:runtime"],
  },
}
```

其中：

- `profile`：先给一个基础工具集合
- `allow`：追加允许
- `deny`：拒绝优先

## 3. 工具组是当前文档的重要抽象

OpenClaw 现在提供 `group:*` 速记：

- `group:runtime`
- `group:fs`
- `group:sessions`
- `group:memory`
- `group:web`
- `group:ui`
- `group:automation`
- `group:messaging`
- `group:nodes`
- `group:openclaw`

## Tool profiles

当前官方文档列出的基础 profile 有：

- `minimal`
- `coding`
- `messaging`
- `full`

例如：

```json5
{
  tools: {
    profile: "messaging",
    allow: ["slack", "discord"],
  },
}
```

或者：

```json5
{
  tools: {
    profile: "coding",
    deny: ["group:runtime"],
  },
}
```

## 当前最常用的几类工具

### 文件与补丁

- `read`
- `write`
- `edit`
- `apply_patch`

### 进程执行

- `exec`
- `process`

这是当前官方支持的 shell 执行面，带有：

- `workdir`
- `timeout`
- `pty`
- `background`
- `host`
- `security`
- `ask`

### Web 访问

- `web_search`
- `web_fetch`

文档也强调了：

- `web_fetch` 是普通 HTTP 抓取，不执行 JS
- 需要 JS、登录态或页面交互时，应该切到 `browser`

### 会话编排

- `sessions_list`
- `sessions_history`
- `sessions_send`
- `sessions_spawn`
- `session_status`

这是当前 OpenClaw 多智能体和跨会话操作的基础层。

## 插件也可以加工具

- 核心工具先由 OpenClaw 提供
- 插件可以额外注册工具
- 插件工具和核心工具一起进入同一个工具策略体系

所以重点不在“插件工具是额外特例”，而在“最终都受 `tools.*` 策略控制”。

## `exec` 是现在的关键工具之一

当前官方 `Exec tool` 文档里，核心参数包括：

- `command`
- `workdir`
- `env`
- `yieldMs`
- `background`
- `timeout`
- `pty`
- `host`
- `security`
- `ask`
- `node`
- `elevated`

## `web_search` / `web_fetch` 的边界

当前官方文档明确：

- `web_search`：搜索网页
- `web_fetch`：抓静态内容并提取可读文本
- `browser`：JS-heavy、登录态、点击、输入、截图

## 本章小结

- OpenClaw 的工具体系按内置工具名、工具组和策略配置组织
- 真实的关键工具包括 `read/write/edit/apply_patch`、`exec/process`、`web_search/web_fetch`、`browser`、`sessions_spawn`
- 当前配置重点是 `tools.profile`、`tools.allow`、`tools.deny` 和 `group:*`
- 插件工具会并入同一个工具策略体系，而不是一套独立规则

