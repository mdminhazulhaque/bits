---
layout: post
title: "Android AsyncTask Example"
date: 2015-01-03 04:44:00
category: android
---
AsyncTask is a great API to perform background operations and without manipulating threads and/or handlers.

An easy update checker or remote information fetcher utility can be implemented using AsyncTask.

Here is a prototype.

```java
private class UpdateChecker extends AsyncTask<Void, Void, Void> {

    @Override
    protected Void doInBackground(Void... params) {

        String response = "";
        DefaultHttpClient client = new DefaultHttpClient();
        HttpGet httpGet = new HttpGet("https://example.com/update.xml");
        try {
            HttpResponse execute = client.execute(httpGet);
            InputStream content = execute.getEntity().getContent();

            BufferedReader buffer = new BufferedReader(new InputStreamReader(content));
            String line = "";
            while ((line = buffer.readLine()) != null) {
                response += line;
            }

            // do some work with response string

            final String finalNotificationText = "You have the latest update for this application";

            runOnUiThread(new Runnable() {
                public void run() {
                    Toast.makeText(getApplicationContext(), finalNotificationText, Toast.LENGTH_LONG).show();
                }
            });

        } catch (Exception e) {

            runOnUiThread(new Runnable() {
                public void run() {
                    Toast.makeText(getApplicationContext(),
                            "Unable to check for update\n"+
                            "Perhaps you have no internet access",
                            Toast.LENGTH_LONG).show();
                }
            });
        }
        return null;
    }
}
```

Wondering how to use this snippet into code? Simply call an instance of the class from Activity and wait for the result.

```java
Toast.makeText(getApplicationContext(), "Checking for updates ...", Toast.LENGTH_LONG).show();
UpdateChecker myTask = new UpdateChecker();
myTask.execute();
```
