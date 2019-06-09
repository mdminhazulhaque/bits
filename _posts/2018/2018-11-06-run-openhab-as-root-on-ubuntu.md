---
layout: post
title: Run openHAB as root on Ubuntu
date: 2018-11-06
tag: linux
---

Although running openHAB as root is a massive security risk, and should not be a good practice to do, it might come handy for solving permission issues related to serial read/write, or executing special commands like sudo or apt.

To achieve this, we need to change 2 files. The following lines can do it for you.

```bash
sed -i s/User=openhab/User=root/g /usr/lib/systemd/system/openhab2.service
sed -i s/Group=openhab/Group=root/g /usr/lib/systemd/system/openhab2.service

sed -i s/OPENHAB_USER=openhab/OPENHAB_USER=root/g /etc/default/openhab2
sed -i s/OPENHAB_GROUP=openhab/OPENHAB_GROUP=root/g /etc/default/openhab2
```

I hope that helps.
