title: "第10章 sessions_spawn —— 多智能体协作的核心原语"
date: 2026-05-10
category: "02 multi agent"
tags: []
collections: ["openclaw"]
weight: 10

OpenClaw 的多智能体协作不是靠“偷偷起一个线程”实现的，而是靠一个明确的会话工具：`sessions_spawn`。

当前源码里，它的职责很单纯：

> 在隔离会话里启动一个子智能体运行，并在完成后把结果 announce 回请求方聊天渠道。

## 它到底生成了什么

普通 sub-agent 的会话键长这样：

```text
agent:<agentId>:subagent:<uuid>
```

所以 `sessions_spawn` 的本质不是“多开一个 prompt”，而是：

- 新建独立 session
- 用这个 session 跑一次 agent turn
- 完成后用 announce 机制把结果发回父会话所在聊天渠道

这就是它和“主会话里继续思考”最大的区别。

## 当前源码里的参数

根据 `src/agents/subagent-spawn.ts` 和官方文档，当前稳定参数是：

```typescript
{
  task: string;
  label?: string;
  agentId?: string;
  model?: string;
  thinking?: string;
  runTimeoutSeconds?: number;
  thread?: boolean;
  mode?: "run" | "session";
  cleanup?: "delete" | "keep";
}
```

这里没有当前源码支持的“预定义任务模板”机制，那部分旧写法已经不应该再出现在博客里。

## 每个参数该怎么理解

### `task`

必填。就是子智能体第一条收到的任务描述。

```json
{
  "task": "分析这个 PR，列出可能的逻辑回归和安全风险"
}
```

### `label`

可选。给这次子任务一个人类可读标签，方便 `/subagents list`、日志和状态页面查看。

### `agentId`

可选。让子任务切换到另一个 agent 配置上运行。

但它不是随便填的。当前权限控制走：

```text
agents.list[].subagents.allowAgents
```

默认只允许请求者自己的 agent。你显式放行后，才能把任务派到别的 agent。

### `model` / `thinking`

可选。对子任务做覆盖，不影响父会话自身的默认模型设置。

这很适合下面这种分工：

- 主智能体用更强模型做规划
- 子智能体用更便宜模型跑批量检查

### `runTimeoutSeconds`

可选。超时后中止这次子任务。

如果调用时没填，当前源码会回退到：

```text
agents.defaults.subagents.runTimeoutSeconds
```

再没有，就用 `0`，表示不设超时。

### `thread` + `mode`

这是最容易写错的组合。

#### 一次性任务

默认是一次性运行：

```json
{
  "task": "总结这段日志"
}
```

等价于：

```json
{
  "task": "总结这段日志",
  "thread": false,
  "mode": "run"
}
```

#### 持久线程会话

如果你想让子智能体在一个线程里继续聊，要这样写：

```json
{
  "task": "持续跟进这个排障任务",
  "thread": true,
  "mode": "session"
}
```

当前源码还有一个细节：

- `mode` 省略时，默认是 `run`
- 但如果 `thread: true` 且 `mode` 没写，默认会变成 `session`
- `mode: "session"` 必须搭配 `thread: true`

这点在 `resolveSpawnMode(...)` 和参数校验里都写死了。

### `cleanup`

可选，`delete | keep`，默认 `keep`。

但要注意：

- `mode: "session"` 时，源码会强制保留会话
- `cleanup: "delete"` 主要影响一次性 run 模式

## 返回行为：非阻塞

`sessions_spawn` 不是“同步等子任务跑完”。

当前行为是：

- 工具立即返回 `accepted`
- 返回值里会带 `runId` 和 `childSessionKey`
- 子任务后台执行
- 完成后自动 announce

所以父智能体不应该靠轮询或 sleep 来等它。

## announce 机制才是闭环关键

子智能体完成后，OpenClaw 会跑一个 announce 步骤，把结果投递回请求方聊天渠道。

官方文档明确的几个点：

- announce 在**子会话**里运行，不是在父会话里直接拼文本
- `Status` 来自运行时结果，而不是模型自己写了什么
- 如果 assistant 最终回答为空，会回退取最近的 `toolResult`
- 如果 announce 回复精确等于 `ANNOUNCE_SKIP`，就不发消息

所以 `sessions_spawn` 的完整闭环是：

```text
父会话发起 -> 子会话独立运行 -> announce -> 返回原聊天渠道
```

## 当前真正可配的 subagents 配置

旧文章里常见的那套“预定义任务模板”配置并不存在。当前源码里真正存在、而且最有用的是这些：

```json5
{
  agents: {
    defaults: {
      subagents: {
        model: "openai/gpt-5-mini",
        thinking: "low",
        runTimeoutSeconds: 900,
        maxSpawnDepth: 2,
        maxChildrenPerAgent: 5,
        maxConcurrent: 8,
        archiveAfterMinutes: 60,
      },
    },
    list: [
      {
        id: "main",
        subagents: {
          allowAgents: ["reviewer", "writer"],
        },
      },
    ],
  },
}
```

重点解释：

- `model` / `thinking`：子智能体默认模型与思考等级
- `runTimeoutSeconds`：默认超时
- `maxSpawnDepth`：允许嵌套多深
- `maxChildrenPerAgent`：每个 agent session 最多挂多少活跃子任务
- `maxConcurrent`：全局子任务并发上限
- `archiveAfterMinutes`：完成后多久自动归档
- `allowAgents`：允许派到哪些 agentId

## 线程绑定模式

如果渠道支持 thread binding，`thread: true` 会请求把这个子会话和线程绑在一起。

当前官方文档重点说明的内置渠道是 Discord。典型流程是：

1. `sessions_spawn({ thread: true, mode: "session" })`
2. OpenClaw 创建或绑定一个线程
3. 后续这个线程里的消息继续路由到该子会话
4. 用 `/unfocus` 或超时策略解绑

这和“一次性后台子任务”是完全不同的使用姿势。

## 嵌套深度为什么默认保守

当前默认 `maxSpawnDepth` 是 1，也就是：

- 主会话可以 spawn
- 第一层子会话默认不能再继续 spawn

你把它调到 2，才能实现典型 orchestrator-worker：

```text
main -> orchestrator -> workers
```

官方文档建议不要轻易拉太深，因为：

- 上下文容易层层漂移
- 并发和成本很容易失控
- 调试难度指数上升

## 常见误区

### 误区 1：`sessions_spawn` 可以预定义很多固定任务名

当前源码没有这一层配置。你能配的是默认模型、超时、深度和 allowlist，不是“在配置里注册一批任务模板”。

### 误区 2：它会阻塞主会话直到子任务完成

不会。它设计上就是非阻塞的。

### 误区 3：`mode: "session"` 可以不配 `thread`

不行。当前源码直接拒绝这种组合。

## 本章小结

- `sessions_spawn` 会新建 `agent:<agentId>:subagent:<uuid>` 子会话
- 它默认非阻塞，完成后靠 announce 回传结果
- 当前稳定参数是 `task`、`label`、`agentId`、`model`、`thinking`、`runTimeoutSeconds`、`thread`、`mode`、`cleanup`
- 当前真实配置重点是 `agents.defaults.subagents.*` 和 `agents.list[].subagents.allowAgents`
- 旧文章里那套“预定义任务模板”不是当前 OpenClaw 源码能力

