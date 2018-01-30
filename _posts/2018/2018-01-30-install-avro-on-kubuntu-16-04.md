---
layout: post
title: "Install Avro on Kubuntu 16.04"
date: 2017-01-30
categories: linux
---
Installing Avro on Linux has become pretty much easy these days. Thanks to [this](http://linux.omicronlab.com/ubuntu_14.04.html) blog post by Omicron Lab. But there are many users out there who failed successfully to configure Avro with ibus, specially on non-Ubuntu distros. Because Kubuntu (or other non-GNOME distros) does not use ibus as IME. So I found an workaround.

First, download the latest `deb` file for Avro and install it.

```bash
# links
wget https://github.com/maateen/avro/releases/download/v2.1/avro_2.1-3_all.deb
sudo dpkg -i avro_2.1-3_all.deb
sudo apt install -f
```

Your system still needs `ibus` and `gjs` . So do install them.

```bash
sudo apt install ibus gjs
```

Here comes the best part. You need to set `ibus` as default IME at boot time. The following line will do it for you.

```bash
sudo echo IM_CONFIG_DEFAULT_MODE=ibus >> /etc/default/im-config
```

Now run `ibus-setup` and do add `Avro Keyboard` from `Bengali` section as `Normal User` (no root). When you are done, just reboot your computer. After rebooting, Bengali text should appear as it should be.

Let me know if this trick helped you. Or if you have a better one to share!
