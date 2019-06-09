---
layout: post
title: Probhat Layout for OS X
tag: osx
---
The Probhat layout is redesigned by [Ankur](http://www.ankurbangla.org). Most of the Linux distro are including this layout with their latest releases. And it has been real easy using Probhat on Windows using Avro.

Since OS X supports custom keylaout files, I created this layout based on the original Probhat layout.

There may have been similar Probhat keylaouts around there, but this one supports OS X actions using the following hotkeys.

|CMD|ALT|CTRL|
|:---:|:---:|:---:|
|⌘|⌥|⌃|

Which means, even when `Probhat` layout is activated, you can hit `⌘+A` to select all, `⌘+C` to copy, `⌃+D` to send EOF or other `⌘+⌥` combinations.

## Install

Run the following command in Terminal.

```bash
curl https://raw.githubusercontent.com/mdminhazulhaque/probhat-osx/master/install.sh | sudo bash
```

Then enter your password so the installer script can copy the necessary files to `/Library/Keyboard\ Layouts` directory.

## Configure

1. Reboot, or log out and log in again after installing.
2. Open `System Preferences`. Then go to `Language & Region` > `Keyboard Preferences` > `Input Sources`.
3. Click the `+` sign, then select `Others` > `Probhat` with Bangladeshi flag.
4. Get back to `Keyboard Preferences` > `Shortcuts` > `Input Sources` and turn on `Select the previous input source` with shortcut key `⌘+Space`.
5. Now you will see `Probhat` on input method list on menu bar.

    ![Probhat Input](https://github.com/mdminhazulhaque/probhat-osx/raw/master/img_inputmenu.png)
    
6. Hit any text editor, browser, Facebook or whatever, press `⌘+Space` and start typing Bangla in Probhat!

    ![Bangla in Text Editor](https://github.com/mdminhazulhaque/probhat-osx/raw/master/img_texteditor.png)

## Contribute

<div class="message">
Send bugfixes or commits to <a href="https://github.com/mdminhazulhaque/probhat-osx">minhazul-haque/probhat-osx</a>
</div>

## License

This keyboard layout is available under the [MIT](http://mths.be/mit) license.
