---
layout: post
title: Create Breadcrumb in Jekyll
date: 2019-09-14
category: jekyll
---
[Breadcrumb](https://developers.google.com/search/docs/data-types/breadcrumb) is a technique to show the level of your page so the user can browse any level directly, even from the Google search page. Also, the breadcrumb snippet must be put in the head tag of the HTML if you want to use the JSON-LD format.

My blog uses the URL pattern - `<base>/<category>/<post>`.

For example,

1. http://bits.mdminhazulhaque.io
2. http://bits.mdminhazulhaque.io/linux
3. https://bits.mdminhazulhaque.io/linux/authenticate-fluentd-to-access-bigquery.html

Now the challange is to generate a JSON file based on the page type or level. For my case,

* Level 1: The home page use `layout: default`
* Level 2: The category pages use `layout: category`
* Level 3: The post pages use `layout: post`

In Jekyll, I did not find any easy method to generate breadcrumb. Also it was nowhere written how can I know the level of page. So I had to apply some trick. It was - to use the `layout.type` variable in `_includes/head.html`.

Here is my `_includes/head.html` code that generates breadcrumb snippet (and title also) based on the page type.

{% raw %}
```
<head>
  <meta http-equiv="..." content="...">
  <meta name="..." content="...">
  <script type="application/ld+json">{
  "@context": "https://schema.org",
  "@type": "BreadcrumbList",
  "itemListElement": [
    {
      "@type": "ListItem",
      "position": 1,
      "name": "Home",
      "item": "{{ site.url }}/"
    }{% if layout.type == "category" %},{
      "@type": "ListItem",
      "position": 2,
      "name": "{{ page.title }}",
      "item": "{{ site.url }}/{{ page.title }}"
    }{% endif %}{% if layout.type == "post" %},{
      "@type": "ListItem",
      "position": 2,
      "name": "{{ page.category }}",
      "item": "{{ site.url }}/{{ page.category }}"
    },{
      "@type": "ListItem",
      "position": 3,
      "name": "{{ page.title }}",
      "item": "{{ site.url }}/{{ page.url }}"
    }{% endif %}]
  }</script>
  <title>
    {% if layout.type == "category" %}
        Posts tagged in #{{ page.title }}
    {% else %}
        {{ page.title }}
    {% endif %} | {{ site.title }}</title>
</head>
```
{% endraw %}

The result also looks as I expected.

![Breadcrumb using Jekyll](https://i.imgur.com/YCnUuyp.png)

> The source code of my blog can be downloaded from [mdminhazulhaque/bits](https://github.com/mdminhazulhaque/bits)

Let me know if there is any better way to achieve this thing. Thanks.
