# Waline 环境变量配置示例

在 Vercel 项目设置中添加以下环境变量：

## 必填配置

### MongoDB 数据库配置
```env
# MongoDB Atlas 连接字符串
MONGO_HOST=mongodb+srv://<username>:<password>@<cluster>.mongodb.net/<dbname>?retryWrites=true&w=majority

# 数据库名称
MONGO_DB=waline
```

### SMTP 邮件服务配置 (使用 SendGrid)
```env
# 邮件服务提供商
SMTP_SERVICE=sendgrid

# SMTP 用户名 (SendGrid 使用 apikey)
SMTP_USER=apikey

# SMTP 密码 (SendGrid API Key)
SMTP_PASS=<your_sendgrid_api_key_here>

# 使用 SSL/TLS
SMTP_SECURE=true

# SMTP 服务器地址
SMTP_HOST=smtp.sendgrid.net

# SMTP 端口
SMTP_PORT=465
```

### 站点信息
```env
# 发件人名称
SENDER_NAME=Cygnus Tech Blog

# 发件人邮箱 (必须验证过)
SENDER_EMAIL=noreply@cygnusyang.github.io

# 站点名称
SITE_NAME=Cygnus Tech Blog

# 站点 URL
SITE_URL=https://cygnusyang.github.io
```

### 安全配置
```env
# 管理员邮箱 (接收新评论通知)
AUTHOR_EMAIL=ruohuyang@163.com

# 允许的域名 (防止跨站请求)
SECURE_DOMAINS=cygnusyang.github.io
```

## 可选配置

### 评论审核
```env
# 开启评论审核 (true: 需要审核, false: 直接显示)
COMMENT_AUDIT=false

# 审核通知邮箱
AUDIT_EMAIL=ruohuyang@163.com
```

### 高级功能
```env
# 禁用 User-Agent 检查 (开发环境可设为 true)
DISABLE_USERAGENT=false

# 禁用注册功能
DISABLE_REGISTER=false

# 语言设置 (默认自动检测)
LANG=zh-CN

# 时区设置
TZ=Asia/Shanghai
```

### 邮件模板自定义
```env
# 自定义邮件主题前缀
MAIL_SUBJECT_PREFIX="[Cygnus Tech Blog] "

# 启用 HTML 邮件
MAIL_HTML=true
```

## 不同邮件服务商配置

### Gmail
```env
SMTP_SERVICE=gmail
SMTP_USER=your-email@gmail.com
SMTP_PASS=<app_specific_password>
SMTP_HOST=smtp.gmail.com
SMTP_PORT=465
```

### QQ 邮箱
```env
SMTP_SERVICE=qq
SMTP_USER=your-email@qq.com
SMTP_PASS=<authorization_code>
SMTP_HOST=smtp.qq.com
SMTP_PORT=465
```

### 163 邮箱
```env
SMTP_SERVICE=163
SMTP_USER=your-email@163.com
SMTP_PASS=<authorization_code>
SMTP_HOST=smtp.163.com
SMTP_PORT=465
```

### Mailgun
```env
SMTP_SERVICE=mailgun
SMTP_USER=postmaster@your-domain.com
SMTP_PASS=<mailgun_api_key>
SMTP_HOST=smtp.mailgun.org
SMTP_PORT=465
```

## 验证配置

### 1. 测试 MongoDB 连接
```bash
# 替换为你的连接字符串
mongosh "mongodb+srv://<username>:<password>@<cluster>.mongodb.net/<dbname>"
```

### 2. 测试 SMTP 连接
```bash
# 使用 telnet 测试 SMTP
telnet smtp.sendgrid.net 465
```

### 3. 验证环境变量
部署后访问 `https://your-app.vercel.app/api/env` 查看环境变量是否生效。

## 故障排除

### 邮件发送失败
1. 检查 SMTP 服务商是否开启
2. 验证 API Key 或密码是否正确
3. 检查防火墙是否阻止连接
4. 查看 Vercel 日志中的错误信息

### 数据库连接失败
1. 检查 MongoDB Atlas 网络访问设置
2. 验证用户名和密码
3. 检查连接字符串格式
4. 确认数据库集群状态

### 评论无法显示
1. 检查 `serverURL` 配置
2. 验证域名是否在 `SECURE_DOMAINS` 中
3. 查看浏览器控制台错误
4. 检查 Vercel 部署状态

## 更新配置

在 Vercel 中更新环境变量：
1. 登录 Vercel
2. 进入项目设置
3. 选择 "Environment Variables"
4. 添加或修改环境变量
5. 重新部署项目

## 安全建议

1. **定期更换 API Key**: 每 3-6 个月更换一次
2. **限制数据库访问**: 仅允许必要 IP 访问
3. **启用双因素认证**: 在 Vercel 和 MongoDB 中启用
4. **监控日志**: 定期查看 Vercel 日志
5. **备份数据**: 定期导出评论数据