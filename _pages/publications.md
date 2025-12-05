---
layout: archive
title: "Publications"
permalink: /publications/
author_profile: true
---

My research focuses on Natural Language Processing, with particular emphasis on multilingual NLP, paraphrase identification, and misinformation detection. I've worked on projects spanning sentiment analysis, semantic role labeling, and cross-lingual text classification, with applications in social media analysis and information retrieval.

{% if author.googlescholar %}
  You can also find my articles on <u><a href="{{author.googlescholar}}">my Google Scholar profile</a>.</u>
{% endif %}

{% include base_path %}

## Peer-Reviewed Papers

{% assign peer_reviewed = site.publications | where: "category", "peer-reviewed" | sort: "date" | reverse %}
{% if peer_reviewed.size > 0 %}
  {% for pub in peer_reviewed %}
    {% include publication-card.html pub=pub %}
  {% endfor %}
{% else %}
  <p><em>No peer-reviewed papers available yet.</em></p>
{% endif %}

## Workshop Publications

{% assign workshops = site.publications | where: "category", "workshop" | sort: "date" | reverse %}
{% if workshops.size > 0 %}
  {% for pub in workshops %}
    {% include publication-card.html pub=pub %}
  {% endfor %}
{% else %}
  <p><em>No workshop publications available yet.</em></p>
{% endif %}

## Datasets

{% assign datasets = site.publications | where: "category", "dataset" | sort: "date" | reverse %}
{% if datasets.size > 0 %}
  {% for pub in datasets %}
    {% include publication-card.html pub=pub %}
  {% endfor %}
{% else %}
  <p><em>No datasets available yet.</em></p>
{% endif %}

## Thesis

{% assign thesis = site.publications | where: "category", "thesis" | sort: "date" | reverse %}
{% if thesis.size > 0 %}
  {% for pub in thesis %}
    {% include publication-card.html pub=pub %}
  {% endfor %}
{% else %}
  <p><em>No thesis available yet.</em></p>
{% endif %}

## Poster Presentations

{% assign posters = site.publications | where: "category", "poster" | sort: "date" | reverse %}
{% if posters.size > 0 %}
  {% for pub in posters %}
    {% include publication-card.html pub=pub %}
  {% endfor %}
{% else %}
  <p><em>No poster presentations available yet.</em></p>
{% endif %}
