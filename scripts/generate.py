#!/usr/bin/env python3
"""
内容多平台生成脚本
从 drafts/ 的源文章生成各平台适配版本
"""

import os
import re
from pathlib import Path

# 路径配置
BASE_DIR = Path(__file__).parent.parent
DRAFTS_DIR = BASE_DIR / "drafts"
POSTS_DIR = BASE_DIR / "_posts"
PLATFORMS_DIR = BASE_DIR / "platforms"

def parse_frontmatter(content):
    """解析 Jekyll frontmatter"""
    if content.startswith('---'):
        parts = content.split('---', 2)
        if len(parts) >= 3:
            return parts[1], parts[2]
    return None, content

def extract_sections(content):
    """提取文章各部分"""
    sections = {}
    lines = content.split('\n')

    current_section = None
    current_content = []

    for line in lines:
        if line.startswith('##'):
            if current_section:
                sections[current_section] = '\n'.join(current_content).strip()
            current_section = line.replace('##', '').strip()
            current_content = []
        else:
            current_content.append(line)

    if current_section:
        sections[current_section] = '\n'.join(current_content).strip()

    return sections

def generate_xiaohongshu(title, sections):
    """生成小红书版本"""
    template = (PLATFORMS_DIR / "xiaohongshu" / "template.md").read_text()
    content = template.replace("## 痛点描述", sections.get("核心问题", ""))
    return content.replace("## 为什么会这样？\n\n[用简单模型解释]", sections.get("核心模型", ""))

def generate_douyin(title, sections):
    """生成抖音版本"""
    return (PLATFORMS_DIR / "douyin" / "template.md").read_text()

def generate_wechat(title, sections):
    """生成微信版本"""
    template = (PLATFORMS_DIR / "wechat" / "template.md").read_text()
    content = template.replace("### 核心问题", "### 核心问题\n\n" + sections.get("核心问题", ""))
    return content.replace("### 核心模型", "### 核心模型\n\n" + sections.get("核心模型", ""))

def generate_baijiahao(title, sections):
    """生成百家号版本"""
    template = (PLATFORMS_DIR / "baijiahao" / "template.md").read_text()
    content = template.replace("## 痛点描述", sections.get("核心问题", ""))
    return content.replace("## 核心原因分析", sections.get("核心模型", ""))

def generate_summary(title, sections):
    """生成摘要"""
    return (PLATFORMS_DIR / "summary.md").read_text().replace("## [标题]", f"## {title}")

def process_draft(draft_file):
    """处理单个草稿文件"""
    print(f"处理: {draft_file}")

    content = draft_file.read_text()
    frontmatter, body = parse_frontmatter(content)
    sections = extract_sections(body)

    # 提取标题
    title = draft_file.stem.replace('-', ' ').title()

    # 生成各平台版本
    outputs = [
        (PLATFORMS_DIR / "xiaohongshu" / f"{draft_file.stem}.md", generate_xiaohongshu(title, sections)),
        (PLATFORMS_DIR / "douyin" / f"{draft_file.stem}.md", generate_douyin(title, sections)),
        (PLATFORMS_DIR / "wechat" / f"{draft_file.stem}.md", generate_wechat(title, sections)),
        (PLATFORMS_DIR / "baijiahao" / f"{draft_file.stem}.md", generate_baijiahao(title, sections)),
        (PLATFORMS_DIR / "summary.md", generate_summary(title, sections)),
    ]

    for output_path, output_content in outputs:
        output_path.parent.mkdir(parents=True, exist_ok=True)
        output_path.write_text(output_content)
        print(f"  生成: {output_path.relative_to(BASE_DIR)}")

def main():
    """主函数"""
    if len(os.sys.argv) < 2:
        print("用法: python scripts/generate.py <draft-file.md>")
        print("或: python scripts/generate.py all  # 处理所有草稿")
        return

    arg = os.sys.argv[1]

    if arg == "all":
        # 处理所有草稿
        for draft_file in DRAFTS_DIR.glob("*.md"):
            if draft_file.name != "template.md":
                process_draft(draft_file)
    else:
        # 处理指定文件
        draft_file = DRAFTS_DIR / arg
        if draft_file.exists():
            process_draft(draft_file)
        else:
            print(f"错误: 草稿文件不存在: {draft_file}")

if __name__ == "__main__":
    main()
