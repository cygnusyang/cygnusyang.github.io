---
title: 首页
---

<style>
.category-cards {
  margin: 2rem 0;
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
  gap: 1.25rem;
}

.category-card {
  position: relative;
  border-radius: 0.75rem;
  padding: 1.5rem;
  background: fixit-var(light-bg-color);
  border: 1px solid fixit-var(global-border-color);
  transition: all 0.3s ease;
  overflow: hidden;
}

[data-theme=dark] .category-card {
  background: fixit-var(dark-bg-color);
}

.category-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.08);
  border-color: fixit-var(global-link-hover-color);
}

[data-theme=dark] .category-card:hover {
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.35);
}

.category-card-icon {
  font-size: 2rem;
  margin-bottom: 0.75rem;
  opacity: 0.9;
}

.category-card-title {
  font-size: 1.15rem;
  font-weight: 600;
  margin-bottom: 0.5rem;
  color: fixit-var(global-font-color);
}

.category-card-desc {
  font-size: 0.875rem;
  color: fixit-var(global-font-secondary-color);
  line-height: 1.5;
}

.category-card-count {
  position: absolute;
  top: 1rem;
  right: 1rem;
  font-size: 0.75rem;
  color: fixit-var(global-font-secondary-color);
  background: fixit-var(secondary-bg);
  padding: 0.25rem 0.5rem;
  border-radius: 1rem;
}

@media (max-width: 768px) {
  .category-cards {
    grid-template-columns: 1fr 1fr;
    gap: 1rem;
  }
  .category-card {
    padding: 1.25rem;
  }
  .category-card-icon {
    font-size: 1.75rem;
  }
}

@media (max-width: 480px) {
  .category-cards {
    grid-template-columns: 1fr;
  }
}
</style>

<div class="category-cards">

<a href="/posts/openclaw/" class="category-card" style="text-decoration: none; color: inherit;">
  <span class="category-card-count">34 篇</span>
  <div class="category-card-icon">
    <i class="fa-solid fa-robot" style="color: #2563eb;"></i>
  </div>
  <h3 class="category-card-title">OpenClaw</h3>
  <p class="category-card-desc">自托管个人 AI 助手框架完整开发文档</p>
</a>

<a href="/tags/gstack/" class="category-card" style="text-decoration: none; color: inherit;">
  <span class="category-card-count">系列</span>
  <div class="category-card-icon">
    <i class="fa-solid fa-layer-group" style="color: #0891b2;"></i>
  </div>
  <h3 class="category-card-title">GStack</h3>
  <p class="category-card-desc">全栈技术栈实践与架构设计笔记</p>
</a>

<a href="/tags/gbrain/" class="category-card" style="text-decoration: none; color: inherit;">
  <span class="category-card-count">系列</span>
  <div class="category-card-icon">
    <i class="fa-solid fa-brain" style="color: #7c3aed;"></i>
  </div>
  <h3 class="category-card-title">GBrain</h3>
  <p class="category-card-desc">大模型应用开发与智能 Agent 探索</p>
</a>

<a href="/categories/研发那些事/" class="category-card" style="text-decoration: none; color: inherit;">
  <span class="category-card-count">专栏</span>
  <div class="category-card-icon">
    <i class="fa-solid fa-code-branch" style="color: #dc2626;"></i>
  </div>
  <h3 class="category-card-title">研发那些事</h3>
  <p class="category-card-desc">软件开发过程中的思考与实践总结</p>
</a>

<a href="/categories/工程那些事/" class="category-card" style="text-decoration: none; color: inherit;">
  <span class="category-card-count">专栏</span>
  <div class="category-card-icon">
    <i class="fa-solid fa-sitemap" style="color: #ea580c;"></i>
  </div>
  <h3 class="category-card-title">工程那些事</h3>
  <p class="category-card-desc">软件工程架构设计与工程化方法论</p>
</a>

<a href="/tags/claude-code/" class="category-card" style="text-decoration: none; color: inherit;">
  <span class="category-card-count">系列</span>
  <div class="category-card-icon">
    <i class="fa-brands fa-github-alt" style="color: #65a30d;"></i>
  </div>
  <h3 class="category-card-title">Claude Code</h3>
  <p class="category-card-desc">Claude Code 开发实践与技巧分享</p>
</a>

<a href="/tags/mcp/" class="category-card" style="text-decoration: none; color: inherit;">
  <span class="category-card-count">系列</span>
  <div class="category-card-icon">
    <i class="fa-solid fa-plug" style="color: #0d9488;"></i>
  </div>
  <h3 class="category-card-title">MCP</h3>
  <p class="category-card-desc">Model Context Protocol 开发指南</p>
</a>

<a href="/tags/codex/" class="category-card" style="text-decoration: none; color: inherit;">
  <span class="category-card-count">系列</span>
  <div class="category-card-icon">
    <i class="fa-solid fa-book-atlas" style="color: #be185d;"></i>
  </div>
  <h3 class="category-card-title">Codex</h3>
  <p class="category-card-desc">技术知识库与最佳实践整理</p>
</a>

</div>
