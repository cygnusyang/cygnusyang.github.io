# 评论系统快速启动指南

## 5分钟快速部署

### 步骤 1: 一键部署脚本
```bash
cd /Users/cygnus/work/github/cygnusthinkingcircle/cygnusyang.github.io
./deploy-waline.sh
```

### 步骤 2: 按照脚本提示完成
1. 部署 Waline 到 Vercel
2. 配置 MongoDB Atlas
3. 设置邮件服务

### 步骤 3: 更新配置
编辑 `hugo.toml`，将 `serverURL` 更新为你的 Vercel 地址:
```toml
serverURL = "https://your-waline-app.vercel.app"
```

### 步骤 4: 测试
```bash
./test-comment-system.sh
```

## 文件说明

| 文件 | 用途 |
|------|------|
| `hugo.toml` | Hugo 主配置文件，包含评论系统配置 |
| `WALINE_DEPLOYMENT.md` | Waline 详细部署指南 |
| `deploy-waline.sh` | 一键部署脚本 |
| `waline-env-example.md` | 环境变量配置示例 |
| `COMMENT_SYSTEM_SETUP.md` | 完整设置指南 |
| `test-comment-system.sh` | 测试脚本 |
| `content/posts/comment-test.md` | 测试文章 |

## 配置摘要

### Hugo 配置 (hugo.toml)
```toml
[params.page.comment]
  enable = true
  
  [params.page.comment.waline]
    enable = true
    serverURL = "https://your-waline-app.vercel.app"  # 需要更新
    pageview = true
    meta = ["nick", "mail", "link"]
    requiredMeta = ["nick", "mail"]
    login = "enable"
    pageSize = 10
```

### 必需环境变量
```env
MONGO_HOST=mongodb+srv://user:pass@cluster.mongodb.net/db
SMTP_USER=apikey
SMTP_PASS=sendgrid_api_key
SENDER_EMAIL=noreply@example.com
SITE_URL=https://cygnusyang.github.io
SECURE_DOMAINS=cygnusyang.github.io
```

## 验证步骤

### 1. 服务状态
```bash
# 检查 Waline 服务
curl https://your-waline-app.vercel.app/api/health

# 检查环境变量
curl https://your-waline-app.vercel.app/api/env
```

### 2. 本地测试
```bash
# 启动本地服务器
hugo server -D

# 访问测试文章
open http://localhost:1313/posts/comment-test/
```

### 3. 功能测试
1. 发表测试评论
2. 检查邮件通知
3. 验证评论显示

## 故障快速排查

### 评论框不显示
1. 检查 `hugo.toml` 中 `enable = true`
2. 确认 `serverURL` 正确
3. 查看浏览器控制台 (F12 → Console)

### 评论提交失败
1. 检查 `SECURE_DOMAINS` 包含 `cygnusyang.github.io`
2. 验证网络请求 (F12 → Network)
3. 查看 Vercel 日志

### 邮件未发送
1. 检查 SMTP 环境变量
2. 验证邮箱服务状态
3. 查看邮件垃圾箱

## 生产部署

### 1. 更新配置
```bash
# 编辑 hugo.toml
vim hugo.toml

# 更新 serverURL
serverURL = "https://cygnus-waline.vercel.app"
```

### 2. 重新构建
```bash
cd /Users/cygnus/work/github/cygnusthinkingcircle
python tools/make.py build --all
python tools/make.py publish
```

### 3. 验证部署
访问 https://cygnusyang.github.io 测试评论功能。

## 维护命令

### 备份数据
```bash
# MongoDB 备份
mongodump --uri="mongodb+srv://..." --out=backup/
```

### 更新 Waline
1. 同步原仓库更改
2. 在 Vercel 重新部署
3. 测试功能

### 监控日志
```bash
# 查看 Vercel 日志
vercel logs your-waline-app
```

## 支持资源

- **官方文档**: https://waline.js.org
- **Vercel 部署**: https://vercel.com/docs
- **MongoDB Atlas**: https://docs.atlas.mongodb.com
- **SendGrid**: https://docs.sendgrid.com

## 紧急联系方式

如有紧急问题:
1. 检查 Vercel 部署状态
2. 查看 MongoDB Atlas 集群状态
3. 验证环境变量配置
4. 联系技术支持

## 完成清单

- [ ] 运行 `./deploy-waline.sh`
- [ ] 部署 Waline 到 Vercel
- [ ] 配置 MongoDB Atlas
- [ ] 设置 SendGrid 邮件服务
- [ ] 更新 `hugo.toml` 中的 `serverURL`
- [ ] 运行 `./test-comment-system.sh`
- [ ] 测试评论功能
- [ ] 验证邮件通知
- [ ] 部署到生产环境