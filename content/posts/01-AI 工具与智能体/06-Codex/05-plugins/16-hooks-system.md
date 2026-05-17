---
title: "16-hooks-system"
date: 2026-05-18
category: "01 AI 工具与智能体"
---

Codex 的 Hooks 系统允许在特定事件发生时自动执行逻辑。

## Hooks Crate 结构

**位置**：`source/codex/codex-rs/hooks/`

```
hooks/
├── src/
│   ├── lib.rs              # 主入口
│   ├── types.rs            # 类型定义
│   ├── events/             # 事件定义
│   │   └── ...
│   ├── engine/             # 执行引擎
│   ├── registry.rs         # 钩子注册表
│   ├── schema.rs           # JSON Schema
│   ├── config_rules.rs     # 配置规则
│   └── legacy_notify.rs    # 兼容旧的 notify
└── bin/
    └── write_hooks_schema_fixtures.rs
```

## 事件类型

Hooks 系统支持多种事件：

### 1. PreToolUse
在工具执行前触发，可用于：
- 验证参数
- 检查安全策略
- 记录日志

### 2. PostToolUse
在工具执行后触发，可用于：
- 处理结果
- 清理资源
- 通知用户

### 3. SessionStart
会话开始时触发。

### 4. SessionEnd
会话结束时触发。

## 钩子类型

### 1. Prompt Hooks
提示词钩子，给 AI 注入额外的上下文。

### 2. Command Hooks
命令钩子，执行外部命令。

## Schema 系统

Hooks 有完整的 JSON Schema 定义，参考 `schema.rs`。

生成 Schema：
```bash
just write-hooks-schema
```

## 配置方式

在 `config.toml` 中配置钩子规则。

## 与 Claude Code 的区别

Codex 的 Hooks 系统与 Claude Code 类似但实现不同，因为 Codex 是 Rust 编写的。

## 本章小结

**一句话记住**：Hooks 是事件驱动的自动化，支持多种事件类型和钩子类型。

