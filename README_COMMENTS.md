# 评论系统配置说明

## 当前状态

✅ **Hugo 配置已完成** - 已配置 Giscus 评论系统
✅ **主题支持已验证** - FixIt 主题支持评论系统
✅ **配置简单** - 无需服务器和数据库
⚠️ **需要 GitHub 账户登录** - 不支持匿名评论

## 当前方案: Giscus

**为什么选择 Giscus?**
- ✅ 配置最简单
- ✅ 完全免费
- ✅ 无需服务器和数据库
- ✅ 基于 GitHub Discussions
- ✅ 支持邮件通知
- ✅ 适合 GitHub Pages 静态站点

**缺点：**
- ❌ 需要 GitHub 账户登录
- ❌ 不支持匿名评论

## 快速开始

> 🚀 **5 分钟快速入门**：查看 [Vercel + Supabase 快速教程](./SUPABASE_QUICKSTART.md)（推荐）

> ⚠️ **注意**：LeanCloud 已停止新用户注册，请使用 Supabase 作为替代方案。

### 步骤 1: 配置 Supabase（推荐）
1. 访问 [Supabase 官网](https://supabase.com/) 注册账号
2. 创建项目（免费）
3. 导入 Waline 官方 PostgreSQL 建表脚本 `waline.pgsql`
4. 记录 PostgreSQL 连接信息（Host、Port、Database、User、Password）

详细步骤请参考：[SUPABASE_QUICKSTART.md](./SUPABASE_QUICKSTART.md)

### 备选方案：LeanCloud（仅限已有账号）
如果你已有 LeanCloud 账号，可以参考：[VERCEL_LEANCLOUD_QUICKSTART.md](./VERCEL_LEANCLOUD_QUICKSTART.md)

### 步骤 2: 部署 Waline 服务
推荐使用 Vercel 部署（免费）：
1. 访问 [Waline Vercel 模板](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fwalinejs%2Fwaline%2Ftree%2Fmain%2Fexample)
2. 配置 Supabase PostgreSQL 环境变量：
   ```env
   PG_DB=postgres
   PG_USER=postgres
   PG_PASSWORD=你的 Supabase 数据库密码
   PG_HOST=db.xxxxxx.supabase.co
   PG_PORT=5432
   PG_SSL=true
   PG_PREFIX=wl_
   ```
3. 部署完成后记录服务地址

### 步骤 3: 更新 Hugo 配置
编辑 [`hugo.toml`](./hugo.toml)，填写 Waline 服务地址：
```toml
[params.page.comment.waline]
  enable = true
  serverURL = "https://your-waline.vercel.app"  # 替换为你的服务地址
```

### 步骤 4: 部署博客
```bash
cd /Users/cygnus/work/github/cygnusthinkingcircle
python tools/make.py build --all
python tools/make.py publish
```

## 文件说明

| 文件 | 用途 |
|------|------|
| `hugo.toml` | Hugo 主配置文件，包含 Waline 配置 |
| `WALINE_SETUP.md` | Waline 详细配置指南 |
| `GISCUS_SETUP.md` | Giscus 配置指南（备用方案） |

## 配置摘要

### Hugo 配置 (hugo.toml)
```toml
[params.page.comment]
  enable = true
  
  [params.page.comment.waline]
    enable = true
    serverURL = "https://your-waline.vercel.app"  # 需要填写
    lang = "zh-CN"
    visitor = true
    emoji = ["https://cdn.jsdelivr.net/gh/walinejs/emojis@1.0.0/weibo"]
    requiredMeta = ["nick", "mail"]
    wordLimit = 0
    pageSize = 10
```

## 邮件通知

Waline 支持邮件通知：
- 新评论通知
- 回复通知

**配置方法:**
1. 在 Vercel Waline 项目中配置 SMTP 环境变量
2. 配置 SMTP 服务器（推荐 Resend、SendGrid、阿里云邮件推送或腾讯云邮件）
3. 用户填写邮箱后可接收回复通知

详细配置请参考：[WALINE_SETUP.md](./WALINE_SETUP.md#邮件通知配置)

## 管理评论

### 访问管理后台
1. 访问你的 Waline 服务地址
2. 点击右上角"管理"
3. 按 Waline 管理后台提示创建或登录管理员账号

### 管理功能
- 查看所有评论
- 删除不当评论
- 标记垃圾评论
- 审核待审核评论
- 查看评论统计

## 切换评论系统

### 从 Waline 切换到 Giscus
如果需要切换回 Giscus（需要 GitHub 账户登录）：
1. 编辑 [`hugo.toml`](./hugo.toml)
2. 将 `waline.enable` 设置为 `false`
3. 将 `giscus.enable` 设置为 `true`
4. 重新部署博客

## 故障排除

### 评论框不显示
1. 检查 `hugo.toml` 中 `enable = true`
2. 确认 Waline 服务地址正确
2. 确认 GitHub Discussions 已启用
3. 验证 `repoId` 和 `categoryId` 是否正确
4. 查看浏览器控制台错误 (F12 → Console)

### 无法发表评论
1. 确保已登录 GitHub
2. 检查仓库是否公开
3. 确认有讨论权限

### 邮件未收到
1. 检查 GitHub 通知设置
2. 验证邮箱是否正确
3. 查看垃圾邮件文件夹

## 完成清单

- [ ] 运行 `./setup-giscus.sh`
- [ ] 启用 GitHub Discussions
- [ ] 配置 Giscus 获取 ID
- [ ] 更新 `hugo.toml` 配置
- [ ] 运行 `./test-comment-system.sh`
- [ ] 重新构建并部署博客
- [ ] 测试评论功能
- [ ] 验证邮件通知

## 支持资源

- [Giscus 官方文档](https://giscus.app)
- [GitHub Discussions 指南](https://docs.github.com/discussions)
- [Hugo FixIt 主题文档](https://github.com/hugo-fixit/FixIt)
- [问题反馈](https://github.com/cygnusyang/cygnusthinkingcircle/issues)

---

**预计配置时间**: 10-15分钟  
**技术难度**: 简单  
**维护需求**: 极低  
**成本**: 完全免费
