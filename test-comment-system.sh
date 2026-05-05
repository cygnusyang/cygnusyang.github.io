#!/bin/bash

# 评论系统测试脚本
# 用于验证 Giscus 评论系统配置

set -e

echo "🧪 评论系统测试脚本"
echo "================="

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 检查函数
check_file() {
    local file=$1
    local description=$2
    
    if [ -f "$file" ]; then
        echo -e "${GREEN}✅ ${description} 存在${NC}"
        return 0
    else
        echo -e "${RED}❌ ${description} 不存在${NC}"
        return 1
    fi
}

check_config() {
    local config=$1
    local description=$2
    local file=$3
    
    if grep -q "$config" "$file" 2>/dev/null; then
        echo -e "${GREEN}✅ ${description} 已配置${NC}"
        return 0
    else
        echo -e "${RED}❌ ${description} 未配置${NC}"
        return 1
    fi
}

# 测试开始
echo ""
echo "1. 检查配置文件"
echo "--------------"

check_file "hugo.toml" "Hugo 配置文件"
check_file "GISCUS_SETUP.md" "Giscus 配置指南"
check_file "setup-giscus.sh" "Giscus 配置脚本"
check_file "README_COMMENTS.md" "评论系统说明"
check_file "COMMENT_SYSTEM_COMPARISON.md" "评论系统对比"

echo ""
echo "2. 检查 Hugo 配置"
echo "----------------"

if [ -f "hugo.toml" ]; then
    check_config "params.page.comment.giscus" "Giscus 评论系统配置" "hugo.toml"
    check_config "enable = true" "评论系统启用状态" "hugo.toml"
    
    # 检查 Giscus 配置是否完整
    repo_id=$(grep "repoId" hugo.toml | cut -d'"' -f2)
    if [[ -n "$repo_id" && "$repo_id" != '""' ]]; then
        echo -e "${GREEN}✅ Giscus Repository ID 已配置${NC}"
    else
        echo -e "${YELLOW}⚠️  Giscus Repository ID 需要配置${NC}"
    fi
    
    category_id=$(grep "categoryId" hugo.toml | cut -d'"' -f2)
    if [[ -n "$category_id" && "$category_id" != '""' ]]; then
        echo -e "${GREEN}✅ Giscus Category ID 已配置${NC}"
    else
        echo -e "${YELLOW}⚠️  Giscus Category ID 需要配置${NC}"
    fi
fi

echo ""
echo "3. 检查主题文件"
echo "--------------"

theme_dir="themes/FixIt"
check_file "$theme_dir/layouts/_partials/single/comment.html" "评论模板文件"

echo ""
echo "4. 测试本地构建"
echo "--------------"

# 检查是否可构建
if command -v hugo &> /dev/null; then
    echo "正在测试 Hugo 构建..."
    if hugo version &> /dev/null; then
        echo -e "${GREEN}✅ Hugo 已安装且可用${NC}"
        
        # 测试配置
    if hugo config | grep -q "giscus" 2>/dev/null; then
        echo -e "${GREEN}✅ Giscus 配置在 Hugo 中可识别${NC}"
    else
        echo -e "${YELLOW}⚠️  Giscus 配置在 Hugo 中未找到，可能需要重新加载${NC}"
    fi
    else
        echo -e "${RED}❌ Hugo 无法运行${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  Hugo 未安装，跳过构建测试${NC}"
fi

echo ""
echo "5. 生成测试页面"
echo "--------------"

# 创建测试页面
test_post="content/posts/comment-test.md"
if [ ! -f "$test_post" ]; then
    mkdir -p content/posts
    cat > "$test_post" << 'EOF'
---
title: "评论系统测试文章"
date: 2026-05-05T23:07:00+08:00
draft: true
---

# 评论系统测试

这是一篇用于测试评论系统的文章。

请在下方发表评论以测试功能。

## 测试要点

1. 评论框是否显示
2. 评论提交是否正常
3. 邮件通知是否发送
4. 评论显示是否正常
EOF
    echo -e "${GREEN}✅ 创建测试文章: $test_post${NC}"
else
    echo -e "${YELLOW}⚠️  测试文章已存在: $test_post${NC}"
fi

echo ""
echo "6. 部署状态检查"
echo "--------------"

echo "请完成以下检查:"
echo ""
echo "1. 启用 GitHub Discussions:"
echo "   https://github.com/cygnusyang/cygnusthinkingcircle/settings"
echo ""
echo "2. 配置 Giscus 获取 ID:"
echo "   https://giscus.app"
echo ""
echo "3. 验证 GitHub 通知设置:"
echo "   https://github.com/settings/notifications"
echo ""

echo "7. 浏览器测试步骤"
echo "----------------"

cat << 'EOF'
1. 启动本地服务器:
   hugo server -D

2. 访问测试文章:
   http://localhost:1313/posts/comment-test/

3. 检查页面:
   - 文章底部是否有评论区域
   - 是否有"发表评论"按钮
   - 评论框是否正常显示

4. 测试评论功能:
   - 填写昵称: Test User
   - 填写邮箱: test@example.com
   - 填写评论: 这是一条测试评论
   - 点击提交

5. 验证结果:
   - 评论是否成功提交
   - 页面是否刷新显示新评论
   - 检查邮箱是否收到通知
EOF

echo ""
echo "8. 故障排除"
echo "----------"

cat << 'EOF'
常见问题及解决方法:

1. 评论框不显示:
   - 检查 hugo.toml 中 enable = true
   - 确认 GitHub Discussions 已启用
   - 查看浏览器控制台错误

2. 评论提交失败:
   - 检查 GitHub 账户是否登录
   - 验证仓库权限
   - 查看网络请求状态

3. 邮件未发送:
   - 检查 GitHub 通知设置
   - 验证邮箱是否正确
   - 查看垃圾邮件文件夹

4. 评论不显示:
   - 检查 GitHub Discussions 是否启用
   - 验证 Giscus 配置 ID
   - 确认仓库权限
EOF

echo ""
echo "📊 测试总结"
echo "----------"

echo "要完成评论系统配置，你需要:"
echo ""
echo "1. 启用 GitHub Discussions"
echo "2. 配置 Giscus 获取 ID"
echo "3. 更新 hugo.toml 中的 repoId 和 categoryId"
echo "4. 测试评论功能"
echo "5. 验证邮件通知"
echo ""
echo "详细步骤请参考:"
echo "- GISCUS_SETUP.md"
echo "- COMMENT_SYSTEM_COMPARISON.md"
echo ""

echo "🎉 测试脚本完成!"
echo "运行以下命令开始配置:"
echo "./setup-giscus.sh"