#!/bin/bash

# get poole sass files
cp -r poole/_sass .
cp -r poole/styles.scss public/css/poole.scss

# get hyde theme
head -4 public/css/poole.scss > public/css/hyde.scss
cat hyde/public/css/hyde.css >> public/css/hyde.scss

# get pygment theme
# head -4 public/css/poole.scss > public/css/syntax.scss
# cat pygments-css/default.css >> public/css/syntax.scss
