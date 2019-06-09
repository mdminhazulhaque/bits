---
layout: post
title: "Integer and String Conversion using C++ Generics"
date: 2015-06-30 22:10:00
category: cpp
---
I have created some template functions for string to int and int to string
conversion. The **typename** keyword came real handy. Although C++11 has
support for **to_string** and other type conversions.

```cpp
#include <iostream>
#include <sstream>

using namespace std;

template <typename T>
string to_str(T str)
{
    stringstream stream;
    stream << str;
    return stream.str();
}

template <typename T>
int to_int(T num)
{
    int val;
    stringstream stream;
    stream << num;
    stream >> val;
    return val;
}

int main()
{
    string s;
    s = to_str(42); // int
    cout << s << endl;
    s = to_str("42"); // string
    cout << s << endl;
    s = to_str(42.005); // float
    cout << s << endl;


    int n;
    n = to_int("103001"); // string
    cout << n << endl;
    n = to_int(103001); // int
    cout << n << endl;
    n = to_int(103001.100301); // float
    cout << n << endl;

    return 0;
}
```

Result

```
42
42
42.005
103001
103001
103001
```

Anyone has any better idea? Or some suggestion about the code? Let me know.
