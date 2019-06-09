---
layout: post
title: "Color Text in Windows Console"
date: 2015-01-03 01:42:00
tag: cpp
---
Coloring texts in a console isn't a great idea cause GUI widgets are preferable. But some people find it useful while scripting or creating a console application.

Coloring texts depends on the console application itself. For example, Linux terminals use special escape codes to set text and background colors. Windows console has come handlers that can be used for such purpose.

Here is an example code.

```cpp
#include <stdio.h>
#include <windows.h>
    
#define set_color(col) SetConsoleTextAttribute(console,col)
#define init_color() HANDLE console;console=GetStdHandle(STD_OUTPUT_HANDLE)
    
typedef enum
{
    BLUE = 0x9, GREEN, CYAN, RED, PINK, YELLOW, WHITE
} color;
    
int main()
{
    /** must be called right after main **/
    init_color();
    
    set_color(BLUE);
    printf("BLUE\n");
    
    set_color(GREEN);
    printf("GREEN\n");
    
    set_color(CYAN);
    printf("CYAN\n");
    
    set_color(RED);
    printf("RED\n");
    
    set_color(PINK);
    printf("PINK\n");
    
    set_color(YELLOW);
    printf("YELLOW\n");
    
    set_color(WHITE);
    printf("WHITE\n");
    
    return 0;
}
```

There can be more than 50 color combinations made. Take a look at <a href="http://msdn.microsoft.com/en-us/library/windows/desktop/ms682088(v=vs.85).aspx#_win32_character_attributes">MSDN</a> for more info on Console Screen Buffers attributes.

