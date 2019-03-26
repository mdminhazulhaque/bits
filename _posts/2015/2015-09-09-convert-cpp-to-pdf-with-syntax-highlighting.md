---
layout: post
title: "Convert CPP to PDF with Syntax Highlighting"
date: 2015-09-09 02:02:00
categories: CPP
---
I just had converted a bunch of CPP files to PDF with Syntax Highlighting. I think it will be helpful to share how I did that.

## Required Packages

* `enscript`
* `ps2pdf`

Use package manager to download them.

Now modify this script to your own configs.

```bash
#!/bin/bash

TARGET='/home/minhaz/cppfiles'

cd $TARGET

find . -type f -name '*.cpp' | while read CPPFILE
do
    TITLE=$(basename $CPPFILE .cpp)
    echo $CPPFILE | xargs enscript --color=1 -C -Ecpp -B -t $TITLE -o - | ps2pdf - $TITLE.pdf
done

```

Run the script and you'll find PDF files generated with the name of each CPP file.

Here is a preview of one CPP file I had.

![CPP to PDF](http://i.imgur.com/330ZKE6.png)

Cool, eh?
