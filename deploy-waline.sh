#!/bin/bash

# Waline 一键部署脚本
# 这个脚本会引导你完成 Waline 评论系统的部署

set -e

echo "🚀 Waline 评论系统部署脚本"
echo "=========================="

# 检查必要的工具
check_tools() {
    echo "🔍 检查必要的工具..."
    
    if ! command -v git &> /dev/null; then
        echo "❌ Git 未安装，请先安装 Git"
        exit 1
    fi
    
    if ! command -v curl &> /dev/null; then
        echo "❌ curl 未安装，请先安装 curl"
        exit 1
    fi
    
    echo "✅ 所有必要工具已安装"
}

# 显示配置指南
show_config_guide() {
    echo ""
    echo "📋 配置指南"
    echo "=========="
    echo ""
    echo "1. 你需要准备以下服务:"
    echo "   - Vercel 账户 (https://vercel.com)"
    echo "   - MongoDB Atlas 账户 (https://mongodb.com/cloud/atlas)"
    echo "   - 邮件服务 (SendGrid/Mailgun/Gmail)"
    echo ""
    echo "2. 按照以下步骤配置:"
    echo ""
    echo "   A. 部署 Waline 到 Vercel:"
    echo "      1. Fork Waline 仓库: https://github.com/walinejs/waline"
    echo "      2. 在 Vercel 中导入你的 Fork"
    echo "      3. 配置环境变量 (见下文)"
    echo ""
    echo "   B. 配置 MongoDB Atlas:"
    echo "      1. 创建免费集群 (M0)"
    echo "      2. 创建数据库用户"
    echo "      3. 添加网络访问 (0.0.0.0/0)"
    echo "      4. 获取连接字符串"
    echo ""
    echo "   C. 配置邮件服务 (以 SendGrid 为例):"
    echo "      1. 注册 SendGrid"
    echo "      2. 创建 API Key (Mail Send 权限)"
    echo "      3. 验证发件人邮箱"
    echo ""
    echo "3. 环境变量配置示例:"
    echo ""
    cat << 'EOF'
# 必填配置
MONGO_HOST=mongodb+srv://<username>:<password>@<cluster>.mongodb.net/<dbname>?retryWrites=true&w=majority
MONGO_DB=waline
SMTP_SERVICE=sendgrid
SMTP_USER=apikey
SMTP_PASS=<your_sendgrid_api_key>
SMTP_SECURE=true
SMTP_HOST=smtp.sendgrid.net
SMTP_PORT=465
SENDER_NAME="Cygnus Tech Blog"
SENDER_EMAIL=<sender_email>
SITE_NAME="Cygnus Tech Blog"
SITE_URL=https://cygnusyang.github.io
AUTHOR_EMAIL=<your_email>
SECURE_DOMAINS=cygnusyang.github.io
EOF
    echo ""
}

# 更新 Hugo 配置
update_hugo_config() {
    echo ""
    echo "🔄 更新 Hugo 配置..."
    
    read -p "请输入你的 Waline 服务端地址 (如: https://your-app.vercel.app): " server_url
    
    if [ -z "$server_url" ]; then
        echo "⚠️  未输入地址，跳过配置更新"
        return
    fi
    
    # 创建临时配置文件
    cat > /tmp/waline-config.toml << EOF
# 评论系统配置
[params.page.comment]
  enable = true
  
  # Waline 评论系统配置 (https://waline.js.org)
  [params.page.comment.waline]
    enable = true
    serverURL = "$server_url"
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
EOF
    
    echo ""
    echo "📝 请将以下配置添加到 hugo.toml 文件中:"
    echo "========================================"
    cat /tmp/waline-config.toml
    echo ""
    echo "或者运行以下命令手动添加:"
    echo "cat /tmp/waline-config.toml >> hugo.toml"
    echo ""
}

# 测试评论功能
test_comment_function() {
    echo ""
    echo "🧪 测试评论功能"
    echo "=============="
    echo ""
    echo "部署完成后，请进行以下测试:"
    echo ""
    echo "1. 访问你的博客文章: https://cygnusyang.github.io"
    echo "2. 找到任意一篇文章，滚动到底部"
    echo "3. 你应该能看到评论区域"
    echo "4. 尝试发表一条评论"
    echo "5. 检查是否收到邮件通知"
    echo ""
    echo "如果遇到问题，请检查:"
    echo "- Vercel 部署状态"
    echo "- 环境变量配置"
    echo "- 浏览器控制台错误"
    echo ""
}

# 主函数
main() {
    check_tools
    show_config_guide
    update_hugo_config
    test_comment_function
    
    echo ""
    echo "🎉 部署指南完成!"
    echo ""
    echo "📚 更多信息请查看:"
    echo "   - WALINE_DEPLOYMENT.md (详细部署指南)"
    echo "   - https://waline.js.org (官方文档)"
    echo "   - https://vercel.com/docs (Vercel 文档)"
    echo ""
    echo "💡 提示: 部署完成后，记得更新 hugo.toml 中的 serverURL!"
    echo ""
}

# 运行主函数
main