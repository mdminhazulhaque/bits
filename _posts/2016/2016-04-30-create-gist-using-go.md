---
layout: post
title: Create (Secret) Gist using Go
date: 2016-04-30
categories: golang
---

[Github Gist API](https://developer.github.com/v3/gists/) provides easy functionalities to create (and manage) Gists using simple API call. A simpliest workaround would be using cURL's POST request with JSON parameters.

First, an OAuth token has to be generated. Go to [https://github.com/settings/tokens/new](https://github.com/settings/tokens/new) and create a new token with `gist` option checked. Save it for future use. Say the token is `afa495114ac154195bd71895b5850bc231e1a9bd`. Then the cURL command would be -

```bash
curl -H "Content-Type: application/json" -X POST --data @'request.json' -H "Authorization: token afa495114ac154195bd71895b5850bc231e1a9bd" https://api.github.com/gists -I
```

The content of `request.json` is -

```json
{
  "description": "A (secret) gist",
  "public": false,
  "files": {
    "file1.txt": {
      "content": "String file contents"
    }
  }
}
```

If the Gist has to be a secret one, set `public` to `true`.

On successful Gist creation, the header will contain the status code `201 Created` and the URI of the Gist as `Location` header. The same thing can be achieved using Golang. Thanks to their nice HTTP POST library and easy to embed JSON buffer. Here is the code I wrote.

```go
package main

import (
    "bytes"
    "fmt"
    "net/http"
)

func main() {
    url := "https://api.github.com/gists"

    var jsonStr = []byte(`{
                "description": "A (secret) gist",
                "public": false,
                "files": {
                        "file1.txt": {
                            "content": "String file contents"
                        }
                    }
                }`)
    
    req, err := http.NewRequest("POST", url, bytes.NewBuffer(jsonStr))
    req.Header.Set("Authorization", "token cqlvwpl40z4ukj5fa495114a71895b5850bc29bd") // The token
    req.Header.Set("Content-Type", "application/json")

    client := &http.Client{}
    resp, err := client.Do(req)
    if err != nil {
        panic(err)
    }
    defer resp.Body.Close()

    if resp.Status == "201 Created" {
        fmt.Println("Success")
        fmt.Println("Go to the following address to access the secret gist")
        fmt.Println(resp.Header.Get("Location"))
    } else {
        fmt.Println("Failed creating secret gist")
    }
}
```

Hope that helps. Do you have a better workaround? Let me know in the comment box. :)
