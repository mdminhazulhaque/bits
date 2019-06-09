---
layout: post
title: "Dolphin Plugin: Copy as path"
date: 2015-03-05 14:21:00
tag: linux
---

I was missing the feature of `Copy File Path` in Dolphin (KDE File Manager). So I created one by myself. You need `xclip` installed for this.

Create a file named `copy-path.desktop` in the following directory.

    ~/.kde/share/kde4/services/ServiceMenus

For KDE5, use the following directory (thanks to Peter).

    ~/.local/share/kservices5

Then add the following lines to the file `copy-path.desktop`.

    [Desktop Action copy-path]
    Exec=echo "%U" | tr -d '\n' | xclip -selection clipboard
    Name=Copy Path
    Icon=edit-copy

    [Desktop Entry]
    Actions=copy-path
    ServiceTypes=KonqPopupMenu/Plugin
    MimeType=all/all
    Type=Service
    X-KDE-Priority=TopLevel

I have added `tr` command to trim the newline which may cause a forced return while pasting the text in a terminal.

Now reopen Dolphin. A top-level context menu named "Copy as path" should appear. Clicking it will copy the absolute name of the file to clipboard.

![Dolphin Copy File Path](http://i.imgur.com/HUR1NDP.png)

> 2017-02-21 EDIT: Now you can copy directory path also!
