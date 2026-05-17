# Supabase + Vercel 快速入门教程

> 5 分钟完成 Waline 评论系统配置，支持匿名评论

> ⚠️ **注意**：LeanCloud 已停止新用户注册，推荐使用 Supabase 作为替代方案。

## 📋 前置准备

- 一个 GitHub 账号（用于 Vercel 登录）
- 一个邮箱地址（用于 Supabase 注册）

---

## 🚀 第一步：注册 Supabase（2 分钟）

### 1.1 注册账号
1. 访问 [Supabase 官网](https://supabase.com/)
2. 点击右上角"Start your project"
3. 使用 GitHub 账号登录或注册

### 1.2 创建项目
1. 登录后，点击 **"New Project"**
2. 填写项目信息：
   - **Name**: `cygnus-blog-comments`（或任意名称）
   - **Database Password**: 设置一个强密码（请记住！）
   - **Region**: 选择 `Southeast Asia (Singapore)` 或 `East Asia (Tokyo)`（国内访问更快）
3. 点击 **"Create new project"**
4. 等待 1-2 分钟，项目创建完成

### 1.3 获取数据库连接信息
1. 进入刚创建的项目
2. 点击左侧菜单 **"Project Settings"** → **"Database"**
3. 找到数据库连接信息，记录以下值：
   - Host：`db.xxxxxx.supabase.co`
   - Port：`5432`
   - Database：通常是 `postgres`
   - User：通常是 `postgres`
   - Password：创建 Supabase 项目时设置的数据库密码

> 注意：Waline 使用 Supabase 时是通过 PostgreSQL 直连，不是通过 `SUPABASE_URL` / `SUPABASE_KEY` 调用 Supabase API。

### 1.4 创建数据库表
1. 点击左侧菜单 **"SQL Editor"**
2. 点击 **"New query"**
3. 打开 Waline 官方 PostgreSQL 建表脚本：
   ```
   https://raw.githubusercontent.com/walinejs/waline/main/assets/waline.pgsql
   ```
4. 复制脚本全文，粘贴到 Supabase SQL Editor
5. 点击 **"Run"** 执行 SQL
6. 执行完成后确认存在以下表：
   - `wl_comment`
   - `wl_users`
   - `wl_counter`

---

## 🌐 第二步：部署 Waline 到 Vercel（2 分钟）

### 2.1 访问部署模板
1. 访问 [Waline Vercel 模板](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fwalinejs%2Fwaline%2Ftree%2Fmain%2Fexample)
2. 点击 **"Deploy"** 按钮

### 2.2 登录 Vercel
1. 选择 **"Continue with GitHub"**
2. 授权 Vercel 访问你的 GitHub 账号

### 2.3 配置环境变量
在部署页面，找到 **"Environment Variables"** 部分，添加以下变量：

| Name | Value |
|------|-------|
| `PG_DB` | `postgres` |
| `PG_USER` | `postgres` |
| `PG_PASSWORD` | 你的 Supabase 数据库密码 |
| `PG_HOST` | `db.xxxxxx.supabase.co` |
| `PG_PORT` | `5432` |
| `PG_SSL` | `true` |
| `PG_PREFIX` | `wl_` |

**示例**：
```
PG_DB=postgres
PG_USER=postgres
PG_PASSWORD=your-database-password
PG_HOST=db.xxxxxx.supabase.co
PG_PORT=5432
PG_SSL=true
PG_PREFIX=wl_
```

也可以使用 `POSTGRES_DATABASE`、`POSTGRES_USER`、`POSTGRES_PASSWORD`、`POSTGRES_HOST`、`POSTGRES_PORT`、`POSTGRES_SSL`、`POSTGRES_PREFIX` 这一组等价变量。两组不要混用，推荐统一使用 `PG_*`。

### 2.4 开始部署
1. 点击 **"Deploy"** 按钮
2. 等待 1-2 分钟，部署完成
3. 部署成功后，复制你的 Waline 服务地址：
   ```
   https://your-waline.vercel.app
   ```

---

## ⚙️ 第三步：更新 Hugo 配置（1 分钟）

### 3.1 编辑配置文件
打开 [`hugo.toml`](./hugo.toml)，找到 Waline 配置部分：

```toml
[params.page.comment.waline]
  enable = true
  serverURL = ""  # ← 在这里填写你的 Waline 服务地址
```

### 3.2 填写服务地址
将 `serverURL` 改为你的 Vercel 地址：

```toml
[params.page.comment.waline]
  enable = true
  serverURL = "https://your-waline.vercel.app"  # 替换为实际地址
```

---

## 🚢 第四步：部署博客（1 分钟）

### 4.1 构建博客
```bash
cd /Users/cygnus/work/github/cygnusthinkingcircle
python tools/make.py build --all
```

### 4.2 发布到 GitHub Pages
```bash
python tools/make.py publish
```

### 4.3 等待部署
GitHub Pages 通常需要 1-2 分钟完成部署。

---

## ✅ 第五步：测试评论系统

1. 访问你的博客：https://cygnusyang.github.io
2. 打开任意一篇文章
3. 滚动到页面底部，应该能看到评论框
4. 填写昵称和邮箱，发表一条测试评论

**成功！** 🎉 现在你的博客支持匿名评论了！

---

## 📊 管理评论

### 访问管理后台
1. 访问你的 Waline 服务地址：`https://your-waline.vercel.app`
2. 点击右上角 **"管理"**
3. 按 Waline 管理后台提示创建或登录管理员账号

### 通过 Supabase 管理评论
1. 访问 [Supabase Dashboard](https://supabase.com/dashboard)
2. 进入你的项目
3. 点击左侧菜单 **"Table Editor"**
4. 选择 `wl_comment` 表
5. 可以直接查看、编辑、删除评论

### 管理功能
- ✅ 查看所有评论
- ✅ 删除不当评论
- ✅ 标记垃圾评论
- ✅ 审核待审核评论
- ✅ 查看评论统计

---

## 📧 配置邮件通知（可选）

Waline 支持通过 Supabase Edge Functions 发送邮件通知：

### 1. 创建 Edge Function
1. 访问 Supabase Dashboard
2. 点击左侧菜单 **"Edge Functions"**
3. 点击 **"New Edge Function"**
4. 创建邮件通知函数

### 2. 配置 SMTP
在 Edge Function 中配置 SMTP 服务器（推荐使用 Resend、SendGrid 等服务）

详细配置请参考：[Waline 官方文档](https://waline.js.org/guide/get-started.html)

---

## 🔧 常见问题

### Q1: 评论框不显示？
**A:** 检查以下几点：
1. `hugo.toml` 中 `waline.enable = true`
2. `serverURL` 地址正确
3. 博客已重新部署
4. 浏览器控制台是否有错误

### Q2: 无法发表评论？
**A:** 检查以下几点：
1. Supabase 数据库表已创建
2. 必填字段（昵称、邮箱）已填写
3. 网络连接正常
4. 检查 Supabase 日志是否有错误

### Q3: Vercel 部署失败？
**A:** 检查以下几点：
1. 环境变量名称和值正确
2. Supabase 项目已创建
3. 网络连接正常

### Q4: 国内访问 Vercel 慢？
**A:** 可以考虑：
1. 使用国内云服务器部署 Waline
2. 或使用 Cloudflare Workers 部署
3. Supabase 选择新加坡或东京节点

### Q5: 如何切换回 Giscus？
**A:** 编辑 [`hugo.toml`](./hugo.toml)：
```toml
[params.page.comment.waline]
  enable = false  # 禁用 Waline

[params.page.comment.giscus]
  enable = true   # 启用 Giscus
```

### Q6: Supabase 免费额度够用吗？
**A:** Supabase 免费版提供：
- 500MB 数据库存储
- 1GB 文件存储
- 2GB 带宽/月
- 50,000 API 请求/月

对于个人博客，完全够用！

---

## 💰 成本说明

### 完全免费！

| 服务 | 免费额度 | 个人博客是否够用 |
|------|----------|------------------|
| **Supabase** | 500MB 数据库，5万 API/月 | ✅ 完全够用 |
| **Vercel** | 100GB 带宽/月，无限项目 | ✅ 完全够用 |

---

## 📚 相关文档

- [Waline 官方文档](https://waline.js.org/)
- [Supabase 官方文档](https://supabase.com/docs)
- [详细配置指南](./WALINE_SETUP.md)
- [评论系统说明](./README_COMMENTS.md)

---

## 🎯 总结

完成以上 5 个步骤，你的博客就支持匿名评论了！

```
Supabase (PostgreSQL 数据库)
    ↓
Vercel (服务托管)
    ↓
你的博客 (评论功能)
```

**总耗时**：约 5-10 分钟  
**总成本**：完全免费  
**维护成本**：几乎为零

有问题？查看 [WALINE_SETUP.md](./WALINE_SETUP.md) 获取更多详细信息。

---

## 🔄 从 LeanCloud 迁移到 Supabase

如果你之前使用 LeanCloud，可以：

1. 导出 LeanCloud 数据
2. 转换为 SQL 格式
3. 导入到 Supabase

或者直接重新开始，Supabase 的免费额度足够使用。
