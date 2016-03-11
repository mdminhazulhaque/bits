---
layout: post
title: "Increase and decrease a number between two min and max values"
date: 2015-01-02 21:46:00
categories: CPP
---
Increasing and decreasing a number between two bounds is rather important in most cases. I used it mostly in OpenGL scenes to render objects from min to
max value and from max to min. The algorithm is quite simple. Shortly,

* Set a flag.
* If the flag is true, decrease the value.
* Else increase the value.
* If the value is greater than maximum point, set flag to true.
* Else if the value is lower than minimum point, set flag to false.
* Print value.

Let's analyze the following code.

```cpp
#include<iostream>
#include<iomanip>
using namespace std;
int main()
{
    bool flag = false;
    int value = 0;
    int minvalue = 0;
    int maxvalue = 20;

    while(true)
    {
        if(flag)
            value--;
        else
            value++;

        if(value>maxvalue)
            flag=true;
        else if(value<minvalue)
            flag=false;

        cout << value << endl;

        usleep(100000);
    }
    return 0;
}
```

Output if this code will be the following.

```cpp
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
20
19
18
17
16
15
14
13
12
11
10
9
8
7
6
5
4
3
2
1
```

You can see that the program gradually harmonizes the numbers. Let's add some
visual effort for better understanding. We change

```cpp
cout << value << endl;
```

To

```cpp
cout << setw(value) << setfill('*') << ' ' << endl;
```

Now the program looks like the following.

```cpp
#include<iostream>
#include<iomanip>
using namespace std;
int main()
{
    bool flag = false;
    int value = 0;
    int minvalue = 0;
    int maxvalue = 20;

    while(true)
    {
        if(flag)
            value--;
        else
            value++;

        if(value>maxvalue)
            flag=true;
        else if(value<minvalue)
            flag=false;

        cout << setw(value) << setfill('*') << ' ' << endl;

        usleep(100000);
    }
    return 0;
}
```

And now the output is more effective and easier to understand.

```cpp
* 
** 
*** 
**** 
***** 
****** 
******* 
******** 
********* 
********** 
*********** 
************ 
************* 
************** 
*************** 
**************** 
***************** 
****************** 
******************* 
******************** 
******************* 
****************** 
***************** 
**************** 
*************** 
************** 
************* 
************ 
*********** 
********** 
********* 
******** 
******* 
****** 
***** 
**** 
*** 
** 
*
```

Quite easy, eh?

