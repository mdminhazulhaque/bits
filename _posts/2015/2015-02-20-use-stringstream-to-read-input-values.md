---
layout: post
title: "Use stringstream to Read Input Values from string"
date: 2015-02-20 01:39:00
categories: cpp
---
In C++, **cin** and **cout** is used to take standard input and output respectively from console. For debugging or testing, executing program and provide console input repeatedly might seem boring to anyone.

An alternative method to take inputs from a saved text file is known as piping. Let's analyze the following code.

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

This program will print 1 line that read from stdin. A piping can automate the input process. From shell let's do the following.

```
minhaz@minhaz-desktop ~> echo "the quick brown fox jumps over the lazy dog" | ./program
the quick brown fox jumps over the lazy dog
```

C-style freopen is often used to redirect a file to stdin. But creating another file, setting up freopen is too much for me. Haha. Here is a program that takes several inputs from console and prints them.

```cpp
#include <iostream>
using namespace std;
#define DEBUG(x) cout << #x << " = " << x << endl
int main()
{
    int one_kilobyte, number_of_the_beast;
    cin >> one_kilobyte >> number_of_the_beast;
    string my_name;
    cin >> my_name;
    double pi, golden_ratio;
    cin >> pi >> golden_ratio;
    string a_line;
    getline(cin, a_line);
    DEBUG(one_kilobyte);
    DEBUG(number_of_the_beast);
    DEBUG(my_name);
    DEBUG(pi);
    DEBUG(golden_ratio);
    DEBUG(a_line);
    return 0;
}
```

And here is the content that will be fed to the program.

```
1024 666
minhaz 3.14159 1.61803
the quick brown fox jumps over the lazy dog
```

Well, it would be better If I could hardcode the file content inside my code and use cin style operations of setting vales to variables. So I looked into
this issue and found stringstream can do that for me. Here is an workaround I tried.

```cpp
#include <iostream>
#include <sstream>
using namespace std;
#define DEBUG(x) cout << #x << " = " << x << endl
int main()
{
    /** hardcode the input file content **/
    string str = "1024 666"
                "minhaz 3.14159 1.61803"
                "the quick brown fox jumps over the lazy dog";
    /** create a stream **/
    stringstream stream(str);
    /** now use stream instead of cin **/
    int one_kilobyte, number_of_the_beast;
    stream >> one_kilobyte >> number_of_the_beast;
    string my_name;
    stream >> my_name;
    double pi, golden_ratio;
    stream >> pi >> golden_ratio;
    string a_line;
    getline(stream, a_line);
    DEBUG(one_kilobyte);
    DEBUG(number_of_the_beast);
    DEBUG(my_name);
    DEBUG(pi);
    DEBUG(golden_ratio);
    DEBUG(a_line);
    return 0;
}
```

As you can see I hardcoded the file content inside my program and used a stream instead of cin to set values of the variables. No console input or
piping is required. Here is the output.

```
one_kilobyte = 1024
number_of_the_beast = 666
my_name = minhaz
pi = 3.14159
golden_ratio = 1.61803
a_line = the quick brown fox jumps over the lazy dog
```
