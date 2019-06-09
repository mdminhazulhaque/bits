---
layout: post
title: Run Custom Lua Script as CGI with uhttpd
date: 2016-11-26
category: openwrt
---

uhttpd is a lightweight HTTP web server that supports running Lua scripts as CGI. It is possible to create custom REST API or any other callback using Lua functionality of uhttpd. All you need to do is to put a script somewhere in your filesystem that has one `handle_request` function, and tweak some UCI configs. Let me tell you more.

First, let's install Lua support for uhttpd.

```bash
opkg install uhttpd-mod-lua
```

Then let's change UCI entries for uhttpd.

```bash
uci set uhttpd.main.lua_prefix='/lua'
uci set uhttpd.main.lua_handler='/root/index.lua'
uci commit uhttpd
```

As you can see, we have set a new URI endpoint at `/lua` and the path will be routed to the Lua file at `/root/index.lua`. So let's put the following lines inside that file.

```lua
local pr = require "luci.http.protocol"

function handle_request(env)
    uhttpd.send("Status: 200 OK\r\n")
    uhttpd.send("Content-Type: text/html\r\n\r\n")
    
    -- strip "/lua/" from the begining
    local command = pr.urldecode(string.sub(env.REQUEST_URI, 6))
    
    local proc = assert(io.popen(command))
    for line in proc:lines() do
        uhttpd.send(line.."\n")
    end
    proc:close()
end
```

You might already have guessed that this simple Lua script will execute any shell command that comes in the form of URI (encoded) and pass the stdout buffer as HTTP content. Now we have to restart uhttpd to detect the changes.

```bash
/etc/init.d/uhttpd restart
```

Now it's time to do some real check. Let's run the command `uptime`. I did run the following.

```bash
minhaz:~ $ curl -s 'http://192.168.1.1/lua/uptime'
17:35:14 up 28 day,  6:30,  1 users,  load average: 0.97, 0.92, 0.90
```

It works! Just remember that, you have to pass the URI string as urlencoded.

Go play with it a bit more until your router gets bricked. Good luck! :)
