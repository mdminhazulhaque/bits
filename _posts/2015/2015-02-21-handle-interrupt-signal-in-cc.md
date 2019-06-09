---
layout: post
title: "Handle Interrupt Signal in C/C++"
date: 2015-02-21 14:27:00
tag: c
---
Keyboard shortcut like Ctrl+C is used to pass SIGTERM event to program.

A signal handler can be set to catch when Ctrl+C is pressed to avoid execution termination. Here is a program that avoids Ctrl+C event 3 times then exits.

```cpp
#include <stdio.h>
#include <signal.h>
#define msleep(t) usleep(1000*(t))
unsigned int ctrl_c_count = 0;
void signal_handler()
{
    if(++ctrl_c_count == 3)
    {
        printf("ok ok, you pressed ctrl+c 3 times, quitting\n");
        exit(0);
    }
    printf("i said, ctrl+c cannot stop me\n");
}
int main()
{
    signal(SIGINT, signal_handler);
    while(1)
    {
        printf("you cannot stop me by pressing ctrl+c\n");
        msleep(500);
    }
    return 0;
}
```

Output

```
minhaz@minhaz-desktop ~> ./signal-term-test
you cannot stop me by pressing ctrl+c
you cannot stop me by pressing ctrl+c
you cannot stop me by pressing ctrl+c
^Ci said, ctrl+c cannot stop me
you cannot stop me by pressing ctrl+c
you cannot stop me by pressing ctrl+c
you cannot stop me by pressing ctrl+c
^Ci said, ctrl+c cannot stop me
you cannot stop me by pressing ctrl+c
you cannot stop me by pressing ctrl+c
you cannot stop me by pressing ctrl+c
^Cok ok, you pressed ctrl+c 3 times, quitting
```
