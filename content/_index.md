---
title: 首页
pinned_categories: ["openclaw", "gstack", "gbrain", "claudecode", "codex", "mcp", "harness"]
---

<style>
/* ====== Section Container ====== */
.home-section {
  margin: 2.5rem 0 3rem;
}

.home-section-header {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  margin-bottom: 1.5rem;
  padding-bottom: 0.75rem;
  border-bottom: 2px solid fixit-var(global-border-color);
}

.home-section-header-icon {
  font-size: 1.35rem;
  flex-shrink: 0;
}

.home-section-header-title {
  font-size: 1.35rem;
  font-weight: 700;
  color: fixit-var(global-font-color);
  margin: 0;
}

.home-section-header-count {
  font-size: 0.8rem;
  font-weight: 400;
  color: fixit-var(global-font-secondary-color);
  margin-left: 0.5rem;
  opacity: 0.7;
}

/* ====== Category Cards Grid (文章) ====== */
.category-cards {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
  gap: 1rem;
}

.category-card {
  position: relative;
  display: block;
  border-radius: 0.75rem;
  padding: 1.25rem;
  background: fixit-var(global-background-color);
  border: 1px solid fixit-var(global-border-color);
  transition: all 0.3s ease;
  text-decoration: none;
  color: inherit;
}

.category-card:hover {
  transform: translateY(-3px);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
  border-color: fixit-var(global-link-hover-color);
}

[data-theme=dark] .category-card:hover {
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4);
}

.category-card-icon {
  font-size: 1.75rem;
  margin-bottom: 0.6rem;
  opacity: 0.9;
}

.category-card-title {
  font-size: 1.05rem;
  font-weight: 600;
  margin-bottom: 0.35rem;
  color: fixit-var(global-font-color);
}

.category-card-desc {
  font-size: 0.8rem;
  color: fixit-var(global-font-secondary-color);
  line-height: 1.5;
  margin: 0;
}

.category-card-badge {
  position: absolute;
  top: 0.75rem;
  right: 0.75rem;
  font-size: 0.7rem;
  color: fixit-var(global-font-secondary-color);
  background: fixit-var(secondary);
  padding: 0.15rem 0.45rem;
  border-radius: 0.75rem;
  opacity: 0.75;
}

.category-card.empty {
  opacity: 0.55;
  cursor: default;
}

.category-card.empty:hover {
  transform: none;
  box-shadow: none;
  border-color: fixit-var(global-border-color);
}

/* ====== Project Cards (GitHub 工程) ====== */
.project-cards {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1.25rem;
}

.project-card {
  display: flex;
  flex-direction: column;
  border-radius: 0.85rem;
  padding: 1.5rem;
  background: fixit-var(global-background-color);
  border: 1px solid fixit-var(global-border-color);
  transition: all 0.3s ease;
}

.project-card:hover {
  transform: translateY(-3px);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
  border-color: fixit-var(global-link-hover-color);
}

[data-theme=dark] .project-card:hover {
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4);
}

.project-card-header {
  display: flex;
  align-items: flex-start;
  gap: 1rem;
  margin-bottom: 0.75rem;
}

.project-card-icon {
  font-size: 2rem;
  flex-shrink: 0;
  width: 3rem;
  height: 3rem;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 0.65rem;
  background: fixit-var(secondary);
}

[data-theme=dark] .project-card-icon {
  background: rgba(255,255,255,0.06);
}

.project-card-info {
  flex: 1;
  min-width: 0;
}

.project-card-name {
  font-size: 1.15rem;
  font-weight: 700;
  margin: 0 0 0.25rem;
  color: fixit-var(global-font-color);
}

.project-card-owner {
  font-size: 0.8rem;
  color: fixit-var(global-font-secondary-color);
  opacity: 0.65;
}

.project-card-desc {
  font-size: 0.875rem;
  color: fixit-var(global-font-secondary-color);
  line-height: 1.6;
  margin-bottom: 1rem;
  flex: 1;
}

.project-card-meta {
  display: flex;
  align-items: center;
  gap: 1rem;
  margin-bottom: 1rem;
}

.project-card-lang {
  display: flex;
  align-items: center;
  gap: 0.35rem;
  font-size: 0.8rem;
  color: fixit-var(global-font-secondary-color);
}

.project-card-lang-dot {
  width: 0.65rem;
  height: 0.65rem;
  border-radius: 50%;
}

.project-card-stars {
  display: flex;
  align-items: center;
  gap: 0.3rem;
  font-size: 0.8rem;
  color: fixit-var(global-font-secondary-color);
}

.project-card-btn {
  display: inline-flex;
  align-items: center;
  gap: 0.4rem;
  padding: 0.45rem 1rem;
  font-size: 0.82rem;
  font-weight: 500;
  color: fixit-var(global-font-color);
  background: fixit-var(secondary);
  border-radius: 0.5rem;
  text-decoration: none;
  transition: all 0.2s ease;
  align-self: flex-start;
}

.project-card-btn:hover {
  background: fixit-var(global-link-hover-color);
  color: #fff;
  text-decoration: none;
}

/* ====== About Section ====== */
.about-card {
  display: flex;
  align-items: flex-start;
  gap: 1.5rem;
  border-radius: 0.85rem;
  padding: 1.5rem;
  background: fixit-var(global-background-color);
  border: 1px solid fixit-var(global-border-color);
  transition: all 0.3s ease;
  text-decoration: none;
  color: inherit;
}

.about-card:hover {
  transform: translateY(-3px);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
  border-color: fixit-var(global-link-hover-color);
}

[data-theme=dark] .about-card:hover {
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4);
}

.about-card-icon {
  font-size: 2.5rem;
  flex-shrink: 0;
  opacity: 0.85;
}

.about-card-content h3 {
  font-size: 1.15rem;
  font-weight: 700;
  margin: 0 0 0.5rem;
  color: fixit-var(global-font-color);
}

.about-card-content p {
  font-size: 0.9rem;
  color: fixit-var(global-font-secondary-color);
  line-height: 1.6;
  margin: 0 0 0.75rem;
}

.about-card-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 0.4rem;
}

.about-card-tag {
  font-size: 0.72rem;
  padding: 0.15rem 0.55rem;
  border-radius: 0.6rem;
  background: fixit-var(secondary);
  color: fixit-var(global-font-secondary-color);
}

/* ====== Responsive ====== */
@media (max-width: 768px) {
  .project-cards {
    grid-template-columns: 1fr;
  }
  .category-cards {
    grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
    gap: 0.75rem;
  }
  .category-card {
    padding: 1rem;
  }
  .about-card {
    flex-direction: column;
    gap: 1rem;
  }
}

@media (max-width: 480px) {
  .category-cards {
    grid-template-columns: 1fr 1fr;
  }
}

/* ====== Category Header Row ====== */
.category-header-row {
  display: flex;
  align-items: center;
  margin-bottom: 1.5rem;
  padding-bottom: 0.75rem;
  border-bottom: 2px solid fixit-var(global-border-color);
}

.category-header-row .home-section-header {
  margin-bottom: 0;
  padding-bottom: 0;
  border-bottom: none;
}

/* ====== Category Cards 2-row limit ====== */
.category-cards.collapsed .category-card:nth-child(n+9) {
  display: none;
}

/* ====== Expand Button ====== */
.category-expand-btn {
  display: inline-flex;
  align-items: center;
  gap: 0.35rem;
  margin-top: 1rem;
  padding: 0.4rem 1rem;
  font-size: 0.82rem;
  font-weight: 500;
  color: fixit-var(global-font-secondary-color);
  background: transparent;
  border: 1px dashed fixit-var(global-border-color);
  border-radius: 0.5rem;
  cursor: pointer;
  transition: all 0.2s ease;
}

.category-expand-btn:hover {
  color: fixit-var(global-link-hover-color);
  border-color: fixit-var(global-link-hover-color);
}

.category-expand-arrow {
  transition: transform 0.2s ease;
}

.category-expand-btn.expanded .category-expand-arrow {
  transform: rotate(180deg);
}

</style>

<!-- ==================== 文章 ==================== -->
<section class="home-section">
  {{< category-popup >}}

  <div class="category-cards" id="categoryCards">
<a href="/posts/openclaw/" class="category-card" aria-label="OpenClaw">
    <span class="category-card-badge">34 篇</span>
    <div class="category-card-icon">🤖</div>
    <h3 class="category-card-title">OpenClaw</h3>
    <p class="category-card-desc">自托管个人 AI 助手框架完整开发文档</p>
  </a>

<a href="/posts/gstack/" class="category-card" aria-label="GStack">
          <span class="category-card-badge">12 篇</span>
    <div class="category-card-icon">📚</div>
    <h3 class="category-card-title">GStack</h3>
    <p class="category-card-desc">全栈技术架构设计与实践</p>
  </a>

<a href="/posts/gbrain/" class="category-card" aria-label="GBrain">
    <span class="category-card-badge">6 篇</span>
    <div class="category-card-icon">🧠</div>
    <h3 class="category-card-title">GBrain</h3>
    <p class="category-card-desc">大模型应用开发与智能 Agent 探索</p>
  </a>

<a href="/categories/研发那些事/" class="category-card" aria-label="研发那些事">
    <span class="category-card-badge">敬请期待</span>
    <div class="category-card-icon">💡</div>
    <h3 class="category-card-title">研发那些事</h3>
    <p class="category-card-desc">软件开发过程中的思考与实践</p>
  </a>

<a href="/categories/工程那些事/" class="category-card" aria-label="工程那些事">
    <span class="category-card-badge">敬请期待</span>
    <div class="category-card-icon">⚙️</div>
    <h3 class="category-card-title">工程那些事</h3>
    <p class="category-card-desc">软件工程架构设计与方法论</p>
  </a>

<a href="/posts/claudecode/" class="category-card" aria-label="Claude Code">
          <span class="category-card-badge">27 篇</span>
    <div class="category-card-icon">⌨️</div>
    <h3 class="category-card-title">Claude Code</h3>
    <p class="category-card-desc">Claude Code 开发实践与技巧</p>
  </a>

<a href="/tags/mcp/" class="category-card" aria-label="MCP">
    <span class="category-card-badge">敬请期待</span>
    <div class="category-card-icon">🔌</div>
    <h3 class="category-card-title">MCP</h3>
    <p class="category-card-desc">Model Context Protocol 开发指南</p>
  </a>

<a href="/tags/codex/" class="category-card" aria-label="Codex">
    <span class="category-card-badge">敬请期待</span>
    <div class="category-card-icon">📖</div>
    <h3 class="category-card-title">Codex</h3>
    <p class="category-card-desc">技术知识库与最佳实践</p>
  </a>

<a href="/posts/harness/" class="category-card" aria-label="Harness">
    <span class="category-card-badge">敬请期待</span>
    <div class="category-card-icon">⚙️</div>
    <h3 class="category-card-title">Harness</h3>
    <p class="category-card-desc">技术文档与开发指南</p>
  </a>

<a href="/posts/Academic Research Skills/" class="category-card" aria-label="Academic research skills">
    <span class="category-card-badge">敬请期待</span>
    <div class="category-card-icon">📦</div>
    <h3 class="category-card-title">Academic research skills</h3>
    <p class="category-card-desc">技术文档与开发指南</p>
  </a>

<a href="/posts/newproject/" class="category-card" aria-label="Newproject">
    <span class="category-card-badge">敬请期待</span>
    <div class="category-card-icon">🎯</div>
    <h3 class="category-card-title">Newproject</h3>
    <p class="category-card-desc">一个全新的技术探索项目</p>
  </a>

<a href="/reading/" class="category-card" aria-label="读书">
    <span class="category-card-badge">敬请期待</span>
    <div class="category-card-icon">📗</div>
    <h3 class="category-card-title">读书</h3>
    <p class="category-card-desc">读书笔记与书评分享</p>
  </a>
</div>

<button class="category-expand-btn" id="categoryExpandBtn" onclick="toggleExpandCards()" style="display:none">
  展开全部 <span class="category-expand-arrow">▾</span>
</button>

<script>
(function() {
  var grid = document.getElementById('categoryCards');
  var btn = document.getElementById('categoryExpandBtn');
  if (!grid || !btn) return;

  var CARDS_PER_ROW = 4; // default for desktop
  var MAX_ROWS = 2;
  var maxVisible = CARDS_PER_ROW * MAX_ROWS;

  function updateLayout() {
    var cards = grid.querySelectorAll('.category-card');
    if (cards.length <= maxVisible) {
      grid.classList.remove('collapsed');
      btn.style.display = 'none';
      return;
    }
    // Determine actual cards per row from grid
    var firstCardTop = cards[0].getBoundingClientRect().top;
    for (var i = 1; i < cards.length; i++) {
      if (cards[i].getBoundingClientRect().top > firstCardTop) {
        CARDS_PER_ROW = i;
        maxVisible = CARDS_PER_ROW * MAX_ROWS;
        break;
      }
    }
    if (cards.length > maxVisible) {
      grid.classList.add('collapsed');
      btn.style.display = 'inline-flex';
      btn.textContent = '展开全部 (' + (cards.length - maxVisible) + ') ▾';
    } else {
      grid.classList.remove('collapsed');
      btn.style.display = 'none';
    }
  }

  window.toggleExpandCards = function() {
    var collapsed = grid.classList.contains('collapsed');
    if (collapsed) {
      grid.classList.remove('collapsed');
      btn.textContent = '收起 ▴';
      btn.classList.add('expanded');
    } else {
      grid.classList.add('collapsed');
      var hidden = grid.querySelectorAll('.category-card').length - maxVisible;
      btn.textContent = '展开全部 (' + hidden + ') ▾';
      btn.classList.remove('expanded');
    }
  };

  // Run on load and resize
  updateLayout();
  window.addEventListener('resize', updateLayout);
})();
</script>
</section>

<!-- ==================== GitHub 工程 ==================== -->
<section class="home-section">
  <div class="home-section-header">
    <span class="home-section-header-icon">🛠️</span>
    <h2 class="home-section-header-title">GitHub 工程<span class="home-section-header-count">开源项目</span></h2>
  </div>

  <div class="project-cards">

  <div class="project-card">
    <div class="project-card-header">
      <div class="project-card-icon">📤</div>
      <div class="project-card-info">
        <h3 class="project-card-name">zhihupost</h3>
        <span class="project-card-owner">cygnusyang</span>
      </div>
    </div>
    <p class="project-card-desc">知乎内容自动化发布工具。将 Markdown 文章一键转换为知乎格式并发布，支持图片上传、排版优化、定时发布等功能。</p>
    <div class="project-card-meta">
      <span class="project-card-lang">
        <span class="project-card-lang-dot" style="background: #3178c6;"></span>
        TypeScript
      </span>
      <span class="project-card-stars">
        <i class="fa-regular fa-star"></i> —
      </span>
    </div>
    <a href="https://github.com/cygnusyang/zhihupost" class="project-card-btn" target="_blank" rel="noopener noreferrer">
      <i class="fa-brands fa-github"></i> 查看项目
    </a>
  </div>

  <div class="project-card">
    <div class="project-card-header">
      <div class="project-card-icon">💬</div>
      <div class="project-card-info">
        <h3 class="project-card-name">wechatpost</h3>
        <span class="project-card-owner">cygnusyang</span>
      </div>
    </div>
    <p class="project-card-desc">微信公众号内容管理工具。将 Markdown 文章转换为公众号原生排版，支持代码高亮、自定义样式模板、多图文消息管理。</p>
    <div class="project-card-meta">
      <span class="project-card-lang">
        <span class="project-card-lang-dot" style="background: #3178c6;"></span>
        TypeScript
      </span>
      <span class="project-card-stars">
        <i class="fa-regular fa-star"></i> —
      </span>
    </div>
    <a href="https://github.com/cygnusyang/wechatpost" class="project-card-btn" target="_blank" rel="noopener noreferrer">
      <i class="fa-brands fa-github"></i> 查看项目
    </a>
  </div>

  </div>
</section>

<!-- ==================== 关于 ==================== -->
<section class="home-section">
  <div class="home-section-header">
    <span class="home-section-header-icon">👋</span>
    <h2 class="home-section-header-title">关于<span class="home-section-header-count">了解更多</span></h2>
  </div>

  <a href="/about/" class="about-card">
    <div class="about-card-icon">🧑‍💻</div>
    <div class="about-card-content">
      <h3>Cygnus Yang</h3>
      <p>非典型工程师，关注 AI 智能体、软件工程自动化、分布式系统架构与产品设计。这个博客用来沉淀技术思考和实践经验。</p>
      <div class="about-card-tags">
        <span class="about-card-tag">AI Agent</span>
        <span class="about-card-tag">分布式系统</span>
        <span class="about-card-tag">软件工程</span>
        <span class="about-card-tag">产品设计</span>
      </div>
    </div>
  </a>
</section>

<!-- ==================== 捐赠支持 ==================== -->
<section class="home-section">
  <div class="home-section-header">
    <span class="home-section-header-icon">☕</span>
    <h2 class="home-section-header-title">捐赠支持<span class="home-section-header-count">请我喝杯咖啡</span></h2>
  </div>

  <a href="/donate/" class="about-card">
    <div class="about-card-icon">❤️</div>
    <div class="about-card-content">
      <h3>支持创作</h3>
      <p>如果我的内容对你有所帮助，欢迎请我喝杯咖啡。你的支持是我持续创作的动力。</p>
      <div class="about-card-tags">
        <span class="about-card-tag">微信赞赏</span>
        <span class="about-card-tag">支付宝</span>
        <span class="about-card-tag">GitHub Sponsors</span>
      </div>
    </div>
  </a>
</section>
