---
layout: post
title: "Remove Unnecessary Fonts from Mac OS X"
date: 2015-03-02 15:22:00
categories: mac
---
Months ago I got a Macbook Air with Mac OS X Yosemite installed.

Mac OS X comes with an wide range of fonts for all languages and scripts. For example they came up with several cool **Bengali** fonts which renders far better than Windows or Linux fonts. (Windows fonts suck btw).

When I work with web projects, or writing with Pages or other apps, I had to go through a huge list of unnecessary fonts. For example, fonts for Arabic, China, Korean, Hindi, Myanmar, Tamil, Telugu etc are totally unnecessary for me. So I opened the app Font Book and selected which fonts to remove. Then I manually "**rm -rf**"ed the fonts. Here is the list of fonts I removed.

    rm -rf /Library/Application\ Support/Fonts/ヒラギノ*
    rm -rf /Library/Application\ Support/Fonts/儷*
    rm -rf /Library/Application\ Support/Fonts/华*
    rm -rf /Library/Fonts/AppleGothic.ttf
    rm -rf /Library/Fonts/AppleMyungjo.ttf
    rm -rf /Library/Fonts/AppleSDGothicNeo-*
    rm -rf /Library/Fonts/Baoli.ttc
    rm -rf /Library/Fonts/Han*
    rm -rf /Library/Fonts/Hei*
    rm -rf /Library/Fonts/Hiragino*
    rm -rf /Library/Fonts/Kaiti.ttc
    rm -rf /Library/Fonts/Lantinghei.ttc
    rm -rf /Library/Fonts/Libian.ttc
    rm -rf /Library/Fonts/Malayalam*
    rm -rf /Library/Fonts/Myanmar*
    rm -rf /Library/Fonts/NISC18030.ttf
    rm -rf /Library/Fonts/Nanum*
    rm -rf /Library/Fonts/NewPeninimMT.ttc
    rm -rf /Library/Fonts/Oriya*
    rm -rf /Library/Fonts/Osaka*
    rm -rf /Library/Fonts/PCmyoungjo.ttf
    rm -rf /Library/Fonts/PT*
    rm -rf /Library/Fonts/Pilgiche.ttf
    rm -rf /Library/Fonts/STIX*
    rm -rf /Library/Fonts/Sathu.ttf
    rm -rf /Library/Fonts/Silom.ttf
    rm -rf /Library/Fonts/Sinhala*
    rm -rf /Library/Fonts/Songti.ttc
    rm -rf /Library/Fonts/SukhumvitSet.ttc
    rm -rf /Library/Fonts/Tamil*
    rm -rf /Library/Fonts/Telugu*
    rm -rf /Library/Fonts/Wawa*
    rm -rf /Library/Fonts/Weibei*
    rm -rf /Library/Fonts/Xingkai.ttc
    rm -rf /Library/Fonts/Yu*
    rm -rf /System/Library/Fonts/HiraKakuInterface*
    rm -rf /System/Library/Fonts/STHeiti*
    rm -rf /System/Library/Fonts/ヒ*
    
But wait, if you are willing to do so, do on your own risk. It might show errors while upgrading OS X if you remove core Apple components.