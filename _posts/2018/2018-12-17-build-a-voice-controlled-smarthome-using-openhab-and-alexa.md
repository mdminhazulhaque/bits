---
layout: post
title: Build a Voice Controlled SmartHome using openHAB and Alexa
date: 2018-12-17
tag: linux
---

The Amazon Alexa Marketplace has lots of third party SmartHome skills to start with. But why not  build your own SmartHome, right?

First thing is, you have to create some openHAB items with proper tagname, label and type. Here I have added 4 devices in `[Lighting]` tag as `Switch` item. This tagname is very important because Amazon Alexa API uses this tagname to export device list into Alexa's SmartHome Discovery menu. I have used `exec1` binding as output trigger of the items. The binding configuration is given as `/home/ubuntu/mysmarthome.py %3$s %2$s` which means it will call `/home/ubuntu/mysmarthome.py` with `%3$s = Item's Programetic Name` (not Label) and `%2$s = Item's State`. Here is the complete item file.

```
Switch Bedroom_Fan "Bedroom Fan" [Lighting] {exec=">[*:/home/ubuntu/mysmarthome.py %3$s %2$s]"}
Switch Bedroom_Light "Bedroom Light" [Lighting] {exec=">[*:/home/ubuntu/mysmarthome.py %3$s %2$s]"}
Switch Livingroom_Fan "Livingroom Fan" [Lighting] {exec=">[*:/home/ubuntu/mysmarthome.py %3$s %2$s]"}
Switch Livingroom_Light "Livingroom Light" [Lighting] {exec=">[*:/home/ubuntu/mysmarthome.py %3$s %2$s]"}
```

After you are done with item file, install `openhabcloud` binding, and then configure cloud service at `http://myopenhab.org` using your openHAB's UUID and secret. Once you are connected to `myopenhab` you can see the previously added 4 items there. Now it's time to configure Alexa SmartHome Service.

Assuming that your Alexa is ready to use, browse Skill Marketplace and search for `openHAB`. Click `Enable Skill` there.

![openHAB Skill](https://i.imgur.com/7xkeVyt.png)

After enabling the skill, it will redirect you to `myopenhab.org` and prompt OAuth login. Select the `Allow` button.

![openHAB OAuth Page](https://i.imgur.com/HrMqflA.png)

If the credentials are correct, the Skill will be enabled and you will be prompted to `Discover Devices` page. Proceed by clicking the button.

![openHAB Skill Discovery](https://i.imgur.com/UYGEX0v.png)

If the item file is properly configured, all devices with `Lighting` tag will appear in the `Devices` menu. From now on, you can send commands to the items using Alexa's Voice API. For example, saying `alexa, set bedroom light on` will trigger openHAB's REST API and eventually execute `/home/ubuntu/mysmarthome.py Bedroom_Light ON` at your local setup.

![openHAB Devices](https://i.imgur.com/eMWcmto.png)

Here is a simple log of openHAB runtime.

```
16:42:14.078 [INFO ] [.io.openhabcloud.internal.CloudClient] - Connected to the openHAB Cloud service (UUID = ee0b4a46-82ce-4826-b6b6-e77461785df5, base URL = http://localhost:8080)
16:42:18.260 [INFO ] [del.core.internal.ModelRepositoryImpl] - Loading model 'smarthome.items'
16:42:19.906 [INFO ] [rthome.model.lsp.internal.ModelServer] - Started Language Server Protocol (LSP) service on port 5007
16:42:20.925 [INFO ] [i.dashboard.internal.DashboardService] - Started Dashboard at http://1.2.3.4:8080
16:42:20.933 [INFO ] [i.dashboard.internal.DashboardService] - Started Dashboard at https://1.2.3.4:8443
16:43:38.335 [INFO ] [ab.core.service.AbstractActiveService] - Exec Refresh Service has been started
16:47:57.690 [INFO ] [smarthome.event.ItemCommandEvent     ] - Item 'Bedroom_Light' received command ON
16:47:57.725 [INFO ] [hab.binding.exec.internal.ExecBinding] - executed commandLine '/home/ubuntu/mysmarthome.py Bedroom_Light ON'
16:48:09.639 [INFO ] [smarthome.event.ItemCommandEvent     ] - Item 'Livingroom_Light' received command ON
16:48:09.653 [INFO ] [hab.binding.exec.internal.ExecBinding] - executed commandLine '/home/ubuntu/mysmarthome.py Livingroom_Light ON'
16:48:34.923 [INFO ] [smarthome.event.ItemCommandEvent     ] - Item 'Bedroom_Fan' received command ON
16:48:34.933 [INFO ] [hab.binding.exec.internal.ExecBinding] - executed commandLine '/home/ubuntu/mysmarthome.py Bedroom_Fan ON'
```
