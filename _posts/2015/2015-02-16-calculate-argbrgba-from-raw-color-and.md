---
layout: post
title: "Calculate ARGB/RGBA from Raw Color and Alpha Value"
date: 2015-02-16 11:03:00
categories: cpp
---
RGBA or ARGB colors are created from 3 primary color values (RGB) and 1 value called alpha, combined into a single 32bit unsigned integer.

Here is a program to compose Alpha with any RGB color using shift technique.

```cpp
#include <iostream>
int main()
{
    /** ARGB Transformation **/
    int color = 0xEEDDCC;
    int alpha = 0xAA;
    /** Shift alpha to left by 24bits
    Create space for RGB values 3*8 = 24 bits **/
    color |= (alpha << 24);
    std::cout << "ARGB: " << std::hex << color << std::endl;
    /** RGBA Transformation **/
    color = 0xEEDDCC;
    /** Shift color to left by 8bits
    Create space for Alpha value by 8 bits **/
    color = (color << 8) | alpha;
    std::cout << "RGBA: " << std::hex << col << std::endl;
    return 0;
}
```

Result

```
ARGB: aaeeddcc
RGBA: eeddccaa
```

Thanks to [Ujjal vai](http://ujjal.net/) for making the shift thing clear enough. :D
