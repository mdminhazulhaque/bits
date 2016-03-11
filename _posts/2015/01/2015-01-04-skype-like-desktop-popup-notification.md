---
layout: post
title: "Skype-like Desktop Popup Notification in Qt"
date: 2015-01-04 05:50:00
categories: Qt
---
Qt has no popup desktop notification applet by default. As Qt is highly customizable and almost all widgets are inherited from QWidget, so a custom QWidget can be used as desktop popup applet.

A QWidget instance will be shown like any other top-level window. The following flags can be set to make it look like a popup unlike general window.

```cpp
setWindowFlags(
                Qt::Window | // Add if popup doesn't show up
                Qt::FramelessWindowHint | // No window border
                Qt::WindowDoesNotAcceptFocus | // No focus
                Qt::WindowStaysOnTopHint // Always on top
                );
```

To hide it from appearing in the task manager, call this function inside the
constructor.

```cpp
setAttribute(Qt::WA_ShowWithoutActivating);
```

There it goes. It looks like the following image. I added a label and button
to manage the popup from being closed on button press.

![Popup](http://i.imgur.com/Ie7tE3S.png)

Check my [DesktopPopup](https://github.com/minhazul-haque/DesktopPopup) on Github for more detailed example.
