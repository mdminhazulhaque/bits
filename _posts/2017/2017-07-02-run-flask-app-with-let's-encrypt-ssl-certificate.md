---
layout: post
title: Run Flask App with Let's Encrypt SSL Certificate
date: 2017-07-02
categories: python
---

Flask supports serving in HTTPS mode when provided with valid certificate and key file. I have been using Let's Encrypt which automatically manages all the SSL keyfiles and certificates used on my server. I had troubles setting up preconfigured SSL keys and certificates with my Flask app. Although I had it figured out later.

What you need to do is provide an `ssl_context` option with the Flask app which requires 2 things. One is the issued SSL certificate and the other is the key file. Let's Encrypt puts them all in `/etc/letsencrypt/live/yourdomain.com`. So you need to find the correct one and set it up with Flask. Here is my setup.

```python
import requests
from flask import Flask, request

app = Flask(__name__)

@app.route('/', methods=['GET'])
def serve():
    return "Hello world", 200

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=8080, ssl_context=('/etc/letsencrypt/live/mdminhazulhaque.io/fullchain.pem', '/etc/letsencrypt/live/mdminhazulhaque.io/privkey.pem'))
```

As you can see, `fullchain.pem` is the certificate and `privkey.pem` is the keyfile. So I ran the above example and checked if the SSL is working with `openssl` tool.

```bash
openssl s_client -quiet -connect mdminhazulhaque.io:8080
```

```
depth=2 O = Digital Signature Trust Co., CN = DST Root CA X3
verify return:1
depth=1 C = US, O = Let's Encrypt, CN = Let's Encrypt Authority X3
verify return:1
depth=0 CN = mdminhazulhaque.io
verify return:1
read:errno=0
```

I got `errno=0` which means Flask is working fine with SSL. :D
