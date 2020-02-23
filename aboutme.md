---
layout: default
title: About Me
---
## [](#about-me)About Me

Hi, welcome to my homepage on the internet!

The name is Minhaz. Currently, I work as a DevOps Engineer at [iMoney Group, Malaysia](http://imoney-group.com/).

I used to work as a Senior Embedded System Engineer at [AplombTech BD Ltd., Bangladesh](http://aplombtechbd.com).

I am also a [Linux Foundation Certified System Administrator](http://training.linuxfoundation.org/certification/verify-linux-certifications) (License LFCS-1700-001846-0100).

My favorite pastime includes watching [movies](http://www.imdb.com/user/ur39009218/ratings/) with my wife, reading tech blogs, and playing retro games like Megaman and Metal Slug.

You can connect with me through the following web links.

* * *

## [](#projects)Projects

{% for project in site.data.projects %}
* <a href="{{ project.href }}">{{ project.title }}</a> - {{ project.desc }}{% endfor %}

* * *

## [](#courses)Online Courses

{% for course in site.data.courses %}
* <a href="{{ course.href }}">{{ course.title }}</a> - {{ course.organizer }}, {{ course.score }}%{% endfor %}