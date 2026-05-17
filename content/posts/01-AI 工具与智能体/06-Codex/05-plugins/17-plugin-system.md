---
title: "17-plugin-system"
date: 2026-05-18
category: "01 AI 工具与智能体"
---

Codex 有完整的插件系统架构，虽然与 Claude Code 不同，但设计思想类似。

## Plugin Crate

**位置**：`source/codex/codex-rs/plugin/`

插件加载、管理和执行的核心逻辑。

## App Server 协议族

IDE 集成通过 App Server 实现，有一系列专门的 crate：

```
app-server/              # 服务器实现
app-server-client/       # 客户端
app-server-protocol/     # 协议定义
app-server-transport/    # 传输层
app-server-test-client/  # 测试客户端
```

## 协议版本

App Server 协议有 v1 和 v2 两个版本：
- **v1**: 遗留版本
- **v2**: 活跃开发版本，所有新 API 都在这里

### v2 协议约定

- 有效负载命名一致：`*Params` 用于请求，`*Response` 用于响应，`*Notification` 用于通知
- RPC 方法暴露为 `<resource>/<method>`，资源保持单数
- 在线上总是使用 camelCase 字段，配合 `#[serde(rename_all = "camelCase")]`
- 例外：配置 RPC 有效负载使用 snake_case 以镜像 config.toml 键
- 总是在 v2 请求/响应/通知类型上设置 `#[ts(export_to = "v2/")]`
- 从不为 v2 API 有效负载字段使用 `#[serde(skip_serializing_if = "Option::is_none")]`
- 例外：客户端到服务器请求，如果有意没有参数，可以使用
- 保持 Rust 和 TS 重命名一致
- 对于区分联合，在两个序列化器中使用显式标记

### 开发工作流

- API 行为变化时更新文档/示例（至少 `app-server/README.md`）
- API 形状变化时重新生成 schema 固定文件：`just write-app-server-schema`
- 使用 `cargo test -p codex-app-server-protocol` 验证

## 可发现工具

插件系统支持工具发现：
- `tool_search` 工具
- `request_plugin_install` 工具

## 协作模式

支持多用户协作：
- spawn/send/wait/close 工具
- `request_user_input` 工具
- CSV fanout/reporting 工具

## 与 Claude Code 插件的区别

Codex 的插件系统更集成在核心中，而 Claude Code 有独立的插件架构。但两者都支持：
- 自定义工具
- MCP 集成
- 技能注入

## 本章小结

**一句话记住**：Codex 的 Plugin 系统与 App Server 协议配合，支持 IDE 集成和扩展。

