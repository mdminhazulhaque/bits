---
layout: post
title: "Forget freopen, Use std::rdbuf to Redirect cin and cout"
date: 2015-02-20 03:26:00
categories: CPP
---
C-style legacy codes should not be written inside a C++ program.

freopen is used to redirect stdin and stdout from and to any file. As C++ uses streams, cin and cout are linked to standard input and standard output respectively. They offer an alternative method to work with C FILE streams. C++ streams can be redirected to other streams and cleared easily. Because ifstream and ofstream uses streambuffer internally.

Here is an workaround that shows how freopen can be avoided, and do the redirection thing in proper C++ way.

```cpp
#include <iostream>
#include <fstream>
#include <string>
using namespace std;
#define DEBUG(x) cout << #x << " = " << x << endl
int main()
{
    /** backup cin buffer and redirect to in.txt **/
    ifstream in("in.txt");
    streambuf *cinbuf = cin.rdbuf();
    cin.rdbuf(in.rdbuf());
    /** backup cout buffer and redirect to out.txt **/
    ofstream out("out.txt");
    streambuf *coutbuf = cout.rdbuf();
    cout.rdbuf(out.rdbuf());
    /** do some cin **/
    int one_kilobyte, number_of_the_beast;
    double pi, golden_ratio;
    string my_name;
    cin >> one_kilobyte
        >> number_of_the_beast
        >> my_name
        >> pi
        >> golden_ratio;
    /** do some cout **/
    DEBUG(one_kilobyte);
    DEBUG(number_of_the_beast);
    DEBUG(my_name);
    DEBUG(pi);
    DEBUG(golden_ratio);
    /** reset cin and cout buffer **/
    cin.rdbuf(cinbuf);
    cout.rdbuf(coutbuf);
    return 0;
}
```

Contents of in.txt -

```
1024
666
minhaz
3.14159
1.61803
```

Content of out.txt after running the program -

```
one_kilobyte = 1024
number_of_the_beast = 666
my_name = minhaz
pi = 3.14159
golden_ratio = 1.61803
```

I got the idea of using rdbuf from [How to redirect cin and cout to files?](http://stackoverflow.com/a/10151286/1288414)
