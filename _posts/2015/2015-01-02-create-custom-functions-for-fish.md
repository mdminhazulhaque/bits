---
layout: post
title: "Create custom functions for Fish"
date: 2015-01-02 21:54:00
tag: linux
---
[Fish](http://ridiculousfish.com/shell/) has become my favorite shell for the last several months. Most lovely features of it are - auto-complete, auto- capitalization and colorful text. I use fish shell as my default shell with [Konsole](http://konsole.kde.org/) on my KDE 4.10 desktop.

Creating functions and aliases for bash was easy (adding them to **.bashrc** or **.bash_profile**). But fish has a bit different interpretor. It stores
functions as a copy of mostly used and common commands to provide arguments suggestion. Default fish functions are stored at `/usr/share/fish/functions`.

Well, I don't want to interfere with their read-only territory. Instead I would create custom functions in my home folder. Configuration path of fish in
my home is `/home/me/.config/fish/functions`.

I wanted to use a function that will execute [aria2c](http://aria2.sourceforge.net/) with my favorite arguments (-x 8 -c link). I also wanted to shorten the name to a 2/3 digit alias. To make it done do the following -

* Choose name of my cherished alias. Make sure that it does not match any other alias or command name.I chose 'dl' which is a short form of download.
* Create a file called dl.fish in /home/you/.config/fish/functions
* Open the file in text editor, Kate worked fine for me. Hit nano if you hate GUI.
* Inside that file, paste the following text.

```bash
function dl --description "Parallel and resumable download with aria2c"
    aria2c -c -x 4 $argv[1]
end
```

*  The syntax is very simple. Write the function name, add some description and pass arguments of the function in c-style (argv[1] = first argument), not in bash-way ($1 = first argument).
* Save it, and restart fish.
* Now hit any link like the following.

```bash
dl http://google.com
```

*  If you see aria2c is working, be assured that you have created a custom fish function.

```bash
you@yourpc ~> dl http://google.com
[#1 SIZE:0B/0B CN:1 SPD:0Bs]                                                                 
2013-03-19 04:40:31.054353 NOTICE - Download complete: /home/you/index.html

Download Results:
gid|stat|avg speed  |path/URI
===+====+===========+===========================================================
    1|  OK|   7.3KiB/s|/home/you/index.html

Status Legend:
    (OK):download completed.
```

Now go away and create more functions!
