---
title: "Writing"
permalink: /writing/
layout: single
excerpt: "Unified hub: Essays, Medium, LinkedIn"
seo_title: "Thought Leadership: AI, Strategy, Emerging Markets"
description: "Essays and curated external writing by Abdul Meque on AI strategy, engineering leadership, and emerging markets innovation."
---

Welcome to a unified writing hub combining original essays, curated Medium articles, and selected LinkedIn posts.

### Streams
- **Essays**: Long-form reflections on AI, strategy, African and LATAM innovation, engineering philosophy.
- **Medium**: External articles (syndicated or experimental pieces).
- **LinkedIn**: Short-form insights and professional commentary.

### Latest Essays (Preview)
{% assign essays = site.essays | sort: "date" | reverse %}
{% for post in essays limit:3 %}
- [{{ post.title }}]({{ post.url | relative_url }}) — {{ post.date | date: "%b %d, %Y" }}
{% endfor %}

{% include writing-external.html %}

Navigate:
- [Essays](/writing-essays/)
- [Medium](/writing-medium/)
- [LinkedIn](/writing-linkedin/)