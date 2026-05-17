---
title: "15-skills-system"
date: 2026-05-18
category: "01 AI 工具与智能体"
---

Codex 的 Skills 系统允许给 AI 注入特定领域的知识。

> **📘 深度阅读**：本文是技能系统的简要介绍。详细的技能系统深入、50+ 内置技能解析和实战场景，请参阅 [技能系统深入 —— 50+ 内置技能与实战场景](./../04-advanced/14-skills-in-depth.md)。

## Skills 是什么

Skills 是预定义的提示词和知识，帮助 AI 更好地完成特定任务。

## Skills Crate

**位置**：`source/codex/codex-rs/skills/`

核心技能定义在这个 crate 中。

## Core Skills

Codex 自带核心技能，参考 `source/codex/codex-rs/core-skills/`。

## 技能类型

### 1. 任务指导技能

帮助 AI 理解如何完成特定类型的任务。

### 2. 领域知识技能

注入特定领域的专业知识。

### 3. 风格指导技能

指导 AI 的输出风格和格式。

## SDK

Codex 提供了 SDK 用于构建自定义技能：

- **TypeScript SDK**：`source/codex/sdk/typescript/`
- **Python SDK**：`source/codex/sdk/python/`
- **Python Runtime**：`source/codex/sdk/python-runtime/`

## 使用技能

技能通过配置或插件加载，AI 在对话中会自动应用相关技能。

## 本章小结

**一句话记住**：Skills 给 AI 注入专业知识，可通过 SDK 自定义。

