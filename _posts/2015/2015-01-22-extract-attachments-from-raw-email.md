---
layout: post
title: "Extract Attachments from RAW Email"
date: 2015-01-22 11:02:00
category: others
---
I couldn't download any attachment from Gmail for the last couple of days. The problem might be with my ISP or my router's MTU who knows. So I tried to download the attachments embedded in the RAW email.

First I opened the RAW email from any mail's "Show Original" menu. Then a page with the attachments appeared encoded in base64 encoding. This page may be huge in size as all your attachments are embedded there. Save the page as `email.txt`.

Download mpack package using apt or rpm or pacman.

```bash
sudo apt-get -y install mpack
```

This is what I used on my Kubuntu system. Then I navigated to the directory I saved the email.txt file and fired up the munpack command.

```bash
minhaz@minhaz-desktop ~/download> munpack email.txt
Database.zip (application/zip)
www.zip (application/zip)
nginx.zip (application/zip)
minhaz@minhaz-desktop ~/download> 
```

You will then find the attachments extracted to that directory.
