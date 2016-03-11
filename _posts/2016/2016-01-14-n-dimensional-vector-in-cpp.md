---
layout: post
title: "Create N-Dimensional Vector with Preset Values in C++"
date: 2016-01-14 01:33:00
categories: CPP
---
A simple 2D vector can be initialized with preset values using fill constructor.

{% highlight cpp %}
int xdim = 5;
int ydim = 4;

vector<vector<string> > container(xdim, vector<string>(ydim, "1"));

for(int x=0; x<xdim; x++)
{
    for(int y=0; y<ydim; y++)
    {
        cout << container[x][y] << " ";
    }
    cout << endl;
}
{% endhighlight %}

This will result in a 5x4 vector of strings with "1" in each cell.

{% highlight cpp %}
1 1 1 1 
1 1 1 1 
1 1 1 1 
1 1 1 1 
1 1 1 1 
{% endhighlight %}

Similarly, a 3D vector can also be initialized like the following.

{% highlight cpp %}
int xdim = 5;
int ydim = 4;
int zdim = 3;

vector<vector<vector<string> > > container(
            xdim, vector<vector<string> >(
                ydim, vector<string>(zdim, "0")
                )
            );

for(int x=0; x<xdim; x++)
{
    for(int y=0; y<ydim; y++)
    {
        cout << "[";
        for(int z=0; z<zdim; z++)
        {
            cout << container[x][y][z];
        }
        cout <<"] ";
    }
    cout << endl;
}
{% endhighlight %}

This will result in a 5x4x3 vector of strings with "0" in each cell.

{% highlight cpp %}
[000] [000] [000] [000] 
[000] [000] [000] [000] 
[000] [000] [000] [000] 
[000] [000] [000] [000] 
[000] [000] [000] [000] 
{% endhighlight %}
