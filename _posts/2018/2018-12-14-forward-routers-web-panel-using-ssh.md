---
layout: post
title: Forward Router's Web Panel using SSH
date: 2018-12-14
categories: linux
---

Forwarding SSH is a very common practice for those who have limited access to Public IPs to their home network. It is possible to enable reverse proxy other ports/services inside the same network as the remote unit is.

For example, I have a Raspberry Pi running at my local network `192.168.1.0/24`. So I ran the following command inside the Pi to expose my router's control panel at `192.168.1.1` to `publicserver.net:8080`.

```
ssh -N -R 8080:192.168.1.1:80 root@publicserver.net
```


