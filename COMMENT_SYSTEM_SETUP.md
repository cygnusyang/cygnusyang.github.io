# 评论系统设置指南

## 概述

本指南将帮助你在 Cygnus Tech Blog 上添加 Waline 评论系统，并配置邮件通知功能。

## 已完成的工作

✅ 已配置 Hugo 主题支持 Waline 评论系统
✅ 已创建部署脚本和配置指南
✅ 已更新 Hugo 模板以支持评论显示

## 下一步操作

### 步骤 1: 部署 Waline 服务端

运行部署脚本:
```bash
cd /Users/cygnus/work/github/cygnusthinkingcircle/cygnusyang.github.io
./deploy-waline.sh
```

或者手动按照 `WALINE_DEPLOYMENT.md` 指南部署。

### 步骤 2: 获取服务端地址

部署完成后，你会得到一个 Vercel 域名，例如:
- `https://your-waline-app.vercel.app`

### 步骤 3: 更新 Hugo 配置

编辑 `hugo.toml` 文件，找到以下配置并更新 `serverURL`:

```toml
[params.page.comment.waline]
  enable = true
  serverURL = "https://your-waline-app.vercel.app"  # 替换为你的实际地址
  # ... 其他配置保持不变
```

### 步骤 4: 测试评论功能

1. 重新构建并部署博客:
   ```bash
   cd /Users/cygnus/work/github/cygnusthinkingcircle
   python tools/make.py build --all
   python tools/make.py publish
   ```

2. 访问你的博客: https://cygnusyang.github.io
3. 打开任意一篇文章
4. 滚动到文章底部，应该能看到评论区域
5. 尝试发表一条评论
6. 检查邮箱是否收到通知

## 配置说明

### 邮件通知设置

邮件通知通过 Waline 服务端自动发送。当以下事件发生时:
- 新评论发布 → 管理员收到通知
- 评论被回复 → 评论者收到通知

### 环境变量配置

详细的环境变量配置请参考 `waline-env-example.md`。

## 故障排除

### 评论框不显示
1. 检查 `hugo.toml` 中 `enable = true`
2. 确认 Waline 服务端运行正常
3. 查看浏览器控制台是否有错误

### 邮件未发送
1. 检查 Vercel 环境变量配置
2. 验证 SMTP 服务是否正常
3. 查看 Vercel 日志中的错误信息

### 评论无法提交
1. 检查 `SECURE_DOMAINS` 配置
2. 确认域名匹配
3. 检查数据库连接

## 管理评论

### 管理后台
访问 Waline 管理后台:
```
https://your-waline-app.vercel.app/ui
```

### 管理功能
- 审核评论
- 删除不当评论
- 查看统计信息
- 配置站点设置

## 自定义配置

### 修改评论样式
编辑 `themes/FixIt/assets/css/_page/_single/_comment.scss` 来自定义样式。

### 添加验证码
在 Vercel 环境变量中添加:
- `RECAPTCHA_V3_KEY`: Google reCAPTCHA v3 密钥
- `TURNSTILE_KEY`: Cloudflare Turnstile 密钥

### 调整邮件模板
在 Waline 项目中创建自定义邮件模板:
- `emails/comment.html` - 新评论通知
- `emails/reply.html` - 回复通知

## 维护建议

### 定期检查
1. 每月检查 Vercel 部署状态
2. 监控邮件发送成功率
3. 查看评论审核队列

### 备份数据
1. 定期从 MongoDB Atlas 导出数据
2. 备份 Vercel 环境变量
3. 保存自定义配置

### 更新版本
1. 关注 Waline 版本更新
2. 定期同步原仓库更改
3. 在 Vercel 中重新部署

## 支持与帮助

- [Waline 官方文档](https://waline.js.org)
- [Vercel 支持](https://vercel.com/docs)
- [MongoDB Atlas 文档](https://docs.atlas.mongodb.com)
- [项目 Issues](https://github.com/cygnusyang/cygnusthinkingcircle/issues)

## 示例配置

以下是完整的 `hugo.toml` 评论配置示例:

```toml
# 评论系统配置
[params.page.comment]
  enable = true
  
  # Waline 评论系统配置 (https://waline.js.org)
  [params.page.comment.waline]
    enable = true
    serverURL = "https://cygnus-waline.vercel.app"
    pageview = true
    emoji = [ "//unpkg.com/@waline/emojis@1.1.0/weibo", "//unpkg.com/@waline/emojis@1.1.0/qq", "//unpkg.com/@waline/emojis@1.1.0/bilibili" ]
    meta = [
      "nick",
      "mail",
      "link"
    ]
    requiredMeta = ["nick", "mail"]
    login = "enable"
    wordLimit = 0
    pageSize = 10
    imageUploader = false
    highlighter = true
    comment = true
    texRenderer = false
    search = false
    recaptchaV3Key = ""
    turnstileKey = ""
    reaction = false
```

## 完成状态检查清单

- [ ] 部署 Waline 到 Vercel
- [ ] 配置 MongoDB Atlas 数据库
- [ ] 设置 SMTP 邮件服务
- [ ] 更新 `hugo.toml` 中的 `serverURL`
- [ ] 测试评论功能
- [ ] 验证邮件通知
- [ ] 配置管理后台
- [ ] 设置安全选项