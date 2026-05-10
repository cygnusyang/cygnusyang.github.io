# 分类层级约束

> 首页卡片分类、左侧导航栏分类、`content/posts/` 下的实际目录结构三者必须一一对应。

## 约束规则

### 1. 单一真相源

`content/_index.md` 中的 `pinned_categories` 是分类列表的唯一真相源。所有分类相关的数据都从这里派生：

- 首页文章卡片的显示和排序
- 左侧导航栏的分类列表
- 分类页面的文章列表

### 2. 目录命名

`pinned_categories` 中的每个 slug 必须与 `content/posts/` 下的实际目录路径完全一致：

```yaml
# content/_index.md
pinned_categories:
  - "openclaw"                    # 对应 content/posts/openclaw/
  - "gstack"                      # 对应 content/posts/gstack/
  - "工程那些事/电机控制"          # 对应 content/posts/工程那些事/电机控制/
```

**禁止** 存在两套平行的目录结构（如同时存在 `openclaw/` 和 `01-openclaw/`）。

### 3. URL 一致性

- 首页卡片点击后的 URL = 该分类 section 的 `.RelPermalink`
- 左侧导航栏中对应分类的 URL = 同一个 `.RelPermalink`
- 分类页面 URL 路径 = `content/posts/` + slug

### 4. 导航栏过滤

左侧文档导航栏只显示 `pinned_categories` 中列出的分类，不显示其他目录（如编号目录 `01-openclaw/`）。

### 5. 层级关系

扁平分类（如 `openclaw`）：
- 首页卡片：直接链接到 `/posts/openclaw/`
- 导航栏：显示为一级分类
- 目录：`content/posts/openclaw/`

嵌套分类（如 `工程那些事/电机控制`）：
- 首页卡片：链接到 `/posts/工程那些事/电机控制/`
- 导航栏：显示为"工程那些事"下的子分类
- 目录：`content/posts/工程那些事/电机控制/`
