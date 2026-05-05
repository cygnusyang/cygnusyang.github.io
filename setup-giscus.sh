#!/bin/bash

# Giscus 评论系统配置脚本
# 专为 GitHub Pages 设计，无需服务器和数据库

set -e

echo "🎯 Giscus 评论系统配置脚本"
echo "=========================="

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 显示步骤
show_steps() {
    echo ""
    echo "📋 配置步骤"
    echo "=========="
    echo ""
    echo "1. 启用 GitHub Discussions"
    echo "2. 配置 Giscus 获取 ID"
    echo "3. 更新 Hugo 配置"
    echo "4. 测试评论功能"
    echo ""
}

# 步骤 1: 启用 GitHub Discussions
step1_enable_discussions() {
    echo ""
    echo "🔧 步骤 1: 启用 GitHub Discussions"
    echo "--------------------------------"
    echo ""
    echo "请按照以下步骤操作:"
    echo ""
    echo "1. 访问你的仓库:"
    echo "   ${GREEN}https://github.com/cygnusyang/cygnusthinkingcircle${NC}"
    echo ""
    echo "2. 点击 'Settings' → 'General'"
    echo ""
    echo "3. 滚动到 'Features' 部分"
    echo ""
    echo "4. 找到 'Discussions' 并勾选"
    echo ""
    echo "5. 点击 'Set up discussions'"
    echo ""
    echo "完成后按回车继续..."
    read -r
}

# 步骤 2: 配置 Giscus
step2_configure_giscus() {
    echo ""
    echo "⚙️  步骤 2: 配置 Giscus"
    echo "---------------------"
    echo ""
    echo "请访问 Giscus 配置页面:"
    echo ""
    echo "${GREEN}https://giscus.app${NC}"
    echo ""
    echo "配置说明:"
    echo "1. Repository: cygnusyang/cygnusthinkingcircle"
    echo "2. Discussions 分类: 选择 'Comments'"
    echo "3. 页面映射: 选择 'Page path'"
    echo "4. 获取以下信息:"
    echo ""
    echo "📝 请记录以下信息:"
    echo "-----------------"
    echo "Repository ID: ________________"
    echo "Category ID: ________________"
    echo ""
    echo "完成后按回车继续..."
    read -r
}

# 步骤 3: 更新 Hugo 配置
step3_update_hugo() {
    echo ""
    echo "📝 步骤 3: 更新 Hugo 配置"
    echo "-----------------------"
    echo ""
    
    if [ ! -f "hugo.toml" ]; then
        echo "${RED}错误: hugo.toml 文件不存在${NC}"
        return 1
    fi
    
    echo "当前配置:"
    echo "--------"
    grep -A5 "params.page.comment.giscus" hugo.toml || echo "未找到 Giscus 配置"
    
    echo ""
    echo "请编辑 hugo.toml 文件，更新以下配置:"
    echo ""
    cat << 'EOF'
[params.page.comment.giscus]
  enable = true
  repo = "cygnusyang/cygnusthinkingcircle"
  repoId = "YOUR_REPO_ID_HERE"           # 替换为实际 Repository ID
  category = "Comments"
  categoryId = "YOUR_CATEGORY_ID_HERE"   # 替换为实际 Category ID
  mapping = "pathname"
  strict = "0"
  reactionsEnabled = "1"
  emitMetadata = "0"
  inputPosition = "bottom"
  lang = "zh-CN"
  lightTheme = "light"
  darkTheme = "dark"
  lazyLoad = true
EOF
    
    echo ""
    echo "按回车打开编辑器，或手动编辑文件..."
    read -r
    
    # 尝试使用编辑器
    if command -v nano &> /dev/null; then
        nano hugo.toml
    elif command -v vim &> /dev/null; then
        vim hugo.toml
    elif command -v code &> /dev/null; then
        code hugo.toml
    else
        echo "请手动编辑 hugo.toml 文件"
    fi
    
    echo ""
    echo "✅ Hugo 配置更新完成"
}

# 步骤 4: 测试配置
step4_test_configuration() {
    echo ""
    echo "🧪 步骤 4: 测试配置"
    echo "----------------"
    echo ""
    
    # 检查配置
    echo "检查配置..."
    if grep -q "repoId = \"R_kg" hugo.toml 2>/dev/null; then
        echo "${GREEN}✅ Repository ID 已配置${NC}"
    else
        echo "${YELLOW}⚠️  Repository ID 可能需要更新${NC}"
    fi
    
    if grep -q "categoryId = \"DIC_kw" hugo.toml 2>/dev/null; then
        echo "${GREEN}✅ Category ID 已配置${NC}"
    else
        echo "${YELLOW}⚠️  Category ID 可能需要更新${NC}"
    fi
    
    # 测试 Hugo 配置
    echo ""
    echo "测试 Hugo 配置..."
    if command -v hugo &> /dev/null; then
        if hugo config 2>/dev/null | grep -q "giscus"; then
            echo "${GREEN}✅ Giscus 配置在 Hugo 中可识别${NC}"
        else
            echo "${YELLOW}⚠️  Giscus 配置未加载，可能需要检查语法${NC}"
        fi
    else
        echo "${YELLOW}⚠️  Hugo 未安装，跳过配置测试${NC}"
    fi
}

# 步骤 5: 部署和测试
step5_deploy_and_test() {
    echo ""
    echo "🚀 步骤 5: 部署和测试"
    echo "------------------"
    echo ""
    
    echo "部署步骤:"
    echo "1. 重新构建博客:"
    echo "   ${GREEN}cd /Users/cygnus/work/github/cygnusthinkingcircle${NC}"
    echo "   ${GREEN}python tools/make.py build --all${NC}"
    echo ""
    echo "2. 发布到 GitHub Pages:"
    echo "   ${GREEN}python tools/make.py publish${NC}"
    echo ""
    echo "3. 访问测试页面:"
    echo "   ${GREEN}https://cygnusyang.github.io${NC}"
    echo ""
    echo "4. 测试评论功能:"
    echo "   - 打开任意文章"
    echo "   - 滚动到底部查看评论区域"
    echo "   - 使用 GitHub 账户登录"
    echo "   - 发表测试评论"
    echo ""
    echo "5. 验证邮件通知:"
    echo "   - 检查 GitHub 通知设置"
    echo "   - 验证邮箱是否正确"
    echo "   - 测试通知功能"
    echo ""
}

# 步骤 6: 故障排除
step6_troubleshooting() {
    echo ""
    echo "🔧 步骤 6: 故障排除"
    echo "-----------------"
    echo ""
    
    cat << 'EOF'
常见问题及解决方法:

1. 评论框不显示:
   - 检查 hugo.toml 中 enable = true
   - 确认 GitHub Discussions 已启用
   - 验证 repoId 和 categoryId 是否正确
   - 查看浏览器控制台错误 (F12 → Console)

2. 无法发表评论:
   - 确保已登录 GitHub
   - 检查仓库是否公开
   - 确认有讨论权限

3. 邮件未收到:
   - 检查 GitHub 通知设置
   - 验证邮箱是否正确
   - 查看垃圾邮件文件夹

4. 评论不同步:
   - 检查 mapping 配置
   - 确认 URL 路径匹配
   - 查看 GitHub Discussions 对应关系

5. 配置错误:
   - 检查 hugo.toml 语法
   - 确认 ID 格式正确
   - 重新运行配置脚本
EOF
    
    echo ""
    echo "📞 支持资源:"
    echo "- Giscus 文档: https://giscus.app"
    echo "- GitHub Discussions: https://docs.github.com/discussions"
    echo "- 项目 Issues: https://github.com/cygnusyang/cygnusthinkingcircle/issues"
}

# 主函数
main() {
    echo "Giscus - GitHub Discussions 评论系统"
    echo "专为 GitHub Pages 静态站点设计"
    echo ""
    
    show_steps
    step1_enable_discussions
    step2_configure_giscus
    step3_update_hugo
    step4_test_configuration
    step5_deploy_and_test
    step6_troubleshooting
    
    echo ""
    echo "🎉 配置指南完成!"
    echo ""
    echo "📚 详细文档请查看:"
    echo "   - GISCUS_SETUP.md (完整配置指南)"
    echo "   - https://giscus.app (官方文档)"
    echo ""
    echo "💡 提示: 配置完成后记得测试评论功能!"
    echo ""
}

# 运行主函数
main