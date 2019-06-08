---
layout: post
title: "Bash One-liner to Set GRUB Timeout"
date: 2015-01-02 23:55:00
categories: linux
---
To set GRUB timeout to 5 seconds, use this command.

```bash
sed -i.bak 's/timeout=5/timeout=5/g' /boot/grub/grub.cfg
```

To disable timeout (first option will be selected automatically) use this
command.
```bash
sed -i.bak 's/timeout=5/timeout=0/g' /boot/grub/grub.cfg
```

To halt boot menu until any option is selected, use this one.

```bash
sed -i.bak 's/timeout=5/timeout=-1/g' /boot/grub/grub.cfg
```

If you want to disable creating backup, remove .bak from sed's option. For
examlple,

```bash
sed -i 's/timeout=5/timeout=1/g' /boot/grub/grub.cfg
```
