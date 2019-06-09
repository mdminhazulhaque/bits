---
layout: post
title: "Bash: Check If Script is Running through Pipe"
date: 2015-01-09 07:54:00
category: linux
---
Bash scripts can be run directly with arguments, or through pipes.

Most unix programs like wc, grep, awk supports pipe mode. Which means, external data is is redirected into the program as stdin.

Here is an example script to test if the script is running through pipe or not.

```bash
#!/bin/bash

if read -t 0
then
    echo "Running in pipe mode"
    data=$(cat)
    echo "Data: $data"
else
    echo "Running in normal mode"
    echo "Arguments: $@"
fi
```

Let's execute it directly.

```bash
minhaz@desktop ~> ./test 'Hello World'
Running in normal mode
Arguments: Hello World
```

And try again using pipe.

```bash
minhaz@desktop ~> echo 'Hello World' | ./test
Running in pipe mode
Pipe Data: Hello World
```

Make sure you run the sript with bash, not sh. Otherwise the following error message may appear.

```bash
read: Illegal option -t
```
