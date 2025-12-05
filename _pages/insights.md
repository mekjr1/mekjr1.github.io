---
title: "Insights"
permalink: /insights/
excerpt: "Commentary and thought leadership"
layout: single
---

Curated posts and commentary on AI adoption, scaling systems, and innovation across Africa and LATAM.

## Latest Posts
{% for post in site.posts limit:5 %}
- [{{ post.title }}]({{ post.url | relative_url }}) — {{ post.date | date: "%b %d, %Y" }}
{% endfor %}

→ Browse the full archive: [Year Archive](/year-archive/)