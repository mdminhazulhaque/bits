---
layout: post
title: FTP Daemon Management Script for OS X
date: 2016-03-20
categories: osx
---

OS X comes with a handy, built-in FTP Server located at `/usr/libexec/ftpd` which can be easily started from commandline. I prefer it than `pureftpd` or `proftpd`.

But the fact is, the program doesn't print any error message or help message even if the arguments are not correct or there was an error starting the FTP server. So I ended up looking into Stackoverflow and found the right command to start the FTP server properly. I created a small script named `ftpd` that can start, stop and print the status of the FTP daemon. It looks like Ubuntu service scripts. Heh heh!

Take a look at it.

```
#!/bin/bash

FTPD_PID=$(ps -eo pid,comm | grep '/usr/libexec/ftpd' | awk '{print $1}')

case $1 in
    start)
        sudo /usr/libexec/ftpd -d -D -l -U
        ;;
    stop)        
        if [ -z $FTPD_PID ]
        then
            echo "ftpd is not running"
            exit 1
        fi
        
        sudo kill -s kill $FTPD_PID
        ;;
    status)
        if [ -z $FTPD_PID ]
        then
            echo "ftpd is not running"
        else
            echo "ftpd is running, pid is $FTPD_PID"
        fi
    ;;
    *)
        echo "Usage: ftpd [start|stop|status]"
        ;;
esac
```

Install this script to `/usr/local/bin` or anywhere you like, and `chmod +x` it.

* To start the server, run `ftpd start`.
* To stop the server, run `ftpd stop`.
* To check status of the server, run `ftpd stauts`.
