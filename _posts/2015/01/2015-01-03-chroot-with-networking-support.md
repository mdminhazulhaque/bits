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
mkdir /media/kubuntu
mount -t auto -o acl /dev/sda1  /media/kubuntu
mount --bind /dev /media/kubuntu/dev
mount --bind /tmp /media/kubuntu/tmp
mount --bind /proc /media/kubuntu/proc
mount --bind /sys /media/kubuntu/sys
```

Before executing chroot, run the following command.

```bash
mount --bind /etc/resolv.conf /media/kubuntu/etc/resolv.conf
```
This will bind resolve configuration inside chroot environment also. Then
execute chroot.

```bash 
chroot /media/kubuntu
```

Do a ping inside chroot shell. Does it work or not? ;)

