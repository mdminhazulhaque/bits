---
layout: post
title: "Cut string between two XML nodes using GREP"
date: 2015-06-29 05:34:00
categories: linux
---
Say you want to extract some string between two patterns. GREP's Perl
integration does a nice job to perform such match.

For example, the string given is,

```html
<toplevel><suggestion data="hello kitty"/></toplevel>
```

And you want to extract between toplevel tags. The following GREP command do
it nicely.

```bash
grep -P -o '(?<=(<tag>)).*(?=(</tag>))'
```

The whole script is

```bash
#!/bin/bash

# STRING = <toplevel><suggestion data="hello kitty"/></toplevel>
# OUTPUT = <suggestion data="hello kitty"/>

RESPONSE_STR='<toplevel><suggestion data="hello kitty"/></toplevel>'

echo "$RESPONSE_STR" | grep -P -o '(?<=(<toplevel>)).*(?=(</toplevel>))'
```