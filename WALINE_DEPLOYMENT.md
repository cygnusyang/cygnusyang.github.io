# Waline 评论系统部署指南

## 概述
Waline 是一个现代化的评论系统，支持邮件通知功能。本指南将帮助你在 Vercel 上部署 Waline 服务端。

## 步骤 1: 准备环境

### 1.1 注册相关服务
- **Vercel**: [vercel.com](https://vercel.com) (用于部署)
- **MongoDB Atlas**: [mongodb.com/cloud/atlas](https://www.mongodb.com/cloud/atlas) (用于数据库存储，免费套餐足够)
- **SMTP 邮件服务** (用于邮件通知):
  - **SendGrid**: [sendgrid.com](https://sendgrid.com) (免费套餐 100 封/天)
  - **Mailgun**: [mailgun.com](https://www.mailgun.com) (免费套餐 5,000 封/月)
  - 或使用你的邮箱服务商提供的 SMTP

### 1.2 Fork Waline 仓库
访问 [Waline GitHub](https://github.com/walinejs/waline) 并 Fork 到你的 GitHub 账户。

## 步骤 2: 部署到 Vercel

### 2.1 从 GitHub 导入
1. 登录 [Vercel](https://vercel.com)
2. 点击 "Add New..." → "Project"
3. 选择你 Fork 的 Waline 仓库
4. 点击 "Import"

### 2.2 配置环境变量
在 Vercel 项目设置中，添加以下环境变量：

```
# 必填配置
MONGO_HOST=mongodb+srv://<username>:<password>@<cluster>.mongodb.net
MONGO_DB=<database_name>
SMTP_SERVICE=<smtp_service>  # 如: gmail, sendgrid, mailgun 等
SMTP_USER=<smtp_username>
SMTP_PASS=<smtp_password>
SMTP_SECURE=true
SMTP_HOST=<smtp_host>
SMTP_PORT=465
SENDER_NAME=Cygnus Tech Blog
SENDER_EMAIL=<sender_email>
SITE_NAME=Cygnus Tech Blog
SITE_URL=https://cygnusyang.github.io

# 可选配置
AUTHOR_EMAIL=<your_email>  # 新评论通知接收邮箱
SECURE_DOMAINS=cygnusyang.github.io
DISABLE_USERAGENT=false
```

## 步骤 3: 配置 MongoDB Atlas

### 3.1 创建集群
1. 登录 MongoDB Atlas
2. 创建新集群 (选择免费套餐 M0)
3. 等待集群创建完成

### 3.2 设置数据库访问
1. 在 "Database Access" 中创建数据库用户
2. 设置用户名和密码
3. 在 "Network Access" 中添加 IP 地址 0.0.0.0/0 (允许所有 IP)

### 3.3 获取连接字符串
1. 点击 "Connect" → "Connect your application"
2. 选择 Node.js 驱动版本
3. 复制连接字符串
4. 替换 `<password>` 为你的密码，`<dbname>` 为数据库名

## 步骤 4: 配置邮件服务

### 4.1 使用 SendGrid (推荐)
1. 注册 SendGrid 账户
2. 完成邮箱验证
3. 创建 API Key:
   - 左侧菜单: Settings → API Keys
   - 点击 "Create API Key"
   - 选择 "Restricted Access" → 勾选 "Mail Send"
   - 复制 API Key

配置环境变量:
```
SMTP_SERVICE=sendgrid
SMTP_USER=apikey
SMTP_PASS=<your_sendgrid_api_key>
SMTP_HOST=smtp.sendgrid.net
SMTP_PORT=465
```

### 4.2 使用 Gmail
1. 开启 Gmail 的 SMTP 访问:
   - 登录 Google 账户
   - 访问: https://myaccount.google.com/security
   - 开启 "两步验证"
   - 生成应用专用密码

配置环境变量:
```
SMTP_SERVICE=gmail
SMTP_USER=<your_email@gmail.com>
SMTP_PASS=<app_specific_password>
SMTP_HOST=smtp.gmail.com
SMTP_PORT=465
```

## 步骤 5: 更新 Hugo 配置

在 `hugo.toml` 中更新 Waline 配置:

```toml
[params.page.comment.waline]
  enable = true
  serverURL = "https://your-waline-app.vercel.app"  # 替换为你的 Vercel 域名
  pageview = true
  emoji = [ "//unpkg.com/@waline/emojis@1.1.0/weibo", "//unpkg.com/@waline/emojis@1.1.0/qq", "//unpkg.com/@waline/emojis@1.1.0/bilibili" ]
  meta = [ "nick", "mail", "link" ]
  requiredMeta = ["nick", "mail"]
  login = "enable"
  wordLimit = 0
  pageSize = 10
```

## 步骤 6: 测试部署

### 6.1 测试评论功能
1. 访问你的博客文章
2. 在文章底部找到评论区域
3. 尝试发表评论
4. 检查是否收到邮件通知

### 6.2 测试邮件通知
1. 作为访客发表评论
2. 作为管理员回复评论
3. 检查邮箱是否收到通知

## 故障排除

### 评论无法显示
- 检查 `serverURL` 是否正确
- 检查 Vercel 部署是否成功
- 查看 Vercel 日志

### 邮件无法发送
- 检查 SMTP 配置是否正确
- 验证邮箱服务是否开启 SMTP
- 检查防火墙设置

### 数据库连接失败
- 检查 MongoDB 连接字符串
- 验证网络访问权限
- 检查数据库用户权限

## 高级配置

### 自定义邮件模板
Waline 支持自定义邮件模板。在 Waline 项目中创建 `emails` 目录，添加模板文件:
- `comment.html` - 新评论通知
- `reply.html` - 回复通知

### 管理后台
访问 `https://your-waline-app.vercel.app/ui` 进入管理后台，可以:
- 管理评论
- 配置站点设置
- 查看统计信息

### 安全配置
1. 在 Vercel 环境变量中设置:
   ```
   SECURE_DOMAINS=cygnusyang.github.io
   ```
2. 在管理后台设置管理员邮箱
3. 启用 reCAPTCHA (可选)

## 维护

### 备份
定期备份 MongoDB 数据:
1. 登录 MongoDB Atlas
2. 进入集群 → "Backup"
3. 创建自动备份策略

### 更新
1. 同步原 Waline 仓库更新到你的 Fork
2. 在 Vercel 中重新部署

## 联系方式
如有问题，请参考:
- [Waline 官方文档](https://waline.js.org)
- [Vercel 文档](https://vercel.com/docs)
- [MongoDB Atlas 文档](https://docs.atlas.mongodb.com)