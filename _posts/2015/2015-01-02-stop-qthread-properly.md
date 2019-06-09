---
layout: post
title: "Stop QThread properly"
date: 2015-01-02 05:20:00
tag: qt
---
Are you annoyed with this message? When you try to terminate a thread while
quitting the main application thread, and this weird message appears after the
applications is closed?

  

    
    QThread: Destroyed while thread is still running

  
Try adding QThread::wait() before quitting the application. For example,

  

    
    thread->terminate();
    thread->wait();
    qApp->quit();

  
this will solve the problem for sure.

