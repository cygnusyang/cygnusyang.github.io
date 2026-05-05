# Giscus 评论系统配置指南

## 为什么选择 Giscus？

✅ **完全免费** - 基于 GitHub Discussions，无需付费
✅ **无需服务器** - 没有数据库、VPS 等维护成本
✅ **GitHub 集成** - 使用 GitHub 账户登录和评论
✅ **邮件通知** - 通过 GitHub 通知系统发送邮件
✅ **安全可靠** - GitHub 提供安全和备份
✅ **适合静态站点** - 完美适配 GitHub Pages

## 快速配置步骤

### 步骤 1: 启用 GitHub Discussions
1. 访问你的仓库: https://github.com/cygnusyang/cygnusthinkingcircle
2. 点击 "Settings" → "General"
3. 滚动到 "Features" 部分
4. 勾选 "Discussions"
5. 点击 "Set up discussions"

### 步骤 2: 配置 Giscus
1. 访问 [Giscus 官网](https://giscus.app)
2. 按照向导配置:
   - **Repository**: `cygnusyang/cygnusthinkingcircle`
   - **Discussions 分类**: 选择 "Comments" (或创建新分类)
   - **页面 ↔ discussion 映射**: 选择 "Page path"
   - **其他设置**: 保持默认

3. 获取配置信息:
   ```
   Repository ID: [复制这里的数据]
   Category ID: [复制这里的数据]
   ```

### 步骤 3: 更新 Hugo 配置
编辑 `hugo.toml`，填写获取的 ID:

```toml
[params.page.comment.giscus]
  enable = true
  repo = "cygnusyang/cygnusthinkingcircle"
  repoId = "YOUR_REPO_ID_HERE"  # 替换为实际值
  category = "Comments"
  categoryId = "YOUR_CATEGORY_ID_HERE"  # 替换为实际值
  mapping = "pathname"
  strict = "0"
  reactionsEnabled = "1"
  emitMetadata = "0"
  inputPosition = "bottom"
  lang = "zh-CN"
  lightTheme = "light"
  darkTheme = "dark"
  lazyLoad = true
```

### 步骤 4: 测试评论系统
1. 重新构建并部署博客:
   ```bash
   cd /Users/cygnus/work/github/cygnusthinkingcircle
   python tools/make.py build --all
   python tools/make.py publish
   ```

2. 访问博客文章，查看评论区域
3. 使用 GitHub 账户登录并发表评论

## 邮件通知配置

### GitHub 通知设置
1. 登录 GitHub
2. 点击右上角头像 → "Settings"
3. 选择 "Notifications"
4. 配置邮件通知:
   - **Discussions**: 开启 "Participating and @mentions"
   - **Email preferences**: 确保邮箱正确

### 通知类型
- **新评论**: 当有人在 discussion 中评论时收到通知
- **@提及**: 当有人 @mention 你时收到通知
- **回复**: 当有人回复你的评论时收到通知

## 管理评论

### 通过 GitHub Discussions
1. 访问仓库: https://github.com/cygnusyang/cygnusthinkingcircle
2. 点击 "Discussions" 标签
3. 查看和管理所有评论

### 管理功能
- 删除不当评论
- 锁定 discussion
- 置顶重要评论
- 分类管理

## 配置示例

### 完整的 Giscus 配置
```html
<script src="https://giscus.app/client.js"
        data-repo="cygnusyang/cygnusthinkingcircle"
        data-repo-id="R_kgDOLgABC"
        data-category="Comments"
        data-category-id="DIC_kwDOLgABC4CeXYZ"
        data-mapping="pathname"
        data-strict="0"
        data-reactions-enabled="1"
        data-emit-metadata="0"
        data-input-position="bottom"
        data-theme="preferred_color_scheme"
        data-lang="zh-CN"
        crossorigin="anonymous"
        async>
</script>
```

### Hugo 配置对应关系
```toml
# Hugo 配置项 = Giscus 数据属性
repo = "cygnusyang/cygnusthinkingcircle"       # data-repo
repoId = "R_kgDOLgABC"                         # data-repo-id
category = "Comments"                          # data-category
categoryId = "DIC_kwDOLgABC4CeXYZ"             # data-category-id
mapping = "pathname"                           # data-mapping
strict = "0"                                   # data-strict
reactionsEnabled = "1"                         # data-reactions-enabled
emitMetadata = "0"                             # data-emit-metadata
inputPosition = "bottom"                       # data-input-position
lang = "zh-CN"                                 # data-lang
lightTheme = "light"                           # 浅色主题
darkTheme = "dark"                             # 深色主题
```

## 故障排除

### 评论框不显示
1. 检查 `hugo.toml` 中 `enable = true`
2. 确认 GitHub Discussions 已启用
3. 验证 `repoId` 和 `categoryId` 是否正确
4. 查看浏览器控制台错误

### 无法发表评论
1. 确保已登录 GitHub
2. 检查仓库是否公开
3. 确认有讨论权限

### 邮件未收到
1. 检查 GitHub 通知设置
2. 验证邮箱是否正确
3. 查看垃圾邮件文件夹

### 评论不同步
1. 检查 `mapping` 配置
2. 确认 URL 路径匹配
3. 查看 GitHub Discussions 对应关系

## 高级配置

### 自定义主题
Giscus 支持自定义 CSS。在 Hugo 主题中添加:
```css
/* 自定义 Giscus 样式 */
.giscus, .giscus-frame {
  width: 100%;
}
.giscus-frame {
  border: none;
}
```

### 语言本地化
支持多种语言:
- `zh-CN`: 简体中文
- `zh-TW`: 繁体中文
- `en`: 英语
- `ja`: 日语

### 懒加载优化
```toml
lazyLoad = true  # 页面滚动到评论区域时再加载
```

## 安全考虑

### 权限控制
- 评论需要 GitHub 账户
- 可配置仓库访问权限
- 支持 moderation 功能

### 内容审核
1. 开启 GitHub 的自动内容过滤
2. 设置敏感词过滤
3. 定期审查评论

### 数据备份
- 评论数据存储在 GitHub Discussions
- GitHub 自动备份所有数据
- 可导出讨论数据

## 替代方案

### Utterances (备用)
如果 Giscus 不适合，可切换为 Utterances:
```toml
[params.page.comment.utterances]
  enable = true
  repo = "cygnusyang/cygnusthinkingcircle"
  issueTerm = "pathname"
  label = "comment"
  lightTheme = "github-light"
  darkTheme = "github-dark"
```

### Waline (需要服务器)
如果未来需要独立服务器:
```toml
[params.page.comment.waline]
  enable = true
  serverURL = "https://your-waline-server.com"
```

## 最佳实践

### 1. 评论分类
创建不同的 Discussions 分类:
- `Comments`: 文章评论
- `Announcements`: 公告讨论
- `Feedback`: 用户反馈

### 2. 管理策略
- 定期清理 spam 评论
- 回复重要评论
- 置顶有价值的讨论

### 3. 用户体验
- 保持评论区域简洁
- 提供清晰的指引
- 支持暗黑模式

### 4. 性能优化
- 启用懒加载
- 使用合适的主题
- 优化加载速度

## 测试清单

- [ ] 启用 GitHub Discussions
- [ ] 配置 Giscus 并获取 ID
- [ ] 更新 `hugo.toml` 配置
- [ ] 重新构建并部署博客
- [ ] 测试评论功能
- [ ] 验证邮件通知
- [ ] 配置管理设置
- [ ] 测试移动端兼容性

## 支持资源

- [Giscus 官方文档](https://giscus.app)
- [GitHub Discussions 指南](https://docs.github.com/en/discussions)
- [Hugo 主题文档](https://github.com/hugo-fixit/FixIt)
- [问题反馈](https://github.com/cygnusyang/cygnusthinkingcircle/issues)

## 更新日志

### 2026-05-05
- 创建 Giscus 配置指南
- 更新 Hugo 配置模板
- 添加故障排除章节
- 提供完整部署步骤

---

**预计配置时间**: 10-15分钟  
**技术难度**: 简单  
**维护需求**: 极低  
**成本**: 完全免费