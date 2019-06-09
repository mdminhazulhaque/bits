---
layout: post
title: "OpenCV3 with Qt5 on Mac OS X"
date: 2016-01-12 12:37:00
tag: mac
---
Qt Creator is a great IDE to work with C++ projects and libraries. I have always been using Ubuntu for projects and research works. Almost all libraries can be found in Ubuntu repository. Recently, I had to configure OpenCV on Mac OS X. I was using Qt5 prebuilt binaries downloaded from [qt.io](http://www.qt.io/download-open-source/). The copies of OpenCV libraries came from [brew](http://brew.sh/). When I added OpenCV flags to Qt project file, I got the following error message.

```
Undefined symbols for architecture x86_64
```

The reason behind this error was, I was trying to use GCC-build OpenCV library with Clang compiler. Plus, the architecture of OpenCV libraries didn't match with the Qt5 ones. I tried to build OpenCV3 using Clang compiler and adding them to Qt5 projects but failed. Finally I came up with a solution which is: installing all - Qt5, OpenCV3 and Qt Creator - from brew and it worked!

Obviously you need to install brew and then run the following commands.

```shell
brew install qt5 science/opencv3
brew install caskroom/cask/brew-cask
brew cask install qt-creator
```

Then link Qt Creator to /Applications by the following command.

```shell
sudo ln -s /opt/homebrew-cask/Caskroom/qt-creator/3.6.0/Qt\ Creator.app/ /Applications/Qt\ Creator.app
```

Now run Qt Creator and configure Kits with GCC-build Qt5 qmake. Then create a new project. Add the following lines to the *.pro file.

```shell
macx {
    INCLUDEPATH += /usr/local/opt/opencv3/include
    LIBS += `pkg-config --libs opencv`
}
```

And here is a sample program to check if OpenCV3 is working.

```cpp
#include "opencv2/opencv.hpp"

int main()
{
    cv::Mat img = cv::imread("/Users/minhaz/lena.jpg");
    cv::imshow("Image", img);
    cv::waitKey(0);

    return 0;
}
```

This trick worked for me. Wish you luck, guys!
