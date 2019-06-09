---
layout: post
title: Find An Image in Another Image using OpenCV and NumPy
date: 2017-07-12
tag: opencv
---

Several days ago, I needed to catch new message notification from Skype4Linux. As far I know they do not provide any API (like dbus or HTTP API like Skype 4.3 native) to catch new message event. So I deciced to monitor the system tray of my desktop and look for the unread icon that Skype shows. Finally I had myself written a tiny Python script that serves the purpose.

As a first step, I had to find a small image (24x24 pixels) in a large image (system tray, 400x60 pixels). OpenCV comes with a handy function named `matchTemplate` that provides a matrix of best match of a matrix in another matrix (there are several methods on doing this although). I took advantage of the function `where` of NumPy because it provides setting a threshold level of the match. So here is the `has_image` function I wrote.

```python
def has_image(haystack, needle):
    haystack = cv2.cvtColor(haystack, cv2.COLOR_BGR2GRAY)
    needle = cv2.cvtColor(needle, cv2.COLOR_BGR2GRAY)
    w, h = needle.shape[::-1]
    res = cv2.matchTemplate(haystack, needle, cv2.TM_CCOEFF_NORMED)
    threshold = 0.99
    loc = np.where(res >= threshold)
    try:
        assert loc[0][0] > 0
        assert loc[1][0] > 0
        return (loc[1][0], loc[0][0])
    except:
        return (-1, -1)
```

For now let's put aside the Skype thing. Say we will find a strawberry in a photo of some fruits. Here is the photo of all the fruits (credit goes to medicalnewstoday.com).

![Fruits](http://i.imgur.com/WvJG9i1.jpg)

And the tiny little strawberry we will look for.


![Strawberry](http://i.imgur.com/V3YYpTq.jpg)

The following is my final code to find out the image and draw a rectangle over it.

```python
if __name__ == "__main__":
    fruits = cv2.imread("mixed-fruits.jpg")
    strawberry = cv2.imread("strawberry.jpg")
    
    x, y = has_image(fruits, strawberry)
    
    if x >= 0 and y >= 0:
        w, h, _ = strawberry.shape
        cv2.rectangle(fruits, (x, y), (x+h, y+w), (255, 0, 0), 2)
        cv2.imshow("Found the strawberry at (%d,%d)" % (x, y), fruits)
        cv2.waitKey(0xFFFF)
    else:
        print("Not found")
```

This is the result I got using the code I wrote.

![Result](http://i.imgur.com/IGToZqI.png)

That was some real fun. I hope someone out there will find this snippet helpful. :D

> Anyway, you will find my Skype4Linux notifier project [here](https://github.com/minhazul-haque/skype4linux-notifier).
