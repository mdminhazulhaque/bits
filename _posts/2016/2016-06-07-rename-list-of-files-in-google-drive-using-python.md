---
layout: post
title: Rename List of Files in Google Drive using Python
date: 2016-06-07
categories: python
---

Here is a code snippet I wrote months ago to rename a thousand files using Google Drive Python API. Please note that you need to set the scope to `https://www.googleapis.com/auth/drive` so the API call can commit changes to your drive. You need to authorize the app first. Run the script, it will open a browser session, allow access to Drive. Then you will be able to download `credentials.json` from Google Drive Developer Console website.

```
from __future__ import print_function
import httplib2
import os
import json

from apiclient import discovery
import oauth2client
from oauth2client import client
from oauth2client import tools

try:
    import argparse
    flags = argparse.ArgumentParser(parents=[tools.argparser]).parse_args()
except ImportError:
    flags = None

SCOPES = 'https://www.googleapis.com/auth/drive'
CLIENT_SECRET_FILE = 'client_secret.json'
APPLICATION_NAME = 'Drive API Python Quickstart'

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
        flow = client.flow_from_clientsecrets(CLIENT_SECRET_FILE, SCOPES)
        flow.user_agent = APPLICATION_NAME
        if flags:
            credentials = tools.run_flow(flow, store, flags)
        else: # Needed only for compatibility with Python 2.6
            credentials = tools.run(flow, store)
        print('Storing credentials to ' + credential_path)
    return credentials
    
def rename_file(service, file_id, new_title):
    try:
        file = {'title': new_title}
        updated_file = service.files().patch(
                fileId=file_id,
                body=file,
                fields='title').execute()
        return updated_file
    except:
        print('An error occurred')
        return None

def list_files_in_folder(service, folder_id):
    files = []
    page_token = None
    
    while True:
        try:
            param = {}
            if page_token:
                param['pageToken'] = page_token
            children = service.children().list(folderId=folder_id, **param).execute()
            for child in children.get('items', []):
                files.append(child['id'])
            page_token = children.get('nextPageToken')
            if not page_token:
                break
        except:
            print('An error occurred')
            break
    return files
    
def main():
    credentials = get_credentials()
    http = credentials.authorize(httplib2.Http())
    service = discovery.build('drive', 'v2', http=http)
    
    for fileid in list_files_in_folder(service, '0BwaM3xCs0Uh4NXd4OU9kb3pjRlk'):
        try:
            file = service.files().get(fileId=fileid).execute()
            if(file['title'].startswith('Copy of ')):
                new_title = file['title'].replace('Copy of ', '')
                rename_file(service, fileid, new_title)
        except:
            print('An error occurred')

if __name__ == '__main__':
    main()
```
