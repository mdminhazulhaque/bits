---
layout: post
title: "Driver for ICatch PC Camera for Windows 7"
date: 2012-09-21 00:44:00
categories: others
---
Atlast I found a solution to make a very old webcam work on Windows 7 x64. This is a webcam I found from my friend.

The device is plug-and-play on Linux. I tested it on **Kubuntu 12.04**. When plugged in, _**lsusb**_ returns the following
information.

```
Bus 002 Device 012: ID 04fc:0561 Sunplus Technology Co., Ltd Flexcam 100
```

I noticed that the device has several product names. Like,

* JTech IC100
* ICatch PC Camera
* Sunplus SPCA-561

Whatever, I did search for its driver and found a very old file supporting
windows 98/xp. The driver did not work on **Windows 7 x64**. I tried forced
and XP-SP3 mode. But no gain.

Then somewhere out there in the internet, I got the working driver and
capturing application for it. It has driver for Windows Vista and 7 (may work
on Windows 8 also!).

[Download ICatch PC Camera Driver](http://www.mediafire.com/download.php?w7sw605bmscy5ip)

* After installing and plugging in the device, a success dialog pops.
* Then open VLC, hit **Open Capture Device** and choose **ICatch PC CAMERA**.
* Also, the tool from **Sunplus** can also be used. Just open it.
* Using the device from Linux is very easy. Just install **Cheese** and open** /dev/videoN** with it.
