---
layout: post
title: "Bash: Regexp for MAC Address Validation"
date: 2015-01-09 08:16:00
categories: linux
---
MAC Address aka HWAddress is a unique identifier assigned to network interfaces.

The address can be accessed using ifconfig utility. It is a 12 digit hexadecimal number, spearated by 5 colons, with 2 digits in pair. The following regexp is the best validator I found.

```bash
"^([0-9A-F]{2}:){5}[0-9A-F]{2}$"
```

### Explaination

* ^ and $ means start and end of the string respectively.
* A hexadecimal string ranges from 0 to 9 and A to F.
* The number of fitst hexadecimal pair and one colon is 5
* The last hexadecimal pair has no colon

### Example

```bash
#!/bin/bash

MAC_ADDR='94:de:80:2b:81:a9'
# capitalize it for faster regexp match
MAC_ADDR=${MAC_ADDR^^}

if [ `echo $MAC_ADDR | egrep "^([0-9A-F]{2}:){5}[0-9A-F]{2}$"` ]
then
    echo "Valid"
else
    echo "Invalid"
fi
```

### Output

```
Valid
```
