---
layout: post
title: Dell Latitude 5300 Fingerprint Sensor on Ubuntu
date: 2022-05-13
category: linux
---

After struggling for several months, I have finally been able to make the fingerprint sensor on my **Dell Latitude 5300** laptop work on Ubuntu. The steps were pretty simple. I have no idea why never tried these steps.

Let's jump to the real stuff. First, you need to add official Dell apt repositories to your system.

```bash
# add these lines to /etc/apt/sources.list.d/dell.list 
deb http://dell.archive.canonical.com/updates/ focal-dell public
deb http://dell.archive.canonical.com/updates/ focal-oem public
deb http://dell.archive.canonical.com/updates/ focal-somerville public
deb http://dell.archive.canonical.com/updates/ focal-somerville-melisa public
```

Then update the system keyring with Dell repository GPG keys so that apt does not complain about package signing.

```bash
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F9FDA6BED73CDC22
```

Now update package meta-data and install fingerprint drivers. `lsusb` revealed that mine was `0a5c:5843 Broadcom Corp. 58200` yet I installed the `goodix` driver just to be sane.

```bash
sudo apt update
sudo apt install -y fprintd libfprint-2-tod1-broadcom libfprint-2-tod1-goodix libfprint-2-tod1
```

Once done, you need to check if the device is detected by `fprintd` . Run `fprintd-list` with your username and something similar to the following should appear.

```bash
sudo fprintd-list minhaz
...
found 1 devices
Device at /net/reactivated/Fprint/Device/0
Using device /net/reactivated/Fprint/Device/0
```

If not, check again if the driver is installed properly. If any device is detected, it's time to provide some sample fingerprints to the system.

```bash
sudo fprintd-enroll minhaz
```

You have to press the sensor **several** times. Once done, it will confirm that your username is enrolled with the fingerprint.

Finally, you have to allow PAM to use fingerprint sensor as authentication mechanism. Run the following command and enable `Fingerprint authentication` and you should be good to go.

```bash
sudo pam-auth-update
```

 From now on, simply put your finger on the sensor after executing `sudo -i`. This should work for login and lock screens too.

Let me know how it works for you.
