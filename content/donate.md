---
title: 捐赠支持
date: 2026-05-05
draft: false
type: wide
---

<style>
.donate-section {
  max-width: 640px;
  margin: 0 auto;
  text-align: center;
}

.donate-intro {
  font-size: 1.05rem;
  line-height: 1.8;
  color: var(--global-font-secondary-color);
  margin-bottom: 2.5rem;
}

.donate-methods {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 2rem;
  margin-bottom: 2.5rem;
}

.donate-method {
  flex: 1;
  min-width: 220px;
  max-width: 280px;
  padding: 1.5rem;
  border-radius: 0.85rem;
  background: var(--global-background-color);
  border: 1px solid var(--global-border-color);
  transition: all 0.3s ease;
}

.donate-method:hover {
  transform: translateY(-3px);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
  border-color: var(--global-link-hover-color);
}

[data-theme=dark] .donate-method:hover {
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4);
}

.donate-method-icon {
  font-size: 2.5rem;
  margin-bottom: 0.75rem;
}

.donate-method-title {
  font-size: 1.1rem;
  font-weight: 600;
  margin-bottom: 0.5rem;
  color: var(--global-font-color);
}

.donate-method-desc {
  font-size: 0.85rem;
  color: var(--global-font-secondary-color);
  line-height: 1.6;
}

.donate-qr {
  width: 200px;
  height: 200px;
  margin: 1rem auto;
  border-radius: 0.5rem;
  background: var(--secondary);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 0.85rem;
  color: var(--global-font-secondary-color);
  overflow: hidden;
}

.donate-qr img {
  width: 100%;
  height: 100%;
  object-fit: contain;
}

.donate-alt {
  margin-top: 2rem;
  padding: 1.5rem;
  border-radius: 0.85rem;
  background: var(--secondary);
  border: 1px solid var(--global-border-color);
}

.donate-alt-title {
  font-size: 1rem;
  font-weight: 600;
  margin-bottom: 0.75rem;
  color: var(--global-font-color);
}

.donate-alt-links {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 1rem;
}

.donate-alt-link {
  display: inline-flex;
  align-items: center;
  gap: 0.4rem;
  padding: 0.5rem 1.25rem;
  font-size: 0.9rem;
  font-weight: 500;
  color: var(--global-font-color);
  background: var(--global-background-color);
  border: 1px solid var(--global-border-color);
  border-radius: 0.5rem;
  text-decoration: none;
  transition: all 0.2s ease;
}

.donate-alt-link:hover {
  background: var(--global-link-hover-color);
  color: #fff;
  border-color: var(--global-link-hover-color);
  text-decoration: none;
}

.donate-thanks {
  margin-top: 2.5rem;
  padding: 1.5rem;
  border-radius: 0.85rem;
  background: linear-gradient(135deg, rgba(37, 99, 235, 0.05), rgba(99, 102, 241, 0.05));
  border: 1px solid var(--global-border-color);
}

.donate-thanks-title {
  font-size: 1.1rem;
  font-weight: 600;
  margin-bottom: 0.5rem;
  color: var(--global-font-color);
}

.donate-thanks-desc {
  font-size: 0.9rem;
  color: var(--global-font-secondary-color);
  line-height: 1.6;
}
</style>

<div class="donate-section">

<div class="donate-intro">
  如果我的文章对你有所帮助，欢迎请我喝杯咖啡 ☕<br>
  你的支持是我持续创作的动力 ❤️
</div>

<div class="donate-methods">

<div class="donate-method">
  <div class="donate-method-icon">💳</div>
  <div class="donate-method-title">微信赞赏</div>
  <div class="donate-method-desc">扫描二维码，请我喝杯咖啡</div>
  <div class="donate-qr">
    <img src="/images/wechatpay.jpg" alt="微信赞赏码">
  </div>
</div>

<div class="donate-method">
  <div class="donate-method-icon">💰</div>
  <div class="donate-method-title">支付宝</div>
  <div class="donate-method-desc">扫描二维码，支持创作</div>
  <div class="donate-qr">
    <img src="/images/alipay.jpg" alt="支付宝收款码">
  </div>
</div>

</div>

<div class="donate-alt">
  <div class="donate-alt-title">其他支持方式</div>
  <div class="donate-alt-links">
    <a href="https://github.com/sponsors/cygnusyang" class="donate-alt-link" target="_blank" rel="noopener noreferrer">
      <i class="fa-brands fa-github"></i> GitHub Sponsors
    </a>
    <a href="https://github.com/cygnusyang" class="donate-alt-link" target="_blank" rel="noopener noreferrer">
      <i class="fa-regular fa-star"></i> 关注 GitHub
    </a>
  </div>
</div>

<div class="donate-thanks">
  <div class="donate-thanks-title">🙏 感谢支持</div>
  <div class="donate-thanks-desc">
    每一份支持都是对我莫大的鼓励。我会继续分享更多有价值的技术内容，帮助更多人成长。
  </div>
</div>

</div>
