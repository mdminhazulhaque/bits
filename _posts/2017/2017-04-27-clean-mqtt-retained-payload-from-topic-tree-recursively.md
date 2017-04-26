---
layout: post
title: Clean MQTT Retained Payload from Topic Tree Recursively
date: 2017-04-27
categories: mqtt
---

I believe you are trying to clean retained messages from topics like the following by only providing the topic prefix `foo/`.

```
foo/bar
foo/bar/sensordata
foo/bar/temperature
foo/whatever
foo/this/is/a/long/nested/topic
```

Well I got an workaround. The trick is simple. Subscribe to topics using wildcard, then put a timer in `on_message` method. Everytime a message arrives at `on_message` function, send NULL byte to that topic. Also update the timer previously taken.

If no message arrives in a threshold amount of time, stop MQTT loop and exit the program.

```python
#!/usr/bin/python

# Written by Minhaz [mdminhazulhaque.io]

import sys
import time
import paho.mqtt.client as mqtt

start = time.time()

def on_message(mqttc, userdata, msg):
    global start
    start = time.time()
    if msg.payload == "" :
        print "Cleaned", msg.topic
        return
    
    mqttc.publish(msg.topic, None, 2, True)

def main(argv):
    host = "hostname"
    port = 1883
    topic = "foo"
    username = "user"
    password = "pass"
    threshold = 3 # seconds
    
    if topic == None:
        print("You must provide a topic to clear.\n")
        print_usage()
        sys.exit(2)
        
    mqttc = mqtt.Client()
    mqttc.on_message = on_message
    
    if username:
        mqttc.username_pw_set(username, password)

    mqttc.connect(host, port)
    mqttc.subscribe(topic + "/#", 2)
    
    while True:
        mqttc.loop()
        if time.time() - start > threshold:
            mqttc.disconnect()
            break
        
if __name__ == "__main__":
    main(sys.argv[1:])
```
