---
layout: post
title: "Tautology/Contradiction Expression Verification"
date: 2012-07-15 17:49:00
categories: cpp
---

Tautology is a logical expression which is always true for any values of its
variables. On the other hand, contradiction is a logical expression which is
always false for any values of its variables. For example, the following
expression will be a tautology if it is true for any p=1/0 and q=1/0.

Again, the following expression is always false whether p is 0 or 1. So it is
a contradiction.

I just wrote a program to check two variable expression either it is a
tautology or contradiction. I used QString because it has easier find and
replace all feature. Although custom C++ functions can be used to do the
replace thing. Check my code. I used the following characters as logical
characters because standard keyboards don't have the AND, OR etc sign.

    & - AND
    | - OR
    ! - NOT
    > - Implies if
    <> - Only if

### Code

```cpp
#include <iostream>
#include <list>

using namespace std;

void find_and_replace(string& source, string const& find, string const& replace)
{
    for(std::string::size_type i = 0; (i = source.find(find, i)) != std::string::npos;)
    {
        source.replace(i, find.length(), replace);
        i += replace.length() - find.length() + 1;
    }
}
void replaceByRules(string& input)
{
    while(input.size() != 1)
    {
        //NOT
        find_and_replace(input, "!1","0");
        find_and_replace(input, "!0","1");
        //AND
        find_and_replace(input, "1&1","1");
        find_and_replace(input, "0&0","0");
        find_and_replace(input, "0&1","0");
        find_and_replace(input, "1&0","0");
        //OR
        find_and_replace(input, "1|1","1");
        find_and_replace(input, "0|0","0");
        find_and_replace(input, "1|0","1");
        find_and_replace(input, "0|1","1");
        //->
        find_and_replace(input, "1>1","1");
        find_and_replace(input, "1>0","0");
        find_and_replace(input, "0>1","1");
        find_and_replace(input, "0>0","1");
        //<>
        find_and_replace(input, "1<>1","1");
        find_and_replace(input, "1<>0","0");
        find_and_replace(input, "0<>1","0");
        find_and_replace(input, "0<>0","1");
        //Brackets
        find_and_replace(input, "(1)","1");
        find_and_replace(input, "(0)","0");
    }
}
void makeLogic(string& input, const string& a, const string& b)
{
    find_and_replace(input, "p",a);
    find_and_replace(input, "q",b);
    replaceByRules(input);
}
void verifyExpression(string& input)
{
    string p0q0, p0q1, p1q0, p1q1;
    p0q0 = p0q1 = p1q0 = p1q1 = input;

    makeLogic(p0q0, "0", "0");
    makeLogic(p0q1, "0", "1");
    makeLogic(p1q0, "1", "0");
    makeLogic(p1q1, "1", "1");

    if(p0q0==p0q1 and p0q1==p1q0 and p1q1=="1")
        cout << input << " is a Tautology" << endl;
    else if(p0q0==p0q1 and p0q1==p1q0 and p1q1=="0")
        cout << input << " is a Contradiction" << endl;
}
int main()
{
    list<string> input;
    input.push_back("(p&q)|(!p)|(!q)");
    input.push_back("(p&q)>p");
    input.push_back("p>(p|q)");
    input.push_back("((p|q)&p)>p");
    input.push_back("p&!p");
    for(int i=0; i<6; i++)
    {
        verifyExpression(input.front());
        input.pop_front();
    }
    return 0;
}
```
