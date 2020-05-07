---
layout: post
title: Tweak your Bee IPTV Box with 3rd Party App and Launcher
date: 2019-05-30
category: android
---
Yesterday, I got a call from one of my colleagues (and also my neighbor) about how he messed up with his Android TV Box. He asked me if I could help him with that to make it <strike>great</strike> useful again.

Basically he bought the box with a subscription long ago. After it got expired, the startup app kept complaining about the subscription. He did perform a factory reset which caused the box loose its realm. As a result, it was no way useful for him other than throwing it away or tweak it.

After I got the box in my hands, first thing I tried is looking for it's model or chip number. I got `OTT TV BOX` written at the bottom and `beeiptv` on the top. Searching those keys gave me no idea, so I turned it on and plugged it into my TV.

The box booted real fast and the vendor-locked `beeiptv` app appeared with error messages something like this. Not to mention, I made sure it had internet connection via Ethernet.

> Failed connecting to middleware service A.B.C.D. Please check your internet connectivity or contact network admin.

Again, it gave me no clue. So I plugged in an USB mouse and manually checked the device status page. It revealed the build number, kernel version etc. I was laughing to see that the developer could only mod the `Model Number`, nothing else.

![Device Info Bee IPTV](https://i.imgur.com/FI2bzOq.png)

Anyway, the board version `rk322x` indicated that it uses Rockchip SoC. I had never worked with Rockchip, but they are damn famous for low cost STB and other IoT devices. I had an idea in my mind. I checked the `Developer Settings` and found that the `USB Debugging` option was already turned on. But I had no such cable that could connect the USB-Female port of the box to my computer's similar one. So I kept looking for alternatives.

Long ago I used to work with Android when the `adb` tool came handy. `adb` can connect over the wifi also. So I though I should give it a try for the box too. Then I got the box's IP from my router's DHCP table. Then ran this command in the terminal.

```
adb connect 192.168.0.122:5555 # adb uses this port by default
```

Viola! It got connected. Another wonder was waiting for me. After trying `adb shell` I typed `su` and it worked too! That means I can do whatever I want with this box until it does. Yeee!!!

Okay back to the business. From the behaviors of the default, vendor-locked launcher app, I guessed it prohibits any other app to be used as a launcher. Plus there was no way to access the App Drawer. So I decided to get benefit from `adb` again.

I downloaded 2 APK from the internet. You might ask why this specific two. Well, the box runs Android 4.4 which is way old than todays. So make sure you check the Android version compatibility before installing any app.

* com.swiftstreamz.live (For 3rd party live TV service)
* by.mediatech.home (For launcher/app drawer)

I used the command `adb install <apkfile>`. Both of them got installed without any error. Then I tried starting the 3rd party TV app via adb.

```
am start -e name Splash -n com.swiftstreamz.live/.MainActivity
```

It worked! I could see the new app interface in my TV. This gave my confidence a boost. So I decided to start the launcer too.

```
am start -e name Splash -n by.mediatech.home/.MainActivity
```

After having success with installing and running those apps, I knew I had only one challenge left ahead of me.

1. Bypass the vendor-locked launcer and use the new one installed by me

I googled around a bit and found that Android let's you reset default launcher settings if you long tap the `Home` button for 6 seconds. I did it and set the `TVHome` app as default. When the launcher came, I could see all the applications installed in a row.

![New TV Home App](https://i.imgur.com/eskp7sG.jpg)

Before celebrating my success, I did some extra tweaks.

* Disabled key press sound to make things faster
* Disabled autolock screen
* Disabled the following packages using `pm disable <pkg>`
    
    * `com.android.htmlviewer` # Won't do any WebDev thingy
    * `com.android.inputmethod.pinyin` # Don't need Chinese input
    * `com.android.printspooler` # Never going to print anything
    * `com.android.providers.downloads.ui` # Ugly download button
    * `com.android.providers.userdictionary
    * `com.android.stk` # SIM Toolkit support
    * `com.corpus.stb.beeiptv` # So the vendor gets no chance to complain again
    * `com.google.android.googlequicksearchbox` # I always hated this search app
    * `com.svox.pico` # WTF
    * `com.zidoo.ota.update` # Update might reset all my hardwork, so be safe
    * `com.zidoo.test` # Seems suspicious
    
* Set the animation speed to 0x to boost performance

Finally, I restarted the box several times to see if the custom launcher appears after boot everytime. Also checked the streaming apps, YouTube apps too. All of them worked like a charm!
