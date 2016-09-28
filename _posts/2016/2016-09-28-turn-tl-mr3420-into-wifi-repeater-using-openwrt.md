---
layout: post
title: Turn TL-MR3420 into WiFi Repeater using OpenWRT
date: 2016-09-28
categories: openwrt
---

<div class="message">
Download TL-MR3420 OpenWRT Firmware with relayd preinstalled from <a href="https://github.com/minhazul-haque/OpenWRT-TL-MR3420/tree/master/repeater">minhazul-haque/OpenWRT-TL-MR3420</a>
</div>

I have been using my [TL-MR3420](http://www.tp-link.com.bd/products/details/cat-14_TL-MR3420.html) (Version 2.2) router as a repeater for a month. The access point in my house is an Apple Airport which delivers pretty good signal even when there exists several obstacles (walls, doors) between the Airport and my WLAN card. But I badly needed a repeater for syncing files from/to my devices. So I turned my old router into a WiFi repeater.

First, let's disable the firewall and DNS masquerading because we will be using a Bridged Repeater which will act exactly like the Airport I have been using as access point. First, install `relayd` which will get most of the job done for us.

```bash
/etc/init.d/firewall stop
/etc/init.d/firewall disable
/etc/init.d/dnsmasq stop
/etc/init.d/dnsmasq disable
opkg update # in case the feeds are outdated
opkg install relayd
```

Now configure `/etc/config/wireless` as the following.

```bash
# nano /etc/config/wireless
config wifi-device 'radio0'
    option type 'mac80211'
    option channel '11' # Same as source
    option hwmode '802.11n' # Use bgn if needed
    option path 'platform/ar934x_wmac'
    option htmode 'HT40-' # 300MB/s
    option txpower '30'
    option country 'BD'
    option noscan '1'

config wifi-iface
    option device 'radio0'
    option network 'wwan'
    option encryption 'psk2'
    option key '12345678'
    option mode 'sta'
    option ssid 'source_ssid'

config wifi-iface
    option device 'radio0'
    option network 'lan'
    option encryption 'psk2'
    option key '87654321'
    option mode 'ap'
    option ssid 'repeater_ssid'
```

Now let's change `/etc/config/network` also. You have to be very careful in this step. Otherwise the repeater may not work, or even if it works, you may not get internet connectivity through it.

```bash
# nano /etc/config/network
config interface 'loopback'
    option ifname 'lo'
    option proto 'static'
    option ipaddr '127.0.0.1'
    option netmask '255.0.0.0'

config interface 'lan'
    option ifname 'eth0'
    option force_link '1'
    option type 'bridge'
    option proto 'static'
    option ip6assign '60'
    option ipaddr '192.168.10.1' # for relayd
    option gateway '10.0.1.1' # gateway of source
    option netmask '255.255.255.0'
    option dns '10.0.1.1' # dns of source

config interface 'wwan'
    option proto 'static'
    option ipaddr '10.0.1.254' # any ip from source
    option netmask '255.255.255.0'
    option gateway '10.0.1.1'

config interface 'stabridge'
    option proto 'relay'
    option network 'lan wwan'
    option ipaddr '10.0.1.254'

config switch
    option name 'switch0'
    option reset '1'
    option enable_vlan '1'

config switch_vlan
    option device 'switch0'
    option vlan '1'
    option ports '0 1 2 3 4'
```

Note that I have used `10.0.1.254` which will be the repeater's IP address. This is very important to set this IP correctly. Do not set IP address like `10.0.1.1` which is the gateway of the access point (!) or any other IP which is already reserved in the Airport (or any source WiFi access point). You can later `ssh` or `telnet` using the IP address of the `stabridge` device.

Now, edit `/etc/config/dhcp` according to the following.

```bash
# nano /etc/config/dhcp
config dhcp 'lan'
    option interface 'lan'
    option start '100'
    option limit '150'
    option leasetime '12h'
    option ignore '1'

config dhcp 'wan'
    option interface 'wan'
    option ignore '1'
```

Now we are almost done. Now just enable `relayd` and reboot the router.

```bash
/etc/init.d/relayd enable
reboot
```

After 15-30s of boot, you can see the new repeater SSID in the WiFi menu of your phone/compuer. Connect to it and check if the internet works.

If you fail, review the config files and keep trying. I suggest you to closely observe the config file because if you miss one single character, the WiFi may not start, or the internet connectivity might fall.

Good luck!

<div class="message">
Thanks to <a href="http://www.circuidipity.com/openwrt-bridged-repeater.html">Daniel Wayne Armstrong's post</a> for writing a nice post which really works and saved me from headache.
</div>
