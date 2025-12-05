---
title: "Essays"
permalink: /essays/
layout: archive
author_profile: true
excerpt: "Original long-form reflections on AI, strategy, emerging markets, and engineering philosophy"
seo_title: "Essays by Abdul Meque: AI Strategy, Leadership, Cross-Cultural Innovation"
description: "In-depth essays exploring AI adoption in emerging markets, engineering leadership, African and LATAM innovation, technology philosophy, and cross-cultural experiences."
---

<div class="essays-intro">
  <p>Original long-form writing on AI reflections, personal growth, tech philosophy, African development, cross-cultural experiences, leadership thinking, and engineering philosophy.</p>
  <p>These essays explore the intersection of technology strategy, emerging markets innovation, and the human dimensions of building systems that matter.</p>
</div>

<div class="essays-archive">
  {% assign essays_by_year = site.essays | group_by_exp: "post", "post.date | date: '%Y'" | sort: "name" | reverse %}
  
  {% for year in essays_by_year %}
    <h2 class="archive-year">{{ year.name }}</h2>
    
    {% assign sorted_essays = year.items | sort: "date" | reverse %}
    {% for post in sorted_essays %}
      <article class="archive-item">
        <h3 class="archive-item-title">
          <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
        </h3>
        <p class="archive-item-meta">
          <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%B %d, %Y" }}</time>
        </p>
        {% if post.excerpt %}
          <p class="archive-item-excerpt">{{ post.excerpt | strip_html | truncate: 200 }}</p>
        {% endif %}
        {% if post.tags and post.tags.size > 0 %}
          <div class="archive-item-tags">
            {% for tag in post.tags %}
              <span class="tag tag-{{ tag | slugify }}">{{ tag }}</span>
            {% endfor %}
          </div>
        {% endif %}
      </article>
    {% endfor %}
  {% endfor %}
  
  {% if site.essays.size == 0 %}
    <p class="no-essays">No essays published yet. Check back soon for insights on AI strategy, engineering leadership, and emerging markets innovation.</p>
  {% endif %}
</div>

<style>
.essays-intro {
  margin-bottom: 2em;
  padding: 1.5em;
  background: var(--background-color, #f8f9fa);
  border-left: 4px solid var(--primary-color, #0066cc);
  border-radius: 4px;
}

.essays-intro p {
  margin-bottom: 0.5em;
}

.essays-intro p:last-child {
  margin-bottom: 0;
}

.essays-archive {
  margin-top: 2em;
}

.archive-year {
  font-size: 1.5em;
  font-weight: 600;
  margin-top: 2em;
  margin-bottom: 1em;
  padding-bottom: 0.5em;
  border-bottom: 2px solid var(--border-color, #e1e4e8);
}

.archive-item {
  margin-bottom: 2em;
  padding-bottom: 2em;
  border-bottom: 1px solid var(--border-color-light, #eaecef);
}

.archive-item:last-child {
  border-bottom: none;
}

.archive-item-title {
  font-size: 1.3em;
  margin-bottom: 0.3em;
}

.archive-item-title a {
  color: var(--text-color, #24292e);
  text-decoration: none;
}

.archive-item-title a:hover {
  color: var(--primary-color, #0066cc);
  text-decoration: underline;
}

.archive-item-meta {
  font-size: 0.9em;
  color: var(--text-color-muted, #586069);
  margin-bottom: 0.5em;
}

.archive-item-excerpt {
  margin-bottom: 0.8em;
  line-height: 1.6;
}

.archive-item-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5em;
}

.tag {
  display: inline-block;
  padding: 0.2em 0.6em;
  font-size: 0.85em;
  background: var(--tag-background, #f1f8ff);
  color: var(--tag-color, #0366d6);
  border-radius: 3px;
  text-transform: capitalize;
}

.no-essays {
  text-align: center;
  padding: 3em 1em;
  color: var(--text-color-muted, #586069);
  font-style: italic;
}

@media (max-width: 768px) {
  .essays-intro {
    padding: 1em;
  }
  
  .archive-year {
    font-size: 1.3em;
  }
  
  .archive-item-title {
    font-size: 1.1em;
  }
}
</style>
