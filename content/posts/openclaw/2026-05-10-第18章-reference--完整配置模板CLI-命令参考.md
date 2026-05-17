title: "第18章 reference —— 完整配置、模板、CLI 命令参考"
date: 2026-05-10
category: "03 core concepts"
tags: []
collections: ["openclaw"]
weight: 18

这一章只保留和当前工程一致的参考信息：配置文件位置、常见顶层结构、工作区模板文件，以及最常用的 CLI 命令族。

## 配置文件位置

当前 OpenClaw 使用的主配置文件是：

```text
~/.openclaw/openclaw.json
```

格式是 **JSON5**，所以允许注释和尾逗号。

## 顶层结构要看什么

源码里的配置非常大，但日常最常碰到的是这些块：

```json5
{
  env: {
    OPENAI_API_KEY: "sk-...",
    ANTHROPIC_API_KEY: "sk-ant-...",
  },

  gateway: {
    port: 18789,
    bind: "127.0.0.1",
  },

  agents: {
    defaults: {
      workspace: "~/.openclaw/workspace",
      models: {
        "anthropic/claude-opus-4-6": { alias: "opus" },
        "openai/gpt-5.2": { alias: "gpt" },
      },
      model: {
        primary: "anthropic/claude-opus-4-6",
        fallbacks: ["openai/gpt-5.2"],
      },
      heartbeat: {
        every: "30m",
      },
    },
    list: [
      {
        id: "main",
      },
    ],
  },

  channels: {
    telegram: {},
    discord: {},
  },

  plugins: {
    enabled: true,
    entries: {},
  },

  tools: {
    profile: "coding",
  },

  skills: {
    entries: {},
  },

  browser: {
    enabled: true,
    defaultProfile: "chrome",
  },

  session: {
    threadBindings: {
      enabled: true,
    },
  },
}
```

这里有几个容易写错的点：

- 主配置路径是 `~/.openclaw/openclaw.json`，不是旧文档里的 `~/.openclaw/openclaw.json`
- `agents.defaults.model` 当前可以是字符串，也可以是 `{ primary, fallbacks }`
- cron job 不建议手工塞在一个旧式的大数组里维护，当前官方流程更偏向 `openclaw cron add/edit`

## 配置校验规则

当前 OpenClaw 的配置校验是严格的：

- 未知字段会报错
- 插件配置按各自 `openclaw.plugin.json` 里的 `configSchema` 校验
- 配置错误会阻止 Gateway 正常启动

排查时最常用命令还是：

```bash
openclaw doctor
openclaw doctor --fix
```

## 当前工作区模板文件

当前参考模板目录里，核心模板是下面这些：

| 文件 | 作用 |
|------|------|
| `BOOTSTRAP.md` | 首次启动时的引导脚本 |
| `BOOT.md` | 更轻量的启动引导模板 |
| `AGENTS.md` | 工作区主规则 |
| `IDENTITY.md` | AI 身份与自我定义 |
| `USER.md` | 用户信息与偏好 |
| `SOUL.md` | 风格、价值观、边界 |
| `TOOLS.md` | 本地工具习惯与偏好 |
| `HEARTBEAT.md` | 心跳任务提示词 |

当前源码文档模板目录里没有把 `MEMORY.md` 列为这套标准模板的一部分，所以这里不应该再把它写成官方固定模板文件。

## 模板应该怎么理解

### `AGENTS.md`

这是工作区主说明书，给 agent 讲清楚：

- 这个工作区怎么协作
- 先读什么文件
- 风格和边界是什么
- 哪些工具偏好是本地约定

### `IDENTITY.md` / `USER.md` / `SOUL.md`

这三个文件分别解决三个不同问题：

- `IDENTITY.md`：我是谁
- `USER.md`：用户是谁
- `SOUL.md`：我们希望长期保持什么风格和价值判断

### `HEARTBEAT.md`

这是定时心跳 run 会参考的提示文件，不是普通对话模板。

### `BOOTSTRAP.md` / `BOOT.md`

这两类文件负责工作区“第一次启动时如何初始化人格和协作方式”，不是长期规则本体。

## CLI 命令族速查

### 配置与初始化

```bash
openclaw setup
openclaw onboard
openclaw configure
openclaw config get <path>
openclaw config set <path> <value>
openclaw config unset <path>
openclaw doctor
```

### 插件

```bash
openclaw plugins list
openclaw plugins info <id>
openclaw plugins install <spec>
openclaw plugins enable <id>
openclaw plugins disable <id>
openclaw plugins update <id>
openclaw plugins update --all
openclaw plugins doctor
```

### Skills

当前 CLI 里稳定存在的 skills 命令是：

```bash
openclaw skills list
openclaw skills info <name>
openclaw skills check
```

安装和发布工作流现在主要走 `clawhub`。

### 浏览器

```bash
openclaw browser profiles
openclaw browser tabs
openclaw browser open <url>
openclaw browser focus <targetId>
openclaw browser close <targetId>
openclaw browser snapshot
openclaw browser screenshot
openclaw browser navigate <url>
openclaw browser click <ref>
openclaw browser type <ref> "<text>"
```

### Cron

```bash
openclaw cron add
openclaw cron edit <job-id>
openclaw cron list
openclaw cron run <job-id>
openclaw cron runs --id <job-id>
openclaw cron rm <job-id>
```

## 现在最容易踩的坑

### 1. 配置文件路径写错

当前工程里应统一为：

```text
~/.openclaw/openclaw.json
```

### 2. 把技能安装理解成 `clawhub` 安装流

当前分发链路已经转向 `clawhub`。

### 3. 模板文件列表

当前参考模板是 `BOOTSTRAP / BOOT / AGENTS / IDENTITY / USER / SOUL / TOOLS / HEARTBEAT` 这一组。

## 本章小结

- 当前主配置文件是 `~/.openclaw/openclaw.json`
- 日常最关键的块是 `gateway`、`agents`、`channels`、`plugins`、`tools`、`skills`、`browser`、`session`
- 官方参考模板当前以 `AGENTS.md`、`BOOTSTRAP.md`、`BOOT.md`、`IDENTITY.md`、`USER.md`、`SOUL.md`、`TOOLS.md`、`HEARTBEAT.md` 为主
- skills 安装/发布链路看 `clawhub`，不是旧式 `openclaw skills` 安装方式

