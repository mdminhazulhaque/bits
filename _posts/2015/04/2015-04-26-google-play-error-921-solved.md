---
layout: post
title: "[Solved] Google Play Accessible Using Mobile Data, Fails Over WiFi"
date: 2015-04-26 01:25:00
categories: Android
---
Accessing Google Play Store from Android phones and getting the error message "connection timed out" - this is a very common issue for Android users. There are TONS of threads out there regarding this problem.

It had been one month since I couldn't access Google Play Store using my wireless router. My connection is good to go. Surprisingly I could log into
Google Play using mobile data connection. Weird, right?

Each time I opened Play Store app, I got this error code after the loading animation spinning for several times. Even I tried to install apps from Play
Store Web, but I got this error in my phone statusbar.

> Update for Gmail could not be downloaded due to an error 921

Then I found that it was an issue with MTU of my ISP. So I shell'ed into my droid and fired up this command.

```bash
adb shell
su
ifconfig wlan0 mtu 1400 up
```

After pressing "Retry", Google Play Store was alive in my phone. Viola!