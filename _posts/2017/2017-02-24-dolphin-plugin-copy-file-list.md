---
layout: post
title: "Dolphin Plugin: Copy File List"
date: 2017-02-24
tag: kde
---
The following KServiceMenu comes handy if you frequently need to copy the list of files in an specific folder. Simple put the following lines to `~/.local/share/kservices5/copy-file-list.desktop` and reload Dolphin.

```
[Desktop Action copy-file-list]
Exec=ls "%U" | xclip -selection clipboard
Name=Copy File List
Icon=edit-copy

[Desktop Entry]
Actions=copy-file-list
ServiceTypes=KonqPopupMenu/Plugin
MimeType=inode/directory
Type=Service
X-KDE-Priority=TopLevel
```

Note that this plugin requires `xclip` to be preinstalled.
