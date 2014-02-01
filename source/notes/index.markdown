---
layout: page
title: Notes Archive
footer: false
---

<div id="blog-archives">
{% for node in site.reverse_sorted_pages %}
{% if node.tags contains 'talk' %}
{% capture this_year %}{{ node.date | date: "%Y" }}{% endcapture %}
{% unless year == this_year %}
  {% assign year = this_year %}
  <h2>{{ year }}</h2>
{% endunless %}
  <article>
    <h1><a href="{{node.url}}">{{node.title}}</a></h1>
    <time datetime="{{ node.date | datetime | date_to_xmlschema }}" pubdate>{{ node.date | date: "<span class='month'>%b</span> <span class='day'>%d</span> <span class='year'>%Y</span>"}}</time>
  </article>
{% endif %}
{% endfor %}
</div>
