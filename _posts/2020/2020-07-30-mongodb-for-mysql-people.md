---
layout: post
title: MongoDB for MySQL People
date: 2020-07-30
categories: mongodb
---

I am a MySQL guy. I can query MySQL, BigQuery or SQL-like databases for my day to day business. Last week, I faced a challange where I needed to extract some information from a production MongoDB server that involves aggregation. I had no idea how MongoDB works or how to run CRUD operation on such database. So obviously, I spent my whole weekend in learning MongoDB. In this post I am going to share the MongoDB queries I learnt, and the equivalent MySQL queries as well.

> I used MongoDB v3.6, for both daemon and cli, so some functions may not work with your current setup

## Populate Data and Load into MongoDB

I used the following piece of code to scrapt my Github profile information into a single JSON file.

```python
import requests
import json

username = 'mdminhazulhaque'
repos = []
page = 1

while True:
    params = (
        ('page', page),
        ('type', 'owner'),
        ('per_page', 100)
    )
    response = requests.get('https://api.github.com/users/{username}/repos'\
        .format(username=username), params=params)
    for single in response.json():
        repos.append({
            "name": single.get('name', None),
            "description": single.get('description', None),
            "created_at": single.get('created_at', None),
            "language": single.get('language', None),
            "stargazers_count": single.get('stargazers_count', None)
        })
    if len(response.json()) < 100:
        break
    else:
        page += 1
with open("github.json", "w") as fp:
    json.dump(repos, fp, indent=4)
```

Then I loaded the JSON data into MongoDB using `mongoimport`.

```bash
mongoimport --db local --collection repos --drop --jsonArray --file github.json 
```

One record from the `repo` collection looks like the following.

```bash
$ mongo 127.0.0.1/local
> db.repos.findOne()
{
        "_id" : ObjectId("5f1cfca24662cbc419b65e29"),
        "name" : "a-pdf-reader",
        "description" : "A poppler based pdf reader written in Qt4",
        "created_at" : "2012-10-07T20:44:48Z",
        "language" : "C++",
        "stargazers_count": null
}
```

Let's start playing with MongoDB.

## SELECT

### select * from repos

```bash
> db.repos.find({})

{ "_id" : ObjectId("5f1cfca24662cbc419b65e2a"), "name" : "apt-sync", "created_at" : "2017-11-19T04:57:23Z", "language" : "Python", "stargazers_count" : 0 }
{ "_id" : ObjectId("5f1cfca24662cbc419b65e2b"), "name" : "aws-cli-cheatsheet", "created_at" : "2020-02-27T16:38:21Z", "language" : null, "stargazers_count" : 52 }
{ "_id" : ObjectId("5f1cfca24662cbc419b65e2c"), "name" : "banglalion-wimax-mac", "created_at" : "2015-02-25T19:15:48Z", "language" : "HTML", "stargazers_count" : 0 }
{ "_id" : ObjectId("5f1cfca24662cbc419b65e2d"), "name" : "annoying-bn-text", "created_at" : "2019-06-05T17:25:05Z", "language" : "HTML", "stargazers_count" : 1 }
{ "_id" : ObjectId("5f1cfca24662cbc419b65e2e"), "name" : "banglalionwimaxapi", "created_at" : "2018-10-16T13:03:53Z", "language" : "Python", "stargazers_count" : 0 }
{ "_id" : ObjectId("5f1cfca24662cbc419b65e2f"), "name" : "bcm-wimax-dkms", "created_at" : "2017-05-20T18:22:07Z", "language" : "C", "stargazers_count" : 0 }
{ "_id" : ObjectId("5f1cfca24662cbc419b65e30"), "name" : "bd-mrp-api", "created_at" : "2018-12-31T20:26:48Z", "language" : "Python", "stargazers_count" : 1 }
```

### select name, description from repos

```bash
> db.repos.find({}, {_id:0, name:1, description:1})

{ "name" : "a-pdf-reader", "description" : "A poppler based pdf reader written in Qt4" }
{ "name" : "apt-sync", "description" : ":gift: Sync APT installed package list across different machines" }
{ "name" : "aws-cli-cheatsheet", "description" : ":cloud: AWS CLI + JQ = Make life easier" }
{ "name" : "banglalion-wimax-mac", "description" : ":satellite: Banglalion WiMAX on Mac OS X" }
{ "name" : "annoying-bn-text", "description" : "Piss of your friends with awkwardly written Bengali text" }
```

### select name, description from repos limit 2

```bash
> db.repos.aggregate([{$project:{_id:0, name:1, description:1}}, {$limit:5}])

{ "name" : "a-pdf-reader", "description" : "A poppler based pdf reader written in Qt4" }
{ "name" : "apt-sync", "description" : ":gift: Sync APT installed package list across different machines" }
```

### select name, description from repos order by name

```bash
> db.repos.find({}, {_id:0, name:1, description:1}).sort({name:1})

{ "name" : "Android-Javascript-Bridge", "description" : "Android and Javascript two way communication" }
{ "name" : "Android-JavascriptInterface-Sample", "description" : "Call Java (Android) methods from Webview using Javascript" }
{ "name" : "Bilai-PnP-Gui", "description" : ":cat2: GUI for Bilai PnP Modems" }
{ "name" : "CPPad", "description" : "Write and run C++ codes, instantly!" }
{ "name" : "CSE10Routine", "description" : "Tabbed routine app" }
```

### select name, stargazers_count from repos order by stargazers_count desc

```bash
> db.repos.find({}, {_id:0, name:1, stargazers_count:1}).sort({stargazers_count:-1})

{ "name" : "aws-cli-cheatsheet", "stargazers_count" : 52 }
{ "name" : "probhat-osx", "stargazers_count" : 23 }
{ "name" : "PyQt-BPNN", "stargazers_count" : 22 }
{ "name" : "foreach", "stargazers_count" : 14 }
{ "name" : "html-table-to-json", "stargazers_count" : 12 }
```

### select name, stargazers_count from repos where stargazers_count > 20 order by stargazers_count

```bash
> db.repos.find({ stargazers_count: { $gt: 20} }, {_id:0, name:1, stargazers_count:1}).sort({stargazers_count:-1})

{ "name" : "aws-cli-cheatsheet", "stargazers_count" : 52 }
{ "name" : "probhat-osx", "stargazers_count" : 23 }
{ "name" : "PyQt-BPNN", "stargazers_count" : 22 }
```

### select name, stargazers_count from repos where language = "Python"

```bash
> db.repos.find({ language: "Python" }, {_id:0, name:1, stargazers_count:1})

{ "name" : "apt-sync", "stargazers_count" : 0 }
{ "name" : "banglalionwimaxapi", "stargazers_count" : 0 }
{ "name" : "bd-mrp-api", "stargazers_count" : 1 }
{ "name" : "flightaware-cli", "stargazers_count" : 0 }
{ "name" : "html-table-to-json", "stargazers_count" : 12 }
```

#### select name, description from repos where description like "%cli%"

```bash
> db.repos.find({ description: /cli/i }, {_id:0, name:1, description:1})

{ "name" : "aws-cli-cheatsheet", "description" : ":cloud: AWS CLI + JQ = Make life easier" }
{ "name" : "ClipMonitor", "description" : "A tiny clip monitor app built with Qt5" }
{ "name" : "foreach", "description" : ":repeat: Read lines from file/stdin and execute them as CLI argument" }
{ "name" : "kakitangan-cli", "description" : ":briefcase: CLI for Kakitangan app, the online HR Software for Malaysian businesses" }
{ "name" : "librs232", "description" : ":paperclip: RS232 Library in C" }
```

### select language, count(*) as count, description from repos group by language order by count

```bash
> db.repos.aggregate([{ $group: { _id: "$language", count: { $sum: 1 } } },{ $sort: { count: -1 } }])

{ "_id" : "C++", "count" : 61 }
{ "_id" : "Python", "count" : 25 }
{ "_id" : "HTML", "count" : 12 }
{ "_id" : "Java", "count" : 12 }
{ "_id" : "Shell", "count" : 10 }
```

### select language, sum(stargazers_count) as stars, description from repos group by language order by stars

```bash
> db.repos.aggregate([{ $group: { _id: "$language", stars: { $sum: "$stargazers_count" } } },{ $sort: { stars: -1 } }])

{ "_id" : "C++", "stars" : 72 }
{ "_id" : null, "stars" : 52 }
{ "_id" : "Python", "stars" : 47 }
{ "_id" : "Shell", "stars" : 43 }
{ "_id" : "HTML", "stars" : 19 }
```

### select name, substr(created_at, 0, 4) as created_at_year from repos order by created_at_year desc

```bash
> db.repos.aggregate([{$addFields:{"created_at_year":{$substr:["$created_at", 0, 4]}}}, {$project: {_id:0, name:1, created_at_year:1}}, {$sort: {created_at_year:-1}}])

{ "name" : "aws-cli-cheatsheet", "created_at_year" : "2020" }
{ "name" : "gitfolio", "created_at_year" : "2020" }
{ "name" : "messenger-bot", "created_at_year" : "2020" }
{ "name" : "urctl", "created_at_year" : "2020" }
{ "name" : "annoying-bn-text", "created_at_year" : "2019" }
{ "name" : "esp32-mqtt-ir-remote", "created_at_year" : "2019" }
```

### select substr(created_at, 0, 4)) as year, count(*) as count from repos group by year order by count desc

```bash
> db.repos.aggregate([{$addFields:{"created_at_year":{$substr:["$created_at", 0, 4]}}}, { $group: { _id: "$created_at_year", count: { $sum: 1 } } },{ $sort: { count: -1 } }])

{ "_id" : "2015", "count" : 41 }
{ "_id" : "2016", "count" : 35 }
{ "_id" : "2012", "count" : 18 }
{ "_id" : "2014", "count" : 14 }
{ "_id" : "2013", "count" : 12 }
{ "_id" : "2019", "count" : 10 }
```

### select name, unix_timestamp(str_to_date(created_at, '%Y-%M-%dT%h:%m:%sz')) from repos

```bash
> db.repos.aggregate([{$addFields: {date: { $dateFromString: { dateString: "$created_at" }}}}, {$project: {_id:0, created_at_usec: { $subtract: [ "$date", new Date("1970-01-01") ] }, name:1}}])

{ "name" : "a-pdf-reader", "created_at_usec" : NumberLong("1349642688000") }
{ "name" : "apt-sync", "created_at_usec" : NumberLong("1511067443000") }
{ "name" : "aws-cli-cheatsheet", "created_at_usec" : NumberLong("1582821501000") }
{ "name" : "banglalion-wimax-mac", "created_at_usec" : NumberLong("1424891748000") }
{ "name" : "annoying-bn-text", "created_at_usec" : NumberLong("1559755505000") }
```

## DELETE

### delete from repose where language = "C++"

```bash
> db.repos.remove({language:"C++"})
```

## ALTER

### alter table repos drop column created_at

```bash
> db.repos.update({},{$unset:{created_at:""}})
```

### alter table repos insert column foo int

```bash
> db.repos.update({}, {$set: {foo:0}}, {multi:1})
```

That's all for today. Feel free to share if any of the queries can be improved. Thanks for reading.
