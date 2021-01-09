#!/bin/bash

# copy poole scss
cp -r poole/_sass .
cp -r poole/styles.scss public/css/poole.scss
# yaml front matter for jekyll
head -4 public/css/poole.scss > public/css/hyde.scss
# copy hyde scss
cat hyde/public/css/hyde.css >> public/css/hyde.scss
# make container wider
# sed -i "s/max-width: 38rem/max-width: 42rem/" _sass/_layout.scss
# line height of hr
# sed -i "s/margin: 1.5rem/margin: 0.5rem/"     _sass/_type.scss
# change sidebar font
# sed -i "s/Abril Fatface/Ubuntu/"              public/css/hyde.scss
# chnage default font
# sed -i "s/PT Sans/Ubuntu/"                    public/css/hyde.scss
# change bengali font
# sed -i "s/Helvetica/\"Noto Serif Bengali\"/"       public/css/hyde.scss

# sed -i  "s/:[a-z_]*: //g" _posts/2020/2020-03-28-aws-cli-cheatsheet.md
# <div>{% include ad_article.html %}</div>
