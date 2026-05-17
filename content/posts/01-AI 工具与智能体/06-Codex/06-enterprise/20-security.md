---
title: "20-security"
date: 2026-05-18
category: "01 AI 工具与智能体"
---

Codex 从设计之初就考虑了安全，采用多层防护策略。

## 安全边界

参考：[Agent approvals & security](https://developers.openai.com/codex/agent-approvals-security)

## 多层安全模型

### Layer 1: 沙箱执行（Sandbox）
- **macOS**: Seatbelt sandbox
- **Linux**: Landlock + bubblewrap
- **Windows**: Windows sandbox
- 三种模式：read-only / workspace-write / danger-full-access

### Layer 2: 批准机制（Approvals）
- 工具执行前的用户确认
- 可配置的批准策略
- 会话级别的信任

### Layer 3: 网络控制（Network Controls）
- 默认禁止网络访问
- 显式启用需要的网络访问
- 沙箱内网络隔离

### Layer 4: 秘密管理（Secrets）
- 不在日志中记录敏感信息
- 记忆生成时删除敏感信息
- 安全的 API Key 存储

### Layer 5: 协作安全（Collaboration）
- 多用户场景的权限控制
- 会话隔离
- 代理委托限制

## 报告安全问题

通过 Bugcrowd 报告：[https://bugcrowd.com/engagements/openai](https://bugcrowd.com/engagements/openai)

## 安全最佳实践

1. 默认使用 `read-only` 沙箱模式
2. 只在需要时使用 `workspace-write`
3. 绝不在非隔离环境中使用 `danger-full-access`
4. 定期审查 `~/.codex/memories/` 中的敏感信息
5. 使用 ChatGPT 账号而不是 API Key（更安全）

## 本章小结

**一句话记住**：Codex 采用多层安全模型 —— 沙箱 + 批准 + 网络控制 + 秘密管理 + 协作安全。

