---
layout: post
title: "Interfacing Javascript from Webview to native Android"
date: 2015-02-09 22:41:00
category: android
---
Native methods can be called from a Webview using JavaScript. To add a interface to webview, the method `addJavascriptInterface` can be used. Here is an example.

First, create a class with public methods with **@JavascriptInterface**
annotations (Not @Java**S**criptInterface).

```java
public class JSInterface {
...
@JavascriptInterface
public void toastMe(String text) {
    Toast.makeText(mContext, text, Toast.LENGTH_SHORT).show();
}
```

Then attach the class name as the Webview's JavascriptInterface.

```java
webview.addJavascriptInterface(new JSInterface(this), "JSInterface");
```

Call `JSInterface.toastMe(text)` from Webview's Javascript instance.

```js
var text = "I want to be toasted";
JSInterface.toastMe(text);
```

Here is a screenshot of the whole thing.

![Android-JavascriptInterface](https://github.com/minhazul-haque/Android-JavascriptInterface-Sample/raw/master/screen/toast.png)

I used the text from webview to show as Toast using native Java.

Get the complete project source from my Github repository [Android-JavascriptInterface-Sample](https://github.com/minhazul-haque/Android-JavascriptInterface-Sample).
