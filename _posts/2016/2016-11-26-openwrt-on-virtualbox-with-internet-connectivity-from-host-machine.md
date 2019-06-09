---
layout: post
title: 'OpenWRT inside VirtualBox with Internet Connectivity from Host Machine'
date: 2016-11-26
category: openwrt
---

Last week I tried to run OpenWRT inside a VM and had a lot of troubles before being successful. So I thought that I should write a post about it.

First, you will need a virtualization software, VirtualBox seems to be a perfect fit for such purpose. Then you will need a ext4 disk image of OpenWRT with x86-64 support because VirtualBox supports no other architectures other than x86/x64. The latest image can be downloaded from this link.

```
https://downloads.openwrt.org/snapshots/trunk/x86/64/openwrt-x86-64-combined-ext4.img.gz
```

After downloading the compressed gzipped image, let's convert it into raw disk image and then into VirtualBox compatible VDI image.

```bash
gunzip openwrt-x86-64-combined-ext4.img.gz
VBoxManage convertfromraw --format VDI openwrt-x86-64-combined-ext4.img openwrt-x86-64-combined-ext4.vdi
```

Now let's create an OpenWRT VM with the previously converted VDI image. The following script does the trick in 1s.

```bash
VMNAME="openwrt"
VDI="/home/minhaz/openwrt-x86-64-combined-ext4.vdi" # change here

VBoxManage createvm --name $VMNAME --register && \
VBoxManage modifyvm $VMNAME \
    --description "An OpenWRT VM" \
    --ostype "Linux_64" \
    --memory "256" \
    --cpus "1" \
    --nic1 "intnet" \
    --nictype1 "82540EM" \
    --nic2 "nat" \
    --nictype2 "82540EM" \
    --natpf2 "ssh,tcp,,2222,,22" \
    --natpf2 "luci,tcp,,8080,,80" \
    --natpf2 "ftp,tcp,,2121,,21" && \
VBoxManage storagectl $VMNAME \
    --name "SATA Controller" \
    --add "sata" \
    --portcount "1" \
    --hostiocache "on" \
    --bootable "on" && \
VBoxManage storageattach $VMNAME \
    --storagectl "SATA Controller" \
    --port "1" \
    --type "hdd" \
    --nonrotational "on" \
    --medium $VDI
```

Note that, I have set the NIC type to 82540EM which works automatically with OpenWRT modules. So whenever you boot OpenWRT, it will automatically detect NIC2 as WAN. This will allow you to ping google.com, update opkg and install packages too.

As you can see, I have forwarded port 21, 22 and 80 to the host machine. You might need to disable or modify the firewall configuration of the OpenWRT instance.

You can access LUCI of the instance by browsing to `http://localhost:8080` and SSH into it by `ssh root@localhost -p 2222`.

I hope that helps.
