---
layout: post
title: "Android-Javascript Bridge"
date: 2015-02-10 03:05:00
category: android
---
Last post I wrote about [Interfacing Javascript from Webview to native Android](http://blog.minhazulhaque.com/2015/02/interfacing-javascript-from-webview-to.html) was about one way communication from Javascript to Android activity.

Later I tried a duplex communication between Activity and Javascript. That means -

* Call Javascript methods from Android activity
* Call Android activity methods from Javascript

are possible.

###  Android to Javascript

In `MainActivity.java`

```java
String data = "Hello!";
webview.loadUrl("javascript:setData(\"" + data + "\");");
```
In `index.html`

```js
function setData(data) {
    alert(data);
    }
```

###  Javascript to Android

In `MainActivity.java`

```java
public class JSInterface {
    JSInterface() {}
    @JavascriptInterface
    public String getData() {
        return "Hello";
    }
}

webview.addJavascriptInterface(new JSInterface(), "JSInterface");
```

In `index.html`

```js
var data = JSInterface.getData();
alert(data);
```

Here is a preview of my setup where a javacript function is called when a button is clicked, and the javascrip call activity's function for current date
string.

![Android-Javascript-Bridge](https://github.com/mdminhazulhaque/Android-Javascript-Bridge/raw/master/screen/apple.png)

Check my repository [Android-Javascript-Bridge](https://github.com/mdminhazulhaque/Android-Javascript-Bridge) for full project source.
