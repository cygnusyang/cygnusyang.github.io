---
title: "11-state-system"
date: 2026-05-18
category: "01 AI 工具与智能体"
---

Codex 记住了你上周的 17 个会话，不是存在内存里，而是存在 SQLite 数据库里。重启 Codex 后一切都还在。

Codex 使用 SQLite 数据库来持久化会话状态、记忆、分析等数据。

`★ Insight ─────────────────────────────────────`
**SQLite 的版本化演进艺术**
31个迁移文件不仅记录了数据结构变化，更体现了系统的演进历程。每个迁移文件都是系统成长的"里程碑"，支持零停机升级。这种设计让 Codex 可以在用户不知情的情况下平滑演进，旧数据库自动迁移到新版本。
`─────────────────────────────────────────────────`

## State Crate 结构

**位置**：`source/codex/codex-rs/state/`

```
state/
├── src/                     # 源代码
├── migrations/              # 数据库迁移（31 个！）
└── logs_migrations/         # 日志迁移
```

## 数据库迁移

使用 SQL 迁移文件管理数据库 schema 版本，从 001 到 031，说明这是一个不断演进的系统。

迁移文件例子（简化版）：
```sql
-- 001_initial.up.sql
CREATE TABLE rollouts (
    id TEXT PRIMARY KEY,
    created_at INTEGER NOT NULL,
    updated_at INTEGER NOT NULL
);

-- 002_add_memories.up.sql
CREATE TABLE memories (
    id TEXT PRIMARY KEY,
    rollout_id TEXT NOT NULL REFERENCES rollouts(id),
    raw_memory TEXT NOT NULL,
    generated_at INTEGER NOT NULL
);
```

## 日志查看

提供了一个日志客户端：

```bash
just log
```

可以查看状态 SQLite 数据库中的日志。

## 数据模型

从迁移文件数量可以推测，数据库包含：
- 会话（rollouts）
- 记忆（Phase 1、Phase 2）
- 分析数据
- 配置状态
- 等等...

`★ Insight ─────────────────────────────────────`
**State DB 的协调者角色**
State DB 不仅仅是数据存储，更是分布式协调系统。Phase 1 的任务租用和 Phase 2 的全局锁都在这里实现，确保多进程环境下不会产生冲突。这种设计让 Codex 可以安全地运行多个实例，同时共享同一个记忆库。
`─────────────────────────────────────────────────`

## 并发与协调

State DB 用于：
- Phase 1 任务租用（防止重复工作）
- Phase 2 全局锁
- 记忆使用计数和最后使用时间跟踪
- 水印追踪

## 实际例子：数据库位置

数据库文件通常在这里：
- **macOS/Linux**: `~/.codex/state.db`
- **Windows**: `%USERPROFILE%\.codex\state.db`

## 实战案例：查看你的记忆库

```bash
# 查看数据库中的会话数量
sqlite3 ~/.codex/state.db "SELECT COUNT(*) FROM rollouts;"

# 查看最近生成的记忆
sqlite3 ~/.codex/state.db "
SELECT id, generated_at, substr(raw_memory, 1, 100)
FROM memories
ORDER BY generated_at DESC
LIMIT 5;
"
```

## 避坑指南

### 坑：直接修改数据库文件

❌ **错误做法**：用 SQLite GUI 直接编辑 state.db
❌ **原因**：可能损坏正在运行的进程
❌ **后果**：Codex 可能无法启动或数据丢失

✅ **正确做法**：使用只读查询查看数据，修改通过 Codex API

### 坑：备份时忽略数据库

❌ **错误做法**：只备份 `~/.codex/memories/`，不备份 `state.db`
❌ **原因**：缺少协调数据，记忆系统无法恢复
❌ **后果**：记忆系统异常，Phase 1/Phase 2 无法正常运行

✅ **正确做法**：
```bash
# 备份完整状态
tar -czf codex-backup-$(date +%Y%m%d).tar.gz \
  ~/.codex/state.db \
  ~/.codex/memories/ \
  ~/.config/codex/config.toml
```

## 本章小结

**一句话记住**：State 系统使用 SQLite + 迁移来持久化所有数据，包括会话、记忆和协调信息。

**核心要点**：
1. **版本化迁移**：31个迁移文件支持零停机升级
2. **协调功能**：任务租用、全局锁防止并发冲突
3. **数据备份**：记住同时备份 state.db 和 memories/

**下一步**：了解 Tools 系统如何从 core 中独立出来（第十二章）。

