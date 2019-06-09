---
layout: post
title: Increase Jenkins Session Timeout Value on Ubuntu
date: 2017-04-30
tag: jenkins
---

I know it's annoying when you are logged out of your own local system withing a short period of time, right? You can set a custom Session Timeout value for Jenkins so you will not be kicked out of your system frequently. Simple open the following file in editor.

```bash
nano /etc/default/jenkins
```

Then do add `--sessionTimeout=480` after `JENKINS_ARGS`. So the line will look like the following.

```bash
JENKINS_ARGS="--webroot=/var/cache/$NAME/war --httpPort=$HTTP_PORT --sessionTimeout=480"
```

Now what? Restart Jenkins service and you are done. :)