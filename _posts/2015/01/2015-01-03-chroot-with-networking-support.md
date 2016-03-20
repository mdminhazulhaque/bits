---
layout: post
title: "`chroot` with Networking Support"
date: 2015-01-03 00:05:00
categories: Linux
---
Google says,

> _Chroot is an operation that changes the apparent root directory for the
current running process and their children. A program that is run in such a
modified environment cannot access files and commands outside that
environmental directory tree. This modified environment is called a chroot
jail._

Well, you can activate network support (dhcp, or internet whatever) inside a
chroot jail environment.

Let's analyze a common chroot setup. I assume that I need to create a chroot
jail environment at /media/kubuntu which is a root partition of a Kubuntu
setup.

This would be the series of commands to mount essential paths.

```bash
DEVICE=/dev/sda1
MOUNTPATH=/media/kubuntu

mkdir -p $MOUNTPATH
mount -t auto -o acl $DEVICE  $MOUNTPATH
mount --bind /dev $MOUNTPATH/dev
mount --bind /tmp $MOUNTPATH/tmp
mount --bind /proc $MOUNTPATH/proc
mount --bind /sys $MOUNTPATH/sys
```

Before executing chroot, run the following command.

```bash
# do this after connecting to internet
mount --bind /etc/resolv.conf $MOUNTPATH/etc/resolv.conf
chroot $MOUNTPATH
```
This will bind resolve configuration inside chroot environment also. Then
execute chroot.

```bash
chroot $MOUNTPATH
```

Do a ping inside chroot shell. Does it work or not? ;)
