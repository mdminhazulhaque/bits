---
layout: post
title: Authenticate Fluentd to Access BigQuery
date: 2019-05-08
category: linux
---
Fluentd is a pretty good log collection and streaming solution for several platforms. You can easily stream your nginx logs to BigQuery via Fluentd.

There is a nicely written article on [Analyzing logs in real time using Fluentd and BigQuery](https://cloud.google.com/solutions/real-time/fluentd-bigquery) by Google. This guide has everything explained properly to get started with Fluentd-nginx-BigQuery.

I followed the whole process but ended up receiving the following error at `/var/log/td-agent/td-agent.log`.

```
2019-05-07 16:13:15 +0000 [error]: #0 tables.get API project_id="farm-rock-85697" dataset="fluentd" table="nginx_access" code=403 message="accessDenied: Access Denied: Table farm-rock-85697:fluentd.nginx_access: The user 87674165174597-compute@developer.gserviceaccount.com does not have bigquery.tables.get permission for table farm-rock-85697:fluentd.nginx_access."
2019-05-07 16:13:15 +0000 [warn]: #0 emit transaction failed: error_class=RuntimeError error="failed to fetch schema from bigquery" location="/opt/td-agent/embedded/lib/ruby/gems/2.4.0/gems/fluent-plugin-bigquery-2.1.0/lib/fluent/plugin/out_bigquery_base.rb:190:in `fetch_schema'" tag="nginx.access"
```

What I guessed was that Fluentd could not access BigQuery table on GCP. Obviously it could not anyway because I had not authenticated `gcloud` in the VM. I tried authenticating `gcloud` tool from `td-agent` user but failed as `td-agent` has no valid shell. Also I tried the same for `root`, but did not help.

Finally after one day of searching over the internet, I got some clue about putting JSON files in somewhere so the `fluent-plugin-bigquery` can read it.

Go to [Google Cloud Platform > APIs & Services](https://console.cloud.google.com/apis/credentials). Then click on `Credentials` and hit on the `Create Credentials` button. Choose `Service Account Key` from the combo box. This will open a new page where you have to fill the credential name, roles etc.

![Credential-Page](https://i.imgur.com/Gbkrc6c.png)

Now setup a name for this service, set correct access in Roles (i.e. BigQuery Insert) and select `JSON` as type. Click `Create`.

![Role-Type-Page](https://i.imgur.com/uUXb2DZ.png)

After creating the credentials, you will be able to download the file. Now open up `/etc/td-agent/td-agent.conf` in your VM and change the following lines.

```
  auth_method json_key
  json_key /etc/td-agent/gcloud.json
```

Not to mention that you must copy the newly downloaded JSON file to your VM as `gcloud.json`. The whole `nginx.access` block should look something similar to this.

```
<match nginx.access>

  @type bigquery_insert

  <buffer>
   flush_interval 0.1
    total_limit_size 10g
    flush_thread_count 16
  </buffer>

  auth_method json_key
  json_key /etc/td-agent/gcloud.json

  project "farm-rock-85697:api-project-1587663"
  dataset nginx
  tables www_imoney_my

</match>
```

Now restart `td-agent` using `systemctl` and check `/var/log/td-agent/td-agent.log`. You can see records are successfully being inserted into BigQuery if all the credentials, roles, project, dataset and table configuration is correct.
