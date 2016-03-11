---
layout: post
title: "MacOSX Cleanup Script"
date: 2015-06-29 05:40:00
categories: Mac
---
Recently I had been running out of space on my Mac. Then I downloaded some
apps for cleaning up caches and log files. Most of them are premium apps. So I
noted down which locations they clean up and used a script to manually remove
those files/dirs. ;) Here is what I have been using.

Caution: This might break your system. Use on your own risk.

```bash
USER_DIR='/Users/Minhaz'

rm -rf $USER_DIR/Library/Caches/com.apple.*
rm -rf $USER_DIR/Library/Containers/com.apple.appstore/Data/Library/Caches/*
rm -rf $USER_DIR/Library/Developer/Xcode/DerivedData/*
rm -rf $USER_DIR/Library/Logs/*
rm -rf /Library/Caches/Homebrew/*
rm -rf /Library/Logs/*
rm -rf /var/log/*
```