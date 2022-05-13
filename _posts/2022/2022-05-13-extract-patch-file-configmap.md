---
layout: post
title: Extract/Patch a File inside a ConfigMap
date: 2022-05-13
category: kubernetes
---

ConfigMap works great when you need to mount several files inside a container virtually.

Imagine you have a ConfigMap (like the following) with multiple files inside it and you want to extract/patch a single one of them.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  config.json:
    {
      "server": "0.0.0.0",
      "feature": true
    }

  hosts: |
    127.0.0.1  localhost
    10.10.0.1  example.com

  app.conf: |
    [main]
    appName=Awesome App
```

To extract a single file say `config.json`, run the following.

<!-- {% raw %} -->
```bash
kubectl get cm app-config -o go-template='{{index .data "config.json"}}' > config.json
```
<!-- {% endraw %} -->

To patch a single file say `app.conf` inside the ConfigMap run the following.

```bash
kubectl create cm app-config --from-file=app.conf=app.conf --dry-run=client -o yaml | \
kubectl patch cm app-config --type merge --patch-file /dev/stdin
```

Hope that helps.
