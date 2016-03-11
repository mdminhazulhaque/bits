---
layout: post
title: "Sort A Vector Of Pairs Based On First Or Second Element"
date: 2012-11-12 14:04:00
categories: CPP
---
Any vector can be sorted using STL of C++. In fact, templates like vector,
list etc have function sort() inline. But when sorting a vector of pairs based
on first or second element we need to use algorithm::sort in an special way.
Just look at the code.

```cpp
#include<iostream>
#include<vector>
#include<algorithm> // For sort()

using namespace std;

bool compare(const pair<float,string>&i, const pair<float,string>&j)
{
    return i.first > j.first;
}
int main()
{
    // Simple vector to store pairs
    vector<pair<float,string> >os;

    // Put some random data
    os.push_back(pair<float,string>(1.58, "Linux"));
    os.push_back(pair<float,string>(5.11, "Android"));
    os.push_back(pair<float,string>(68.16, "Windows"));
    os.push_back(pair<float,string>(8.45, "OS X"));
    os.push_back(pair<float,string>(9.89, "iOS"));
    os.push_back(pair<float,string>(5.41, "Other"));

    // Sort it
    sort(os.begin(),os.end(),compare);

    // Print
    for(int i=0;i<os.size();i++)
        cout << os.at(i).second << " (" << os.at(i).first << "%)"<< endl;
}
```
    
The output of the code is

```
Windows (68.16%)
iOS (9.89%)
OS X (8.45%)
Other (5.41%)
Android (5.11%)
Linux (1.58%)
```

As you see, the _**compare**_ function provides comparison for items. We can
modify this to change sorting order.
