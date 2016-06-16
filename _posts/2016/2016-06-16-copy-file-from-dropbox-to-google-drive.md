---
layout: post
title: Copy File from Dropbox to Google Drive
date: 2016-06-16
categories: python
---

What you'll need

* A __VPS__ or any remote server to run Python, pip and wget
* Patience

First things first. Generate a Drive API oAuth Secret from [Google API Console](https://console.developers.google.com). Save it as `client_secret.json` to your working directory. We'll be needing this later.

## Pull file from Dropbox

You might not know, you can download files from Dropbox using wget/curl by appending `dl=1` at the end of file URI. So download the file you need to send to Google Drive using wget/curl/aria2c or what tool you prefer. Here is a sample execution.

`wget 'https://www.dropbox.com/s/2v2efzgbn8txz6g/Sprint4GDeveloperPack-1.6.1.2.2.tar.gz?dl=1'`

## Push to Google Drive

Now it's time to tune up my Python script to upload the downloaded file to Google Drive. It's a simple API caller script, but I modified some so you don't need to explicitly set file title, mimetype etc. Take a look at it.

```python
from apiclient import errors, discovery
from apiclient.http import MediaFileUpload

import oauth2client
from oauth2client import client
from oauth2client import tools

import os
import httplib2
import sys
import urllib

try:
    import argparse
    flags = argparse.ArgumentParser(
        parents=[tools.argparser]
        ).parse_args()
except ImportError:
    flags = None

SCOPES = 'https://www.googleapis.com/auth/drive'
CLIENT_SECRET_FILE = 'client_secret.json'
APPLICATION_NAME = 'Drive File Uploader'

def get_credentials():
    home_dir = os.path.expanduser('~')
    credential_dir = os.path.join(home_dir, '.credentials')
    if not os.path.exists(credential_dir):
        os.makedirs(credential_dir)
    credential_path = os.path.join(credential_dir,
                                   'credentials.json')

    store = oauth2client.file.Storage(credential_path)
    credentials = store.get()
    if not credentials or credentials.invalid:
        flow = client.flow_from_clientsecrets(
            CLIENT_SECRET_FILE, SCOPES)
        flow.user_agent = APPLICATION_NAME
        if flags:
            credentials = tools.run_flow(flow, store, flags)
        else: # Needed only for compatibility with Python 2.6
            credentials = tools.run(flow, store)
        print('Storing credentials to ' + credential_path)
    return credentials

def get_mimetype(filename):
    import mimetypes
    
    mimetypes.init()
    filemimetype, encoding = mimetypes.guess_type(filename)
    return filemimetype

def insert_file(service, filename, parent_id=None):
    filemimetype = get_mimetype(filename)
    
    media_body = MediaFileUpload(filename, mimetype=filemimetype, resumable=True)
    body = {'title': filename, 'mimeType': filemimetype}
    # Set the parent folder if provided
    if parent_id:
        body['parents'] = [{'id': parent_id}]

    try:
        print('Uploading ' + filename)
        file = service.files().insert(
                body=body,
                media_body=media_body).execute()
        return file['id']
    except errors.HttpError as error:
        print('An error occured: %s' % error)
        return None

def main():
    credentials = get_credentials()
    http = credentials.authorize(httplib2.Http())
    service = discovery.build('drive', 'v2', http=http)
    
    # FIXME change here
    filename = 'HelloWorld.zip'
    
    if not os.path.isfile(filename):
        print('`filename` not set or `filename` doesn\'t exists')
        exit(1)
    
    fileid = insert_file(service, filename)
    
    if fileid:
        print('Upload success, fileid = ' + fileid)

if __name__ == '__main__':
    main()
```

Now do the followings.

1. Change `filename` variable to the path of the file you downloaded earlier
2. Run `python3 gdrive_upload_file.py --noauth_local_webserver` because the VPS might not have Xserver installed and start a browser.
3. Allow Google Drive Access to your Uploader script, enter the verification code and wait for the file being uploaded!
4. Profit!

Quite easy, right?
