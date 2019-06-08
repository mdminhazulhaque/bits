---
layout: post
title: "One-liner to Get IP Address of Interface"
date: 2015-02-23 17:26:00
categories: linux
---
The following command is enough for extract IP address from `ifconfig` command. It uses field separator ":" and " " (space) to cut the line into words.

```bash
ifconfig eth0 | grep 'inet addr' | awk -F'[: ]+' '{ print $4 }'
```
