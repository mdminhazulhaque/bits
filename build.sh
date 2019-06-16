#!/bin/bash

GH_PAGES=

jekyll build
rm _site/CNAME
rm _site/README

cp -r _site/* $GH_PAGES/
cd $GH_PAGES
git add .
git commit -m "New files"
git push -u origin gh-pages
