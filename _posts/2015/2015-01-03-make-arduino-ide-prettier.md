---
layout: post
title: "Make Arduino IDE Prettier"
date: 2015-01-03 04:25:00
tag: linux
---
Arduino IDE is written in Java and it looks ugly as the default Look And Feel
(GTKLookAndFeel) sucks on Ubuntu or similar systems.

So changing it to other swing LAF would make it a bit more pretty.

To do so, open /usr/bin/arduino as root. Then change

```bash
# Ugly
java -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel processing.app.Base "$@"
```

to

```bash
# Pretty
java -Dswing.defaultlaf=javax.swing.plaf.nimbus.NimbusLookAndFeel processing.app.Base "$@"
```

After saving the file, run Arduino IDE. See the difference?

