---
layout: post
title: "Root Samsung Galaxy ACE NXT (SM-G313HZ)"
date: 2015-01-30 17:06:00
tag: android
---
I purchased Samsung Galaxy ACE NXT (SM-G313HZ) two months ago and went through several failed attempt to root the phone. Odin is used a lot to root such phones but I was missing a custom recovery.

Yesterday I found the correct CWM recovery for my phone which is codenamed as Vivalto. Using this recovery I successfully rooted my phone and installed SuperSU on my phone.

Here is a list of tips and things needed to root the device.

###  Before You Start

* Backup your apps, contacts and all files from sdcard
* Download [SM-G313HZ-root.zip](https://www.dropbox.com/s/aaovpvxxzv67jth/SM-G313HZ-root.zip?dl=0)
* Download and install [Samsung USB Driver](http://developer.samsung.com/board/download.do?bdId=T000000117&attachId=0000000001)
* Turn on USB Debugging from Developer options, then turn off your phone

![USB Debugging Mode](http://i.imgur.com/ZqYYth7.png)

###  Install CWM

* Turn on the phone in Download Mode (press and hold Home + Power + Volume
* Down buttons)
* Press Volume Up to continue
* Run Odin3.exe
* Connect the phone via USB
* A blue box will appear in Odin and <Added> message will be seen
* Click AP/PDA button and select recovery.tar.md5 file.
* Click Start button
* Wait for several minutes till the phone restarts
* A green PASS text will be seen inside the Odin window

###  Install SuperSU

* Copy update.zip to a memory card and plug it in the phone
* Turn off the phone
* Turn on the phone in Recovery Mode (press and hold Home + Power + Volume
* Up buttons)
* Select Install update from sdcard
* Select update.zip
* Reboot

You should have seen SuperSU installed in your app drawer. Update SuperSU from Google Play Store later. Open it to double check if the phone is rooted correctly. Here is some screenshots of my phone verifying that root was successful.

![SM-G313HZ-root](http://i.imgur.com/dMLbf47.png)

![SM-G313HZ-root](http://i.imgur.com/KAqo8pF.png)

![SM-G313HZ-root](http://i.imgur.com/H9nHvEJ.png)

If you are thinking of uninstalling bloatwares, follow the post [Samsung ACE NXT (SM-G313HZ) Bloatware List](http://posts.minhazulhaque.com/android/samsung-ace-nxt-sm-g313hz-bloatware-list.html) and uninstall them.
