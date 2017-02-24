---
layout: post
title: Connect to WiFi using nmcli
date: 2017-02-25
categories: linux
---
These days SoC with WiFi chip are very cheap and there exists lots of headless Linux OS for these machines. For example, Orange Pi Zero costs less than 10 US dollars.

Connecting to WiFi has been a real pain becase you need a password to connect with most SSID. And WLAN cards do not work like ethernet cards do. So modifying only `/etc/network/interfaces` is not enough.

Most Debian systems (may be others too) use `wpa_supplicant` for WLAN authentication. You need to generate `wpa_passphrase` for each network and configure them with `/etc/network/interfaces` which is really confusing. For this purpose, `nmcli` tool comes handy.

Simple do search of all available SSIDs by running the following command.

```bash
nmcli device wifi list
```

And here is the response.

```
*  SSID            MODE   CHAN  RATE       SIGNAL  BARS  SECURITY  
   MT7620_AP       Infra  1     54 Mbit/s  100     ▂▄▆█            
   MYHOME          Infra  2     54 Mbit/s  100     ▂▄▆█  WPA2      
   Minhaz+         Infra  11    54 Mbit/s  95      ▂▄▆█  WPA2      
   xiaomi-repeater Infra  1     54 Mbit/s  87      ▂▄▆█            
   ESP8266         Infra  2     54 Mbit/s  55      ▂▄__  WPA1 WPA2 
   LINK3           Infra  11    54 Mbit/s  12      ▂___  WPA1 WPA2 
   AAMRA-WIFI      Infra  11    54 Mbit/s  12      ▂___  WPA1 WPA2 
```

To connect to your desired network, simple use the following command.

```bash
nmcli device wifi connect MYHOME password 'p@55w0rd'
Device 'wlan0' successfully activated with 'd54d566c-fa31-4a21-ae4b-a1279d10f3e3'.
```

`nmcli` is very handy if you need to switch to different SSIDs frequently. [Here](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Networking_Guide/sec-Using_the_NetworkManager_Command_Line_Tool_nmcli.html) is a nice guide on `nmcli`. Read it for more.
