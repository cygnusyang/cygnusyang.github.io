---
title: "23-webchat"
date: 2026-05-18
category: "01 AI 工具与智能体"
---

当前官方文档里，WebChat 的定位是：

> 它是一个直接连 Gateway WebSocket 的聊天 UI，不是独立的一套 Web 服务器产品。

## 当前 WebChat 是什么

官方文档给出的定义是：

- WebChat 使用 Gateway 的 WebSocket 接口通信
- 历史记录从 Gateway 获取
- 路由仍然遵循现有 agent / session 规则
- Gateway 不可达时，WebChat 会退成只读

所以它不是“一套单独 session 模型”，也不是“一套单独配置命名空间”。

## 关键行为

当前文档列出的核心行为包括：

- UI 通过 Gateway WebSocket 连接
- 使用 `chat.history`、`chat.send` 和 `chat.inject`
- `chat.inject` 可以直接把助手注释追加到 transcript
- 回复仍然确定性地回到 WebChat

## 和其他渠道的关系

WebChat 不是特殊渠道分支，而是附着在已有 agent/session 体系上。

这意味着：

- 会话规则和消息渠道保持一致
- 不是一套新的旧式 scope 配置
- 默认更接近所选 agent 的主会话

## 当前配置怎么看

当前官方文档明确写了：

> **没有专用的 `webchat.*` 块。**

WebChat 使用的是 Gateway 的公共配置，例如：

- `gateway.port`
- `gateway.bind`
- `gateway.auth.mode`
- `gateway.auth.token`
- `gateway.auth.password`
- `gateway.remote.url`
- `gateway.remote.token`
- `gateway.remote.password`
- `session.*`

所以像下面这些旧配置都不应该再当成官方接口写：

- `webchat.enabled`
- `webchat.bind`
- `webchat.port`
- `webchat.auth`
- 单独主题文件路径

## 当前的理解方式

你可以把 WebChat 想成：

- 一个前端 UI
- 通过 Gateway WebSocket 和 OpenClaw 通信
- 认证、路由、会话都复用 Gateway 现有能力

而不是“Gateway 里又嵌了一个完整 Web 应用产品”。

## 远程使用方式

当前文档提到的远程方案是：

- SSH 隧道
- Tailscale 隧道

这进一步说明 WebChat 仍然围绕 Gateway 自身在工作，而不是要求你单独部署一个 WebChat server。

## 现在应该怎么写部署与访问

更准确的表述是：

1. 启动 Gateway
2. 配好 Gateway 认证
3. WebChat UI 连接到 Gateway WebSocket
4. 如需远程访问，用 SSH 或 Tailscale 把 Gateway 暴露到可信环境

## 本章小结

- 当前 WebChat 是连接 Gateway WebSocket 的聊天 UI
- 它复用 Gateway 的会话、路由和认证，不再有官方 `webchat.*` 独立配置块
- 远程访问主要通过 Gateway 的远程连接方式完成

