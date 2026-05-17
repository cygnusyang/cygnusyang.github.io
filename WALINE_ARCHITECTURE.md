# Waline 评论系统架构说明

## 🏗️ 整体架构

```
┌─────────────────────────────────────────────────────────────┐
│                        用户浏览器                              │
│  ┌──────────────────────────────────────────────────────┐  │
│  │  你的博客 (cygnusyang.github.io)                      │  │
│  │  - Hugo 静态网站                                       │  │
│  │  - FixIt 主题                                          │  │
│  │  - Waline 客户端 (JavaScript)                          │  │
│  └──────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
                              │
                              │ HTTP 请求
                              │ (发表评论、获取评论)
                              ↓
┌─────────────────────────────────────────────────────────────┐
│              Waline 服务器 (Vercel)                           │
│  ┌──────────────────────────────────────────────────────┐  │
│  │  @waline/vercel (Node.js 应用)                        │  │
│  │  - 接收评论请求                                        │  │
│  │  - 验证评论内容                                        │  │
│  │  - 反垃圾过滤                                          │  │
│  │  - 存储到数据库                                        │  │
│  └──────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
                              │
                              │ 数据库连接
                              │
                              ↓
┌─────────────────────────────────────────────────────────────┐
│                    数据库 (存储评论)                          │
│  ┌──────────────────────────────────────────────────────┐  │
│  │  支持的数据库：                                         │  │
│  │  - PostgreSQL (Supabase, Neon)                         │  │
│  │  - LeanCloud (已有账号可用)                             │  │
│  │  - MySQL                                               │  │
│  │  - PostgreSQL (Supabase, Neon)                         │  │
│  │  - SQLite                                              │  │
│  │  - MongoDB                                             │  │
│  └──────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

## 📝 工作流程

### 1. 用户发表评论

```
用户浏览器 → 博客页面 → Waline 客户端 → Waline 服务器 → 数据库
```

**步骤：**
1. 用户在博客页面填写评论（昵称、邮箱、评论内容）
2. Waline 客户端（JavaScript）将评论发送到 Waline 服务器
3. Waline 服务器验证评论内容（反垃圾过滤）
4. Waline 服务器将评论存储到数据库
5. Waline 服务器返回成功响应
6. Waline 客户端更新页面显示新评论

### 2. 用户查看评论

```
用户浏览器 → 博客页面 → Waline 客户端 → Waline 服务器 → 数据库
```

**步骤：**
1. 用户打开博客文章页面
2. Waline 客户端自动请求该文章的评论列表
3. Waline 服务器从数据库查询评论
4. Waline 服务器返回评论列表
5. Waline 客户端渲染评论列表

## 🔧 配置说明

### 博客端配置 (hugo.toml)

```toml
[params.page.comment]
  enable = true
  
  [params.page.comment.waline]
    enable = true
    serverURL = "https://your-waline.vercel.app"  # Waline 服务器地址
    lang = "zh-CN"
    visitor = true
    emoji = ["https://cdn.jsdelivr.net/gh/walinejs/emojis@1.0.0/weibo"]
    requiredMeta = ["nick", "mail"]
    wordLimit = 0
    pageSize = 10
```

**作用：**
- 告诉 FixIt 主题使用 Waline 评论系统
- 指定 Waline 服务器的地址
- 配置评论功能（表情包、必填字段等）

### Waline 服务器配置 (Vercel 环境变量)

Waline 服务器通过环境变量连接数据库：

#### 使用 LeanCloud（已有账号可用）

```bash
LEAN_ID=你的_App_ID
LEAN_KEY=你的_App_Key
LEAN_MASTER_KEY=你的_Master_Key
```

#### 使用 PostgreSQL (Supabase)

推荐使用 `PG_*`：

```bash
PG_DB=postgres
PG_USER=postgres
PG_PASSWORD=你的 Supabase 数据库密码
PG_HOST=db.xxxxxx.supabase.co
PG_PORT=5432
PG_SSL=true
PG_PREFIX=wl_
```

也可以使用 Waline 支持的 `POSTGRES_*` 别名：

```bash
POSTGRES_DATABASE=postgres
POSTGRES_USER=postgres
POSTGRES_PASSWORD=你的 Supabase 数据库密码
POSTGRES_HOST=db.xxxxxx.supabase.co
POSTGRES_PORT=5432
POSTGRES_SSL=true
POSTGRES_PREFIX=wl_
```

#### 使用 MySQL

```bash
MYSQL_HOST=你的数据库地址
MYSQL_PORT=3306
MYSQL_DB=数据库名
MYSQL_USER=用户名
MYSQL_PASSWORD=密码
```

#### 使用 SQLite

```bash
SQLITE_PATH=/app/data
```

#### 使用 MongoDB

```bash
MONGODB_URL=mongodb://用户名:密码@地址:端口/数据库
```

## 🗄️ 数据库表结构

### PostgreSQL 表结构 (waline.pgsql)

```sql
-- 评论表
CREATE TABLE wl_comment (
  id int PRIMARY KEY,
  user_id int,
  comment text,
  insertedAt timestamp,
  ip varchar(100),
  link varchar(255),
  mail varchar(255),
  nick varchar(255),
  pid int,
  rid int,
  sticky numeric,
  status varchar(50),
  "like" int,
  ua text,
  url varchar(255),
  createdAt timestamp,
  updatedAt timestamp
);

-- 计数器表
CREATE TABLE wl_counter (
  id int PRIMARY KEY,
  time int,
  reaction0 int,
  reaction1 int,
  reaction2 int,
  reaction3 int,
  reaction4 int,
  reaction5 int,
  reaction6 int,
  reaction7 int,
  reaction8 int,
  url varchar(255),
  createdAt timestamp,
  updatedAt timestamp
);

-- 用户表
CREATE TABLE wl_users (
  id int PRIMARY KEY,
  display_name varchar(50),
  email varchar(255),
  password varchar(255),
  type varchar(20),
  label varchar(50),
  avatar varchar(255),
  url varchar(255),
  insertedAt timestamp,
  updatedAt timestamp
);
```

## 🔍 当前问题诊断

### 问题：Waline 服务器返回 500 错误

**错误信息：**
```
Error: No valid storage found. Please check your environment variables.
```

**可能原因：**

1. **环境变量名称不正确**
   - Waline 使用 Supabase 时需要 `PG_*` 或 `POSTGRES_*`
   - 只配置 `SUPABASE_URL` / `SUPABASE_KEY` 不足以让 Waline 连接数据库

2. **环境变量未正确配置**
   - 环境变量值可能为空
   - 环境变量可能未应用到正确的环境（Production）

3. **数据库连接失败**
   - 数据库地址不正确
   - 数据库密码不正确
   - 数据库端口不正确

4. **数据库表不存在**
   - 表名不匹配（Waline 期望 `wl_comment` 而不是 `waline_comment`）
   - 表结构不正确

## 🛠️ 解决方案

### 方案 1：确认 Supabase PostgreSQL 配置

**需要确认：**
- Vercel 环境变量使用 `PG_*` 或 `POSTGRES_*`
- `PG_HOST` 是 `db.xxxxxx.supabase.co`
- `PG_PORT=5432`
- `PG_SSL=true`
- Supabase SQL Editor 已导入 Waline 官方 `waline.pgsql`
- 表名是 `wl_comment`、`wl_users`、`wl_counter`
- 修改环境变量后已经在 Vercel 重新部署

### 方案 2：使用 LeanCloud 国际版（仅限已有账号）

**步骤：**
1. 登录 [LeanCloud 国际版](https://console.leancloud.app/)
2. 创建应用
3. 配置环境变量：
   ```
   LEAN_ID=你的_App_ID
   LEAN_KEY=你的_App_Key
   LEAN_MASTER_KEY=你的_Master_Key
   ```
4. 重新部署

### 方案 3：回退到 Giscus

**原因：**
- Giscus 配置最简单
- 不需要服务器
- 不需要数据库

**缺点：**
- 需要 GitHub 账户登录
- 不支持匿名评论

## 📚 参考资料

- [Waline 官方文档](https://waline.js.org/)
- [Waline GitHub](https://github.com/walinejs/waline)
- [Waline 数据库配置](https://github.com/walinejs/waline/blob/main/docs/src/en/guide/database.md)
