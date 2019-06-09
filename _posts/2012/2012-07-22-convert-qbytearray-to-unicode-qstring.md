---
layout: post
title: "Convert QByteArray to Unicode QString"
date: 2012-07-22 17:16:00
category: qt
---
I was working with a networking based application. But when I requested data
with QNetworkAccessManager, I got the reply text like this one.

```
Ð˜Ð·ÑƒÑ‡ÐµÐ½Ð¸Ðµ Ð¸ Ð¾Ð±ÑƒÑ‡ÐµÐ½Ð¸Ðµ Ð¸Ð½Ð¾ÑÑ‚Ñ€Ð°Ð½Ð½Ñ‹Ñ… ÑÐ·Ñ‹ÐºÐ¾Ð² 
```

It happened because the page I was trying to download contains Unicode
characters. So I needed to convert the reply texts into Unicode so that I can
use them as QString. I just did the following:

```cpp
QByteArray reply8bit = networkreply->readAll();
QString replyUnicode = QString::fromLocal8Bit(reply8bit);
qDebug() << replyUnicode;
```

And viola! I got the Unicode back! Look...


```    
Изучение и обучение иностранных языков
```

So while using `QByteArray` as Unicode, just use `QString::fromLocal8bit()` function. :)
