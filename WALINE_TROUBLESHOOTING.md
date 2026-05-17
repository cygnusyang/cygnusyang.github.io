# Waline 500 错误诊断指南

## 🔴 当前问题

Waline 服务返回 500 错误：`FUNCTION_INVOCATION_FAILED`

## 🔍 诊断步骤

### 1. 检查环境变量名称

Waline 支持多种数据库，环境变量名称不同：

#### 使用 LeanCloud（默认）
```
LEAN_ID=你的_App_ID
LEAN_KEY=你的_App_Key
LEAN_MASTER_KEY=你的_Master_Key
```

#### 使用 Supabase / PostgreSQL（当前推荐）

Waline 使用 Supabase 时不是通过 `SUPABASE_URL` / `SUPABASE_KEY` 连接 Supabase API，而是把 Supabase 当作 PostgreSQL 数据库直连。因此 Vercel 环境变量应使用 `PG_*` 或 `POSTGRES_*`。

推荐使用 `PG_*`：

```
PG_DB=postgres
PG_USER=postgres
PG_PASSWORD=你的 Supabase 数据库密码
PG_HOST=db.xxxxxx.supabase.co
PG_PORT=5432
PG_SSL=true
PG_PREFIX=wl_
```

或使用等价的 `POSTGRES_*`：

```
POSTGRES_DATABASE=postgres
POSTGRES_USER=postgres
POSTGRES_PASSWORD=你的 Supabase 数据库密码
POSTGRES_HOST=db.xxxxxx.supabase.co
POSTGRES_PORT=5432
POSTGRES_SSL=true
POSTGRES_PREFIX=wl_
```

#### 使用 MySQL
```
MYSQL_HOST=你的数据库地址
MYSQL_PORT=3306
MYSQL_DB=数据库名
MYSQL_USER=用户名
MYSQL_PASSWORD=密码
```

### 2. 检查 Vercel 环境变量

1. 访问 [Vercel Dashboard](https://vercel.com/dashboard)
2. 进入 `cygnus-blog-comments` 项目
3. 点击 **"Settings"** → **"Environment Variables"**
4. 确认以下内容：
   - ✅ 环境变量名称正确
   - ✅ 环境变量值正确
   - ✅ 环境变量已应用到所有环境（Production、Preview、Development）

### 3. 重新部署

修改环境变量后，需要重新部署：

1. 在 Vercel Dashboard 中，点击 **"Deployments"** 标签
2. 找到最新的部署
3. 点击右侧的 **"..."** 菜单
4. 选择 **"Redeploy"**
5. 等待部署完成

### 4. 检查部署日志

如果仍然 500 错误，查看部署日志：

1. 在 Vercel Dashboard 中，点击 **"Deployments"** 标签
2. 点击最新的部署
3. 查看 **"Build Logs"** 和 **"Function Logs"**
4. 查找错误信息

### 5. 检查数据库连接

#### Supabase 连接测试

在 Supabase Dashboard 中：

1. 点击 **"SQL Editor"**
2. 运行以下查询：

```sql
-- 检查表是否存在
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
  AND table_name IN ('wl_comment', 'wl_users', 'wl_counter');
```

应该返回 3 个表名。

3. 检查表结构：

```sql
-- 检查 wl_comment 表结构
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'wl_comment'
  AND table_schema = 'public';
```

如果这些表不存在，请在 Supabase SQL Editor 中导入 Waline 官方 PostgreSQL 建表脚本：

```
https://raw.githubusercontent.com/walinejs/waline/main/assets/waline.pgsql
```

### 6. 常见错误及解决方案

#### 错误 1：环境变量未设置
**症状**：500 错误，日志显示 `undefined` 或 `missing`
**解决**：检查环境变量名称和值

#### 错误 2：数据库表不存在
**症状**：500 错误，日志显示 `relation does not exist`
**解决**：在 Supabase SQL Editor 中运行建表脚本

#### 错误 3：数据库连接失败
**症状**：500 错误，日志显示 `connection refused` 或 `timeout`
**解决**：检查 `PG_HOST`、`PG_PORT`、`PG_USER`、`PG_PASSWORD`、`PG_SSL` 是否正确

#### 错误 4：权限问题
**症状**：500 错误，日志显示 `permission denied`
**解决**：确认使用的是 Waline 官方表结构；如启用了 RLS，需要确认策略允许 Waline 服务端需要的读写操作

## 🛠️ 快速修复

### 方案 1：检查 Supabase PostgreSQL 配置

1. 确认 Vercel 使用的是 `PG_*` 或 `POSTGRES_*` 环境变量，而不是只配置 `SUPABASE_URL` / `SUPABASE_KEY`
2. 确认 `PG_HOST` 形如 `db.xxxxxx.supabase.co`
3. 确认 `PG_PORT=5432`
4. 确认 `PG_SSL=true`
5. 确认 Supabase SQL Editor 已导入 Waline 官方 `waline.pgsql`
6. 确认表名是 `wl_comment`、`wl_users`、`wl_counter`
7. 修改环境变量后，在 Vercel 重新部署

### 方案 2：使用 LeanCloud（仅限已有账号）

如果你已经有 LeanCloud 国际版账号，也可以使用 LeanCloud：

1. 登录 [LeanCloud 国际版](https://console.leancloud.app/)
2. 创建应用
3. 配置环境变量：
   ```
   LEAN_ID=你的_App_ID
   LEAN_KEY=你的_App_Key
   LEAN_MASTER_KEY=你的_Master_Key
   ```
4. 重新部署

## 📞 获取帮助

如果以上方法都无法解决问题：

1. 查看 [Waline 官方文档](https://waline.js.org/guide/get-started.html)
2. 查看 [Waline GitHub Issues](https://github.com/walinejs/waline/issues)
3. 在 Vercel Dashboard 中查看详细日志

## 🔄 回退到 Giscus

如果 Waline 配置太复杂，可以暂时使用 Giscus：

编辑 [`hugo.toml`](./hugo.toml)：

```toml
[params.page.comment.waline]
  enable = false  # 禁用 Waline

[params.page.comment.giscus]
  enable = true   # 启用 Giscus
```

Giscus 不需要服务器配置，只需要 GitHub 账号即可。
