---
layout: post
title: Create Batch Directories in Google Drive using Ruby
date: 2016-06-07
tag: ruby
---

Here is a code snippet I wrote months ago to create several directories using Google Drive Ruby API. Please note that you need to set the scope to `https://www.googleapis.com/auth/drive` so the API call can commit changes to your drive. You need to authorize the app first. Run the script, it will open a browser session, allow access to Drive. Then you will be able to download `credentials.json` from Google Drive Developer Console website.

```ruby
require 'google/api_client'
require 'google/api_client/client_secrets'
require 'google/api_client/auth/installed_app'
require 'google/api_client/auth/storage'
require 'google/api_client/auth/storages/file_store'
require 'fileutils'

APPLICATION_NAME = 'Drive API Quickstart'
CLIENT_SECRETS_PATH = 'client_secret.json'
CREDENTIALS_PATH = File.join(Dir.home, '.credentials', "credentials.json")
SCOPE = 'https://www.googleapis.com/auth/drive'

def authorize
  FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))

  file_store = Google::APIClient::FileStore.new(CREDENTIALS_PATH)
  storage = Google::APIClient::Storage.new(file_store)
  auth = storage.authorize

  if auth.nil? || (auth.expired? && auth.refresh_token.nil?)
    app_info = Google::APIClient::ClientSecrets.load(CLIENT_SECRETS_PATH)
    flow = Google::APIClient::InstalledAppFlow.new({
      :client_id => app_info.client_id,
      :client_secret => app_info.client_secret,
      :scope => SCOPE})
    auth = flow.authorize(storage)
    puts "Credentials saved to #{CREDENTIALS_PATH}" unless auth.nil?
  end
  auth
end

def create_directory(client, dir_name, parentid)
    drive = client.discovered_api('drive', 'v2')
    file = drive.files.insert.request_schema.new({
    'title' => dir_name,
    'mimeType' => 'application/vnd.google-apps.folder'})

    file.parents = [{'id' => parentid }]

    result = client.execute(
        :api_method => drive.files.insert,
        :body_object => file
    )
    if result.status == 200
        return result.data['id']
    else
        puts "An error occurred: #{result.data['error']['message']}"
    end
end

client = Google::APIClient.new(:application_name => APPLICATION_NAME)
client.authorization = authorize

puts create_directory(client, "foo", '0BwaM3xCs0Uh4WjA4OU1IY01rb2M')
puts create_directory(client, "bar", '0BwaM3xCs0Uh4WjA4OU1IY01rb2M')
```
