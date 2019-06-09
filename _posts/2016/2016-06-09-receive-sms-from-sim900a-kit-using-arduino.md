---
layout: post
title: Receive SMS from SIM900A Kit using Arduino
date: 2016-06-09
category: arduino
---

Sending SMS through SIM900A Kit is quite easy. You just need to turn on text based composition mode, write the text and send 0x1a. Here is an example. Note that SIM900A is an instance of `SoftwareSerial` class connected via Serial interface of the Arduino.

```cpp
String number = "+880123456789";
String content = "Hello, World!";

SIM900A.println("AT+CMGF=1"); // Turn on plain text mode
SIM900A.println("AT+CMGS=\"" + number + "\"\r");
SIM900A.println(content);
SIM900A.println((char)26); // Done
```

But when it comes to the point of receiving SMS, what to do? I had to read the SIM900A AT Command list and found out a perfect solution. By default, upon receiving SMS, the SIM900A Kit prints a string that contains information like index of the SMS, sender number, timestamp etc. Then you'll have to type `AT+CMGR=1` (where 1 is the index number of SMS) to read a specific SMS from memory and `AT+CMGD=1` to delete the SMS. List of all SMS can be seen using `AT+CMGL="ALL"` command.

The solution I found is, turning on SMS buffer to TE (Terminal Equipment) so whenever any SMS is received, the content is forwarded directly to the TE. To do so, you'll need to set CNMI flag like the following.

```cpp
SIM900A.println("AT+CNMI=2,2,0,0,0");
```

After turning on the CNMI mode to buffer all SMS content to terminal, the following strings were found in the serial interface.

```

+CMT: "+880123456789","","16/05/24,07:40:32+24"
Hello there, this is test message.


+CMT: "+880123456789","","16/05/24,07:40:39+12"
Hello there, this is another test message.

```

Note that each serial event is prefixed and postfixed by `\r\n` instead of simple `\n`.

I wrote up a function that reads each serial event of SIM900A into a string. This will help us to clip, remove or split strings according to our needs.

```cpp
String readSIM900A()
{
    String buffer;

    while (SIM900A.available())
    {
        char c = SIM900A.read();
        buffer.concat(c);
        delay(10);
    }

    return buffer;
}
```

I know this is not so memory efficient, but it gets the job done, right? Well, let's use this function for detecting incoming SMS events from SIM900A serial data.

```cpp
void setup()
{
    Serial.begin(9600);
    SIM900A.begin(9600);
}

void loop()
{
    String buffer = readSIM900A();

    if (buffer.startsWith("\r\n+CMT: "))
    {
        Serial.println("*** RECEIVED A SMS ***");
    }
    
    delay(100);
}
```

So the incoming SMS event can be detected. Now let's parse the buffer variable to get the content of the SMS.

This is the pattern of incoming SMS notification from SIM900A.

```
\r\n+CMT: "SENDER NUMBER","","yy/mm/dd,hh:mm:ss+ms"\r\nSMS BODY\r\n
```

Now it is obvious that,

* Length of phone number `+880123456789` is 13
* Length of header `\r\n+CMT: "","","yy/mm/dd,hh:mm:ss+ms"\r\n` is 38

So if we skip first 13+38 = 51 characters from `buffer` object, we will get the SMS body. Again, we need to clip last 2 characters because they will contain `\r\n`. So let's rewrite the `loop()` function like the following.

```cpp
void loop()
{
    String buffer = readSIM900A();

    if (buffer.startsWith("\r\n+CMT: "))
    {
        Serial.println("*** RECEIVED SMS ***");
        
        // Remove first 51 characters
        buffer.remove(0, 51);
        int len = buffer.length();
        // Remove \r\n from tail
        buffer.remove(len - 2, 2);
        
        Serial.println(buffer);
        
        Serial.println("*** END SMS ***");
    }

    delay(100);
}
```

Now send SMS to SIM900A kit and SMS contents should appear like the following.

```
*** RECEIVED SMS ***
Hello there, this is test message.
*** END SMS ***
*** RECEIVED SMS ***
Hello there, this is another test message.
*** END SMS ***
```

I hope that is enough. If you think you got a better method to achieve this, feel free to share in the comment box. :)

Good luck with your SIM900A exploring project!
