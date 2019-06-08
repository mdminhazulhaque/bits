---
layout: post
title: "Find and Replace All Occurrences in a C++ String"
date: 2012-09-20 08:00:00
categories: cpp
---

I am familiar with QString and always use its overloaded functions like
replace(), remove() etc. It has automatic regex detection and very suitable
for OOP. But while using pure C++ (I mean no external API or library), I faced
some problems. I needed to find and replace ALL OCCURENCES of find text in a
string. std::string has replace function. But it requires string iterator,
text length etc. Again, it replaces only one string part at a time. So if you
need a replace_all function, You can do the following. I got this from
stackoverflow.com (unfortunately I forgot the link).


```cpp
void find_and_replace(string& source, string const& find, string const& replace)
{
    for(string::size_type i = 0; (i = source.find(find, i)) != string::npos;)
    {
        source.replace(i, find.length(), replace);
        i += replace.length();
    }
}
```

The program is very simple. It finds string position, replaces by given text
length and does it until the find position is at npos.

###  Example

This is a sample code.

```cpp
#include <iostream>

using namespace std;

void find_and_replace(string& source, string const& find, string const& replace)
{
    for(string::size_type i = 0; (i = source.find(find, i)) != string::npos;)
    {
        source.replace(i, find.length(), replace);
        i += replace.length();
    }
}

int main()
{
    string text;

    // simple replace
    text = "i have a blue house and a blue car";
    cout << "string:  " << text << endl;
    find_and_replace(text, "blue", "red");
    cout << "replace: " << text << endl;

    cout << endl;

    // simple replace 2
    text = "i love apple";
    cout << "string:  " << text << endl;
    find_and_replace(text, "apple", "banana");
    cout << "replace: " << text << endl;

    cout << endl;

    // simple replace 3
    text = "some-words-separated-by-hyphen";
    cout << "string:  " << text << endl;
    find_and_replace(text, "-", "_");
    find_and_replace(text, "hyphen", "underscore");
    cout << "replace: " << text << endl;

    cout << endl;

    // replace with empty string
    text = "this string has an is missing";
    cout << "string:  " << text << endl;
    find_and_replace(text, "is", "");
    cout << "replace: " << text << endl;

    cout << endl;

    // replace with space
    text = "hello;world;";
    cout << "string:  " << text << endl;
    find_and_replace(text, ";", " ");
    cout << "replace: " << text << endl;

    return 0;
}
```

###  Output

```
string:  i have a blue house and a blue car
replace: i have a red house and a red car

string:  i love apple
replace: i love banana

string:  some-words-separated-by-hyphen
replace: some_words_separated_by_underscore

string:  this string has an is missing
replace: th string has an  msing

string:  hello;world;
replace: hello world 
```
