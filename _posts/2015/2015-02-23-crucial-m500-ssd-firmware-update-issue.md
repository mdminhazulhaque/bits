---
layout: post
title: "Crucial M500 SSD Firmware Update Issue"
date: 2015-02-23 16:57:00
categories: ssd
---
Yesterday I got a Crucial M500 240GB SSD with firmware revision MU03.

I downloaded [Crucial® Storage Executive](http://www.crucial.com/usa/en/support-storage-executive). After running the web ui, it prompted me to update the firmware version from MU03 to MU05. I confirmed the action and after rebooting some error message was shown before booting into Windows. I tried several times, but it failed every time.

Then I looked into the issue carefully. The update utility creates a temporary bootable device labeled "Micron" and the device couldn't boot due to some file missing. The error message shown was something like this (I don't remember it exactly).

    > Micron SSD Update Utility
    > initrd /core.gz
    > /core.gz not found

Then I rebooted my PC, entered into BIOS settings (for me it's Del button), **turned on UEFI Boot for Storage and Optical drives** and restarted the update process.

It took 3-4 minutes. The update operation was successful.
