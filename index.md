---
layout: home
---

# Cygnus Tech Blog

技术 × 产品 × 机器人

- [读书圈](/reading/)

## 文章列表

{% for post in paginator.posts %}
### [{{ post.title }}]({{ post.url | relative_url }})
<small>{{ post.date | date: "%Y-%m-%d" }}</small>

{% if post.excerpt %}
{{ post.excerpt }}
{% endif %}

---
{% endfor %}

{% if paginator.total_pages > 1 %}
<style>
.pagination {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin: 2rem 0;
  padding: 1rem 0;
  border-top: 1px solid #eaecef;
}
.pagination span {
  color: #6a737d;
}
</style>
<nav class="pagination">
  {% if paginator.previous_page %}
    <a href="{{ paginator.previous_page_path | relative_url }}">← 上一页</a>
  {% else %}
    <span></span>
  {% endif %}

  <span>第 {{ paginator.page }} 页 / 共 {{ paginator.total_pages }} 页</span>

  {% if paginator.next_page %}
    <a href="{{ paginator.next_page_path | relative_url }}">下一页 →</a>
  {% else %}
    <span></span>
  {% endif %}
</nav>
{% endif %}
