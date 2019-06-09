---
layout: post
title: "ArchLinux: Cannot download any package on Raspberry Pi"
date: 2014-11-12 23:08:00
tag: linux
---
Many of you out there must have encountered this weird problem - cannot download or synchronize or update AUR database. Pinging any website shows success but whenever you run `pacman -Syyy` or `pacman -Su` the following errors occur.
    
    :: Retrieving packages ...
    error: failed retrieving file 'fltk-1.3.2-5-armv6h.pkg.tar.xz' from us.mirror.archlinuxarm.org : Operation too slow. Less than 1 bytes/sec transferred the last 10 seconds
    warning: failed to retrieve some files
    error: failed retrieving file 'libfontenc-1.1.2-1-armv6h.pkg.tar.xz' from us.mirror.archlinuxarm.org : Operation too slow. Less than 1 bytes/sec transferred the last 10 seconds
    warning: failed to retrieve some files
    error: failed retrieving file 'fontsproto-2.1.3-1-any.pkg.tar.xz' from us.mirror.archlinuxarm.org : Operation too slow. Less than 1 bytes/sec transferred the last 10 seconds
    warning: failed to retrieve some files
    error: failed retrieving file 'libxfont-1.5.0-1-armv6h.pkg.tar.xz' from us.mirror.archlinuxarm.org : Operation too slow. Less than 1 bytes/sec transferred the last 10 seconds

So, what could be the problem? After scrumming around I found out that the
problem was with MTU of ethernet device. I manually set this to 1400, and then
it works like a charm. Do this from Raspberry Pi shell.

    ifconfig eth0 mtu 1400

The changes will take effect instantly. Then hit pacman -Syyy and the packages
will start downloading without further hastle.

    [root@archpi sync]# pacman -Syyy      
    :: Synchronizing package databases...
    core                159.9 KiB  63.9K/s 00:03 [###########] 100%
    extra                 2.3 MiB  62.2K/s 00:37 [###############] 100%
    community             2.4 MiB  62.3K/s 00:39 [###############] 100%
    alarm                27.9 KiB  69.5K/s 00:00 [###############] 100%
    aur                  67.9 KiB  67.7K/s 00:01 [###############] 100%

Fun isn't it?
