---
layout: post
title: "/etc/fstab Optimization for SSD and RAM"
date: 2015-01-03 04:15:00
category: linux
---
I have been using **Samsung 840 Pro SSD** with **8GB 1600MHz DDR3** memory
module.

  
tmpfs is stored in the RAM, so it makes the system faster when I moved
temporary directories and log directories to tmpfs. Please be warned that your
log files will be deleted permanently each time you shutdown your computer.
You could edit configurations for nginx, proftpd or other daemons and store
logs in other directories.

  
SSD's respond faster, but it wears out with each IO operation (the rate is
very very low btw). So I disabled saving file and directory access time while
mounting partitions. Setting the options **async** is also a great advantage
if you don't need synchronous IO.

  
  
  
So here is my **/etc/fstab** file. Have a look.

    
    
    /dev/sda1 /           ext4  errors=remount-ro,async,noatime,nodiratime         0 1
    /dev/sda2 /home       ext4  defaults,async,noatime,nodiratime                  0 2
    /dev/sda3 /media/data ext4  auto,rw,exec,owner,async,nodiratime,nofail,noatime 0 2
    tmpfs     /tmp        tmpfs defaults,noatime,mode=1777   0  0
    tmpfs     /var/spool  tmpfs defaults,noatime,mode=1777   0  0
    tmpfs     /var/tmp    tmpfs defaults,noatime,mode=1777   0  0
    tmpfs     /var/log    tmpfs defaults,noatime,mode=0755   0  0
    

  

