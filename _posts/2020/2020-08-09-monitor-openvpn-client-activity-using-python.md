---
layout: post
title: Monitor OpenVPN Client Activity using Python
date: 2020-08-09
category: linux
---
Installing OpenVPN in your own server gives you two major benefits. First, you will have better privacy control. Second, no need to spend on `pay-per-user` thing. As long as the CPU can handle encryption/decryption, and the ethernet controller can handle the traffic, OpenVPN is a pretty good choice for providing VPN service to a small-sized team.

## OpenVPN Config

Anyway, a typical OpenVPN Server configuration looks like the following.

```bash
dev tun-udp-1194
server 10.10.10.0 255.255.255.0
proto udp
port 1194

ca /etc/openvpn/pki/ca.crt
cert /etc/openvpn/pki/issued/server@mdminhazulhaque.io.crt
key /etc/openvpn/pki/private/server@mdminhazulhaque.io.key
dh /etc/openvpn/pki/dh.pem
crl-verify /etc/openvpn/pki/crl.pem

remote-cert-tls client
keepalive 10 120
tls-auth /etc/openvpn/pki/ta.key 0
cipher AES-256-CBC
tls-cipher TLS-DHE-DSS-WITH-AES-256-CBC-SHA256
auth SHA256
tls-version-min 1.2
comp-lzo
persist-key
persist-tun
verb 0
```

## OpenVPN Management over Telnet

In order to access the telnet management console, the following line has to be added in `/etc/openvpn/server.conf`. Also the `openvpn.service` must be reloaded for the change to take effect.

```
management 127.0.0.1 7000
```

Alright. Next thing is, try connecting to port `7000` via `telnet` command. If it was a success, then we can use a small Python3 script to talk with the OpenVPN server.

## A Bit of Knowledge about Common Name

Before we run any script, we need to find out the `CN` or Common Name used in the RSA Root Certificate. For example, if you generate the `CA` file with `CN=mdminhazulhaque.io`, both EasyRSA and OpenVPN will append this `CN` after the client's name. A sample server and client names could be as follows.

```
Server: server@mdminhazulhaque.io
Client Mark: mark@mdminhazulhaque.io
Client Bob: bob@mdminhazulhaque.io
Client Alice: alice@mdminhazulhaque.io
```

Which means, the client names must be unique because OpenVPN uses the client name to map DHCP IP Addresses for remote users.


## Run the Script!

Well, now we know the common name. It could be `mdminhazulhaque.io`, or `example.com` or `server` or anything. We need to amend the `RE_COMMON_NAME` regex and put the correct value there. Once done, upload the script to the OpenVPN server and run it using `python3`.

```python
#!/usr/bin/env python3

import re
import telnetlib
import time

# TODO change here
RE_COMMON_NAME = "^*@mdminhazulhaque.io.*$"

HOST = "127.0.0.1"
PORT = "7000"
INTERVAL = 5
PRE_USERS = {}

def alert(user, ip, state):
    print(F"*{user}* {state} from {ip}")
    # TODO You can call Slack or API Gateway here
    
while True:
    telnet = telnetlib.Telnet(HOST,PORT, 5)
    telnet.write("status\n")
    output = telnet.read_until("END\n", 1)
    telnet.close()
    
    CURR_USERS = {}
    
    for line in output.split("\n"):
        if re.search(RE_COMMON_NAME, line):
            user, realaddress, _, _, _ = line.split(",")
            ip = realaddress.split(":")[0]
            CURR_USERS[user] = ip
    
    connected = set(CURR_USERS.keys()) - set(PRE_USERS.keys())
    disconnected = set(PRE_USERS.keys()) - set(CURR_USERS.keys())
    
    for user in list(connected):
        alert(user, CURR_USERS[user], "connected")
    for user in list(disconnected):
        alert(user, PRE_USERS[user], "disconnected")
    
    PRE_USERS = CURR_USERS    
    
    time.sleep(INTERVAL)
```

## The Result

If you keep running the script in background (`screen` or `systemd` whichever you prefer), you will see activity alerts like the following.

```
mark@mdminhazulhaque.io connected from 190.106.117.114
bob@mdminhazulhaque.io connected from 186.110.104.190
alice@mdminhazulhaque.io connected from 144.143.163.176
...
alice@mdminhazulhaque.io disconnected from 144.143.163.176
mark@mdminhazulhaque.io disconnected from 190.106.117.114
bob@mdminhazulhaque.io disconnected from 186.110.104.190
```

## More Tweaks

You can simply override the `alert` function and call custom Slack or API Gateway URL using `requests`. Tada!
