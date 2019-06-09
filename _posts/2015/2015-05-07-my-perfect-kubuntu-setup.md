---
layout: post
title: "My Perfect Kubuntu Setup"
date: 2015-05-07 09:31:00
category: linux
---
[Last Updated: Thursday, May 07, 2015] It has been 3 years since I started using Kubuntu as my primary OS. Here is a list of PPAs and packages I
installed. I also added some tweaks.

```bash
# Code::Blocks
add-apt-repository ppa:damien-moore/codeblocks

# fish shell v2
add-apt-repository ppa:fish-shell/release-2

# Inkscape 0.93
add-apt-repository ppa:inkscape.dev/stable

# Kubuntu 4.14
add-apt-repository ppa:kubuntu-ppa/backports

# LibreOffice
add-apt-repository ppa:libreoffice/ppa

# Screen Recorder
add-apt-repository ppa:maarten-baert/simplescreenrecorder

# ffmpeg
add-apt-repository ppa:mc3man/trusty-media

# Clementine Music Player
add-apt-repository ppa:me-davidsansome/clementine

# Awesome Moka Icon Theme
add-apt-repository ppa:moka/daily

# youtube-dl and other tools
add-apt-repository ppa:nilarimogard/webupd8

# Qt5 and Ubuntu Dev Tools
add-apt-repository ppa:ubuntu-sdk-team/ppa

# adb, fastboot etc
add-apt-repository ppa:ubuntu/android-tools

# VLC Media Player
add-apt-repository ppa:videolan/stable-daily

# Brackets Editor
add-apt-repository ppa:webupd8team/brackets

# Oracle 8 JDK
add-apt-repository ppa:webupd8team/java

# Mono Develop and Mono Library
echo "deb http://download.mono-project.com/repo/debian wheezy main" | tee /etc/apt/sources.list.d/mono-xamarin.list

# Use apt-get install pkg-name
android-tools-adb # adb
android-tools-fastboot # fastboot
arduino # Official Arduino IDE
brackets # Brackets Editor
clementine # Clementine Music Player
cmake-qt-gui # CMake GUI
codeblocks # Code::Blocks IDE
ffmpeg # ffmpeg and ffplay CLI
fish # Fish Shell v2
fslint # Duplicate File Finder and Remover
geany # Lightweight IDE
gimp # Image Editor
git # Git Version Control
gnome-disk-utility # Disk Utility
gparted # Partition Manager
inkscape # SVG Editor
kcharselect # Character Pickup Tool
kcolorchooser # Color Picker
keepassx # Password Store App
krename # Batch Rename Tool
libqt[5] # All Qt5 Libraries
libreoffice # Office Suite
libsane-extras # Driver for Cannon Lide 110
light-themes # Ambiance and Radiance themes fro GTK Apps
moka-icon-theme # Cool Icon Theme for Ubuntu
mono-complete # Mono Libraries
monodevelop # Official Mono IDE
muon # Package Manager, Alternative to Synaptic
mysql-client # MySQL CLI
mysql-server # MySQL Sercer
nginx-light # Nginx Web Server
oracle-java8-installer # Oracle Java 8
php5-cli # PHP CLI Tool
php5-fpm # PHP FPM for Nginx
pinta # Paint Alternative
proftpd-basic # FTP Server
qt5-qmake # QMake Tool
qtcreator # Qt IDE
shutter # Screenshot and Editor
simplescreenrecorder # Great Screen Recorder
sqlitebrowser # SQLite Database Browser
unetbootin # Live USB Creator
unrar # RAR File Extractor
vlc # Media Player from VideoLAN
xclip # Commandline Clipboard Manager
youtube-dl   # All in One Video Downloader

# Use apt-get purge pkg-name
akregator # I prefer online Feed Reader
amarok # Clementine
command-not-found # I hate this app for no reason
dragonplayer # VLC
firefox # Google Chrome
java-common # Oracle JDK
k3b # I have no DVD drive
kaddressbook # Never used it
kde-telepathy # Never used any desktop IM
kmag # Unnecessary
kmail # Gmail Webinterface
kmousetool # Never used it
kontact # What?
korganizer # Meh!
krdc # VNC!
kwalletmanager # KeePassX
language-pack-en # Unnecessary
language-selector-common # Unnecessary 2
muon-discover # Unnecessary 3
muon-notifier # Unnecessary
muon-updater # I like to manually update packages
partitionmanager # GParted
quassel # wut?
sieveeditor # Nah
usb-creator-kde # unetbootin

# http://www.skype.com/en/download-skype/skype-for-linux/
dpkg -i skype_4.3.0.deb

# https://www.teamviewer.com/en/download/linux.aspx
dpkg -i teamviewer_10.0.deb

# http://www.google.com.bd/chrome/browser/thankyou.html?platform=linux
dpkg -i google-chrome-stable_current_amd64.deb

# Edit /etc/fstab
# Details at http://blog.minhazulhaque.com/2015/01/fstab-optimization-for-ssd-and-ram.html
echo "tmpfs /tmp        tmpfs defaults,noatime,mode=1777 0 0" >> /etc/fstab
echo "tmpfs /var/spool  tmpfs defaults,noatime,mode=1777 0 0" >> /etc/fstab
echo "tmpfs /var/tmp    tmpfs defaults,noatime,mode=1777 0 0" >> /etc/fstab
echo "tmpfs /var/log    tmpfs defaults,noatime,mode=0755 0 0" >> /etc/fstab

# Kernel Options
# Disable SWAP
echo "vm.swappiness=0" >> /etc/sysctl.conf
echo "vm.vfs_cache_pressure=100" >> /etc/sysctl.conf

# Disable IPv6
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf

# Remove annoying Java Desktop Shortcuts
rm /usr/share/applications/JB-*
rm /usr/share/applications/display.im6.desktop

# Finally, remove bd_BN locale
sed -i s/bn_BD/en_US/g /etc/default/locale

# Don't forget to reboot your pc
reboot
```