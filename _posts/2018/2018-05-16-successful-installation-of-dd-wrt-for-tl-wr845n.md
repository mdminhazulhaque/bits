---
layout: post
title: "Successful Installation of DD-WRT for TL-WR845N"
date: 2018-05-16
category: ddwrt
---

Several days ago I got my home router burnt due to the frequent thunderstorms. Luckily, only the WAN port of the router was damaged. So I decided to use the switch interface as WAN. I knew how to configure the switch as WAN on OpenWRT. Unfortunately there was no modded firmware for this model. I searched over the internet and tried flashing some firmwares. But none of them worked. Moreover, latest models from TP-Link does not support flashing 3rd party firmware from the WebUI.

So I opened the case of the router, took out the PCB, and insert 4 male headers on the debug UART port. This is how the UART pin mapping looks like -

![PCB](https://i.imgur.com/FH7i7oT.jpg)

![Debug UART](https://i.imgur.com/aoN5zIT.jpg)

From the debug log, I found that the chip model is Qualcomm Atheros QCA9533-BL3A and it was connected to 32MB DRAM and 4 MB SPI Flash. I searched in the DD-WRT forum and found that the model is a rebranded version of TP Link TL-WR841ND v10. So I decided to use a firmware which was built for TL-WR841ND. I failed again because the product information in the firmware header was mismatched. But, I am glad that a user named `ian5142c` from [DD-WRT forum](https://www.dd-wrt.com/phpBB2/viewtopic.php?p=1107635) uploaded a firmware with the correct header info for that model.


I had to install TFTP server in my Linux PC and ran it via `xinetd`. Here is the config file located at `/etc/xinetd.d/tftp` -

```bash
service tftp
{
protocol        = udp
port            = 69
socket_type     = dgram
wait            = yes
user            = nobody
server          = /usr/sbin/in.tftpd
server_args     = /tmp
disable         = no
}
```

I downloaded the correct firmware from [this link](https://www.dd-wrt.com/phpBB2/download.php?id=40123&sid=8dea5fdab81f6bfcf0ad214be2334488) and renamed it as `wr845nv1_tp_recovery.bin` and put it in `/tmp`. Then I connected the router with my computer via ethernet cable. As I said the router's WAN port was damaged, so I used one of the four LAN ports. Then I set my computer's IP to `192.168.1.86` so that the router can find this IP while booting in recovery mode. In that case, the RESET button needs to be pressed and hold while powering on the router.

I could see the debug messages coming through the UART console. Then uboot pulled the firmware from my computer, flashed it and rebooted by itself. After a minute, I got a broadcasting SSID named `ddwrt` with open encryption in my phone's WiFI menu. After getting connected through the WiFi, I browsed the link `http://192.168.1.1` (use `admin` as both the username and password) and found that control panel impressive.

Rest of the configuration process were quite simple. Then at first, I disabled the DHCP Server from `eth0` (switch) and changed the WAN from `eth1` to `eth0`. Finally, I got the link up using PPPoE.

After completing all these terms, I am satisfied and my `hacked` router is performing quite good.

> You can use this beta firmwares from dd-wrt also (**at your own risk**)
>
* [wr841ndv10](ftp://ftp.dd-wrt.com/betas/2019/02-19-2019-r38840/tplink_tl-wr841ndv10/)
* [wr841ndv11](ftp://ftp.dd-wrt.com/betas/2019/02-19-2019-r38840/tplink_tl-wr841ndv11/)
