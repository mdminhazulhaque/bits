#!/bin/bash

GH_PAGES=

jekyll build
rm _site/CNAME
rm _site/README

cp -r _site/* $GH_PAGES/
cd $GH_PAGES
sed -i "s/http:\/\/localhost:4000/https:\/\/bits.mdminhazulhaque.io/g" docs/sitemap.xml
git add .
git commit -m "New files"
git push -u origin gh-pages
