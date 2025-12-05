---
title: "Medium"
permalink: /writing-medium/
layout: single
excerpt: "Curated external articles"
---

Add Medium article links manually or load from `_data/medium.yml`.

Example structure for `_data/medium.yml`:
```yml
articles:
  - title: "Scaling AI Systems in LATAM"
    url: "https://medium.com/..."
    date: 2025-10-01
  - title: "Hybrid RAG Architectures"
    url: "https://medium.com/..."
    date: 2025-09-15
```

Rendering snippet (to place here once data file exists):
```liquid
{% for a in site.data.medium.articles %}
- [{{ a.title }}]({{ a.url }}) — {{ a.date | date: "%b %d, %Y" }}
{% endfor %}
```