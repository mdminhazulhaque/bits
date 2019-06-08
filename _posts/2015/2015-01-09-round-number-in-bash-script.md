---
layout: post
title: "Round a Number in a Bash Script"
date: 2015-01-09 07:27:00
categories: linux
---
Bash only evaluates expressions with non-floating point numbers. So there is no built-in function for rounding up or down floating point numbers.

External commands like `bc` or `awk` or `perl` can be used to round numbers as needed. I have tried several methods. Among them, `printf` is quite fast. It uses automatic rounding (if the precision is equal to or greater than .5, rounds up else rounds down).

For example,

```bash
printf "%.0f\n" 123.456
printf "%.0f\n" 7.89
```

This will result in,

```bash
123
8
```

Unix commandline tool `awk` can also be used to round up or down numbers. awk has built in functions like int() to cast numbers as integers. Here is an example.

```bash
echo 123.456 | awk '{print int($1)}'
echo 7.89 | awk '{print int($1)}'
```

This will result in,

```bash
123
7
```

See? The precision part is always dropped. A custom function to round up or round down numbers can be written in awk. Here is what I tried.

```bash
echo 123.456 | awk '{print ($0-int($0)<0.499)?int($0):int($0)+1}'
echo 7.89 | awk '{print ($0-int($0)<0.499)?int($0):int($0)+1}'
```

It results,

```bash
123
8
```

It was an automatic rounding. To apply ceil() or floor() like functionality,
the following approach can be followed.

```bash
# floor
echo 1.23 | awk '{print int($0)}'
# ceil
echo 1.23 | awk '{print ($0-int($0)>0)?int($0)+1:int($0)}'
```

The output is,

```bash
1
2
```

Hope that helps.
