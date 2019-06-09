---
layout: post
title: "Split C++ String by Single Character Delimiter"
date: 2015-01-03 04:51:00
tag: cpp
---
A string can be sliced into a vector of strings by invoking the `std::getline` method.

Here is an example.

```cpp
#include <iostream>
#include <vector>
#include <sstream>

using namespace std;

vector<string> split(const string& s, char delim)
{
    vector<string> elems;
    stringstream ss(s);
    string item;

    while (getline(ss, item, delim))
        elems.push_back(item);

    return elems;
}
int main()
{
    vector<string> words = split("lorem_ipsum_dolor_sit_amet_no_tota_tacimates_delicata_eum",
                                '_');

    for(int i=0; i<words.size(); i++)
        cout << words.at(i) << endl;

    return 0;
}
```

Output

```
lorem
ipsum
dolor
sit
amet
no
tota
tacimates
delicata
eum
```
