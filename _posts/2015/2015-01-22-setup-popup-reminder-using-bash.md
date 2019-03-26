---
layout: post
title: "Setup A Popup Reminder Using Bash"
date: 2015-01-22 15:40:00
categories: Linux
---
Well, who doesn't forget the milk on the stove while working on computer? I do.

There are bunch of applications and desktop widgets to do the reminder thing for you. Even I wrote a C++ application to remind me things which is uploaded [here](https://github.com/minhazul-haque/Reminder). But being a minimalist user, I like to cut short the list of applications I use.

Minutes ago an idea just came into my mind that I could use bash and kdialog/zenity to setup such reminder. The sleep command is built in for all Linux/Mac OSs. Here is what I did to setup a minimal reminder popup in minutes.

Install kdialog or zenity. If you are using KDE, kdialog should come built-in. Gnome or Unity environments also comes with zenity preinstalled.

Then use the sleep command and set kdialog or zenity with a message which you want to show. For example, to set a reminder about "Call mom" after 10 minutes, simply do the following.

```bash
sleep 10m && kdialog --msgbox "Call mom"
```

Or for zenity, do this.

```bash
sleep 10m && zenity --info --text "Call mom"
```

If you don't want to keep the terminal on, simply put an ampersand at the end of the command. This will run the process in the background.

To discard the timer, simple press Ctrl+C which will terminate the sleep command. Or if you run the command in background, use the kill command along with the PID given after executing the command.

For example,

```bash
minhaz:~$ sleep 10 && kdialog --msgbox "Remember the milk"&
[1] 485
minhaz:~$ kill 485
```
