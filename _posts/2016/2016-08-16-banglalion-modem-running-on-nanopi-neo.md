---
layout: post
title: Banglalion Modem Running on NanoPi Neo
date: 2016-08-16
category: linux
---

Recently I got a [Nanopi Neo](http://www.friendlyarm.com/index.php?route=product/product&product_id=132) with Allwinner H3 SoC, 512MB RAM, 1 USB-A port and 1 Ethernet port. I am using [Armbian](http://www.armbian.com/) as OS which is based on Debian.

I did a test if it was possible to run Banglalion WiMAX devices on this platform. So I grabbed Beceem WiMAX API sources and built it using `gcc-linaro-5.2-2015.11-2-x86_64_arm-linux-gnueabihf` toolchain.

First I had to build the Armbian kernel with `Staging` > `BCM_WIMAX` module. Then I dumped the image into a microsd card, put it into my NanoPi Neo and booted up.

I wasn't sure which IP it got, so I ran `nmap` to find it out.

```
root@minhaz-desktop:~# nmap -sn 10.42.0.1/24
Starting Nmap 6.40 ( http://nmap.org ) at 2016-08-07 01:10 BDT
Nmap scan report for 10.42.0.28
Host is up (0.00027s latency).
MAC Address: 46:A0:87:0F:06:B6 (Unknown)
Nmap scan report for 10.42.0.1
Host is up.
Nmap done: 256 IP addresses (2 hosts up) scanned in 19.06 seconds
```

Then I logged into it. Checked its memory and CPU information.

```
root@nanopineo:/# free -m
             total       used       free     shared    buffers     cached
Mem:           495         90        404          8          5         43
-/+ buffers/cache:         42        453
Swap:            0          0          0
root@nanopineo:/# nproc 
4
root@nanopineo:/# lscpu 
Architecture:          armv7l
Byte Order:            Little Endian
CPU(s):                4
On-line CPU(s) list:   0-3
Thread(s) per core:    1
Core(s) per socket:    4
Socket(s):             1
CPU max MHz:           1200.0000
CPU min MHz:           480.0000
```

I built the necessary library, daemons, clients etc which can be found at [mdminhazulhaque/beceem-cscm-armv7](https://github.com/mdminhazulhaque/beceem-cscm-armv7/tree/master/bin). Let's install them.

* Copy `libeap_supplicant.so`, `libengine_beceem.so` and `libxvi020.so` to `/lib`
* Copy `macxvi.cfg` and `macxvi200.bin` to `/lib/firmware`
* Copy `wimaxd` and `wimaxc` to `/usr/local/bin` as executable
* Copy `wimaxd.conf` to `/etc` and change `UserIdentity`, `UserPassword` and `TTLSAnonymousIdentity` to your own config
* Put `bilai.pem` to `/etc` (Use your head, ask questions or search the internet for it)

Now let's run the total setup.

* Plug in the modem (obviously!)
* Run `wimaxd -c /etc/wimaxd.conf`
* From another terminal, run `wimaxc connect 2600 10` to connect
* If connection is established, run `dhclient eth1` to lease IP from the modem (assuming that eth1 is the WiMAX device)

Here is a photo of my little buddy and the Bilai modem.

![Banglalion Modem on ARM](http://i.imgur.com/29qtGOw.jpg)

If you have any questions, ask below or open issue at the github repository.
