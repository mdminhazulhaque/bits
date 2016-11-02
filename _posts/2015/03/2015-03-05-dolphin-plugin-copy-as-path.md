---
layout: post
title: "Dolphin Plugin: Copy as path"
date: 2015-03-05 14:21:00
categories: Linux
---
I was missing the feature of **Copy filename as path** in Dolphin (KDE File Manager). So I created one by myself. You need **xclip** installed for this.

Create a file named `copyaspath.desktop` in the following directory.

    ~/.kde/share/kde4/services/ServiceMenus

For KDE5, use the following directory (thanks to Peter).

    ~/.local/share/kservice5

Replace minhaz with your username. Then add the following lines to the file
**copyaspath.desktop**.

    [Desktop Entry]
    Type=Service
    Icon=editcopy
    Actions=copyaspath
    X-KDE-Priority=TopLevel
    ServiceTypes=KonqPopupMenu/Plugin,application/octet-stream
    [Desktop Action copyaspath]
    Exec=echo "%F" | tr -d '\n' | xclip -selection clipboard
    Icon=editcopy
    Name=Copy as path

I have added **tr** command to trim the newline which may cause a forced
return while pasting the text in a terminal.

Now reopen Dolphin. A top-level context menu named "Copy as path" should
appear. Clicking it will copy the absolute name of the file to clipboard.


[![](http://i.imgur.com/3uLH7qs.png)](http://i.imgur.com/3uLH7qs.png)
