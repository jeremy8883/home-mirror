#  Home Mirror

A smart mirror web application written in elm. It's a work in progress, so nothing much to see yet.

## Getting started

Begin by creating `.private/config.json`, and adding:

```
{
  "weather": {
    "darkSkyApiKey": <string>,
    "longitude": <float>,
    "latitude": <float>
  },
  "oauth": {
    "clientId": <string>
  },
  "calendar": {
    "name": <string>
  }
}

```

You can get weather credentials very easily from [Dark Sky](https://darksky.net/dev/). Find out what your lat/long coords are from [here](http://www.latlong.net/).

For the calendar, you'll need to visit [the Google dev console](https://console.developers.google.com/), create a project, enable the Google Calendar API, create an "Oauth client ID" under the credentials section, add `http://localhost:8090` to the "Authorized javascript origins", add `http://localhost:8090/oauth.html` to the "Authorized redirect URIs", and then add the client ID to the `.private/config.json`. More info [here](https://developers.google.com/google-apps/calendar/caldav/v2/guide#creating_your_client_id).

I've only written this app only to work with Google Calendar, so if you use something else, you will need to implement it yourself.

To run:

```
npm run start
```

then visit http://localhost:8090 in your browser.

## For such a small project, why use elm?

I wanted to learn it.
