<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:atom="http://www.w3.org/2005/Atom"
  exclude-result-prefixes="atom">

<xsl:output method="html" version="5.0" encoding="utf-8" indent="yes"
  doctype-system="about:legacy-compat"
  media-type="text/html"/>

<xsl:template match="/">
<html lang="zh-CN">
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title><xsl:value-of select="rss/channel/title"/> - RSS Feed</title>
  <style>
    :root {
      --bg: #f8f9fa;
      --card-bg: #ffffff;
      --text: #1a1a2e;
      --text-secondary: #6c757d;
      --accent: #2563eb;
      --accent-hover: #1d4ed8;
      --border: #e5e7eb;
      --tag-bg: #eef2ff;
      --tag-text: #4338ca;
    }
    @media (prefers-color-scheme: dark) {
      :root {
        --bg: #0f172a;
        --card-bg: #1e293b;
        --text: #e2e8f0;
        --text-secondary: #94a3b8;
        --accent: #60a5fa;
        --accent-hover: #93c5fd;
        --border: #334155;
        --tag-bg: #1e1b4b;
        --tag-text: #a5b4fc;
      }
    }
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Noto Sans SC", "PingFang SC", "Microsoft YaHei", sans-serif;
      background: var(--bg);
      color: var(--text);
      line-height: 1.6;
      padding: 2rem 1rem;
    }
    .container { max-width: 800px; margin: 0 auto; }
    header {
      text-align: center;
      margin-bottom: 2.5rem;
      padding-bottom: 1.5rem;
      border-bottom: 1px solid var(--border);
    }
    h1 {
      font-size: 1.75rem;
      font-weight: 700;
      margin-bottom: 0.5rem;
    }
    h1 a {
      color: var(--text);
      text-decoration: none;
    }
    h1 a:hover { color: var(--accent); }
    .description {
      color: var(--text-secondary);
      font-size: 0.95rem;
      margin-bottom: 0.75rem;
    }
    .meta {
      display: flex;
      justify-content: center;
      gap: 1.5rem;
      font-size: 0.85rem;
      color: var(--text-secondary);
      flex-wrap: wrap;
    }
    .meta a {
      color: var(--accent);
      text-decoration: none;
    }
    .meta a:hover { text-decoration: underline; }
    .items { list-style: none; }
    .item {
      background: var(--card-bg);
      border: 1px solid var(--border);
      border-radius: 12px;
      padding: 1.5rem;
      margin-bottom: 1rem;
      transition: box-shadow 0.2s, transform 0.2s;
    }
    .item:hover {
      box-shadow: 0 4px 12px rgba(0,0,0,0.08);
      transform: translateY(-1px);
    }
    .item-title {
      font-size: 1.15rem;
      font-weight: 600;
      margin-bottom: 0.5rem;
    }
    .item-title a {
      color: var(--text);
      text-decoration: none;
    }
    .item-title a:hover { color: var(--accent); }
    .item-meta {
      font-size: 0.8rem;
      color: var(--text-secondary);
      margin-bottom: 0.75rem;
      display: flex;
      gap: 1rem;
      flex-wrap: wrap;
    }
    .item-meta .date::before { content: "📅 "; }
    .item-meta .author::before { content: "✍️ "; }
    .item-desc {
      font-size: 0.9rem;
      color: var(--text-secondary);
      line-height: 1.7;
    }
    .item-categories {
      margin-top: 0.75rem;
      display: flex;
      gap: 0.5rem;
      flex-wrap: wrap;
    }
    .category {
      display: inline-block;
      background: var(--tag-bg);
      color: var(--tag-text);
      font-size: 0.75rem;
      padding: 0.2rem 0.6rem;
      border-radius: 4px;
      text-decoration: none;
    }
    .category:hover {
      opacity: 0.8;
    }
    footer {
      text-align: center;
      margin-top: 2.5rem;
      padding-top: 1.5rem;
      border-top: 1px solid var(--border);
      font-size: 0.8rem;
      color: var(--text-secondary);
    }
    footer a { color: var(--accent); text-decoration: none; }
    footer a:hover { text-decoration: underline; }
    .subscribe-btn {
      display: inline-block;
      background: var(--accent);
      color: #fff;
      padding: 0.5rem 1.25rem;
      border-radius: 8px;
      text-decoration: none;
      font-size: 0.85rem;
      font-weight: 500;
      margin-top: 0.5rem;
      transition: background 0.2s;
    }
    .subscribe-btn:hover {
      background: var(--accent-hover);
    }
    @media (max-width: 600px) {
      body { padding: 1rem 0.75rem; }
      .item { padding: 1rem; }
      h1 { font-size: 1.4rem; }
    }
  </style>
</head>
<body>
<div class="container">
  <header>
    <h1><a href="{rss/channel/link}"><xsl:value-of select="rss/channel/title"/></a></h1>
    <div class="description"><xsl:value-of select="rss/channel/description"/></div>
    <div class="meta">
      <span><xsl:value-of select="rss/channel/language"/></span>
      <span>更新: <xsl:value-of select="rss/channel/lastBuildDate"/></span>
      <span><a href="{rss/channel/link}">访问网站 →</a></span>
    </div>
    <a class="subscribe-btn" href="index.xml">📡 订阅 RSS</a>
  </header>

  <ul class="items">
    <xsl:for-each select="rss/channel/item">
      <li class="item">
        <div class="item-title">
          <a href="{link}"><xsl:value-of select="title"/></a>
        </div>
        <div class="item-meta">
          <span class="date"><xsl:value-of select="pubDate"/></span>
          <xsl:if test="author">
            <span class="author"><xsl:value-of select="author"/></span>
          </xsl:if>
        </div>
        <div class="item-desc">
          <xsl:value-of select="description" disable-output-escaping="yes"/>
        </div>
        <xsl:if test="category">
          <div class="item-categories">
            <xsl:for-each select="category">
              <a class="category" href="{.}"><xsl:value-of select="."/></a>
            </xsl:for-each>
          </div>
        </xsl:if>
      </li>
    </xsl:for-each>
  </ul>

  <footer>
    <p>由 <a href="https://gohugo.io">Hugo</a> 生成 · <a href="{rss/channel/link}"><xsl:value-of select="rss/channel/title"/></a></p>
  </footer>
</div>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
