#!/bin/bash

# 评论系统测试脚本
# 用于验证 Waline 评论系统配置

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
check_file "WALINE_DEPLOYMENT.md" "Waline 部署指南"
check_file "deploy-waline.sh" "Waline 部署脚本"
check_file "waline-env-example.md" "环境变量示例"
check_file "COMMENT_SYSTEM_SETUP.md" "评论系统设置指南"

echo ""
echo "2. 检查 Hugo 配置"
echo "----------------"

if [ -f "hugo.toml" ]; then
    check_config "params.page.comment.waline" "Waline 评论系统配置" "hugo.toml"
    check_config "enable = true" "评论系统启用状态" "hugo.toml"
    
    # 检查 serverURL 是否已配置
    server_url=$(grep -A1 "serverURL" hugo.toml | tail -1 | tr -d '[:space:]' | cut -d'"' -f2)
    if [[ "$server_url" == *"vercel.app"* ]] || [[ "$server_url" == *"localhost"* ]] || [[ "$server_url" == *"http"* ]]; then
        echo -e "${GREEN}✅ Waline serverURL 已配置: $server_url${NC}"
    else
        echo -e "${YELLOW}⚠️  Waline serverURL 可能需要更新: $server_url${NC}"
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
        if hugo config | grep -q "waline" 2>/dev/null; then
            echo -e "${GREEN}✅ Waline 配置在 Hugo 中可识别${NC}"
        else
            echo -e "${YELLOW}⚠️  Waline 配置在 Hugo 中未找到，可能需要重新加载${NC}"
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
echo "1. 访问 Waline 管理后台:"
echo "   https://your-waline-app.vercel.app/ui"
echo ""
echo "2. 检查 Waline 服务状态:"
echo "   https://your-waline-app.vercel.app/api/health"
echo ""
echo "3. 测试邮件发送:"
echo "   curl -X POST https://your-waline-app.vercel.app/api/test-email \\"
echo "     -H 'Content-Type: application/json' \\"
echo "     -d '{\"to\": \"your-email@example.com\"}'"
echo ""
echo "4. 验证数据库连接:"
echo "   curl https://your-waline-app.vercel.app/api/env | grep MONGO"
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
   - 确认 Waline 服务端运行正常
   - 查看浏览器控制台错误

2. 评论提交失败:
   - 检查 SECURE_DOMAINS 配置
   - 验证域名匹配
   - 查看网络请求状态

3. 邮件未发送:
   - 检查 Vercel 环境变量
   - 验证 SMTP 配置
   - 查看 Vercel 日志

4. 评论不显示:
   - 检查数据库连接
   - 查看评论审核设置
   - 验证页面权限
EOF

echo ""
echo "📊 测试总结"
echo "----------"

echo "要完成评论系统配置，你需要:"
echo ""
echo "1. 部署 Waline 到 Vercel"
echo "2. 配置 MongoDB Atlas 数据库"
echo "3. 设置 SMTP 邮件服务"
echo "4. 更新 hugo.toml 中的 serverURL"
echo "5. 测试评论功能"
echo "6. 验证邮件通知"
echo ""
echo "详细步骤请参考:"
echo "- COMMENT_SYSTEM_SETUP.md"
echo "- WALINE_DEPLOYMENT.md"
echo ""

echo "🎉 测试脚本完成!"
echo "运行以下命令开始部署:"
echo "./deploy-waline.sh"