---
layout: post
title: Join Data Files based on Keys using Bash
date: 2018-12-14
categories: linux
---

I was looking for a *nix tool that takes two or more input files and joins them like SQL JOIN statement does. And I was not surprised at all. I found `join`.

Say I have the following 2 files. Each of the files are sorted, and separated by colon. I wanted to join them according to their numeric IDs.

```
~ > cat companies
1:Apple
2:Microsoft
3:Google
4:Amazon
5:Intel

~ > cat locations
1:Cupertino, California, United States
2:Redmond, Washington, United States
3:Mountain View, California, United States
4:Seattle, Washington, United States
5:Santa Clara, California, United States
```

By default `join` will merge input files based on first key. For example,

```
~ > join -t: companies locations
1:Apple:Cupertino, California, United States
2:Microsoft:Redmond, Washington, United States
3:Google:Mountain View, California, United States
4:Amazon:Seattle, Washington, United States
5:Intel:Santa Clara, California, United States
```

In case the input files have keys in different positions, it is possible to specify which column contains the key. For example, I changed the `companies` file and shifted the key column to right.

```
~ > cat companies
Apple:1
Microsoft:2
Google:3
Amazon:4
Intel:5
```

This is the `join` command I will be using. Note that `-1 2` means the 1st file has its key in 2nd column.

```
~ > join -1 2 -t: companies locations
1:Apple:Cupertino, California, United States
2:Microsoft:Redmond, Washington, United States
3:Google:Mountain View, California, United States
4:Amazon:Seattle, Washington, United States
5:Intel:Santa Clara, California, United States
```
