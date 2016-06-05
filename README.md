Teamfinder
---

Teamfinder is a minimally-creepy service for tracking the physical locations of you and your teammates.

It determines your location by the MAC address of the wireless access point that you're currently connected to. This is a lot less creepy than trying to track folks by GPS, while still being accurate enough to determine that "Adam is in the 3rd floor kitchen." We also have our script configured to only track locations when we're logged into Slack, which is a good indicator for if someone is working or not.

## High-level overview

- This repo consists of a Rails API that you'll need to deploy
- You'll need to setup a recurring task on your laptop to send your BSSID to the API server
  - [Shell script example](https://gist.github.com/ajb/01eb57fc5ba535ea1d80adcae5c4b84a)
  - [Launchd agent example](https://gist.github.com/ajb/b64100ba7ff086bc1605638a5fe4ca71)
- You can then query the API directly, or set up a chat bot to interface with the server for you
  - [Hubot example](https://gist.github.com/ajb/c8f1a56ef9ef31817766423b59d31fef)

## Screenshots

![Asking Hubot where everyone is](http://take.ms/9bdjI)

![Hubot reminding you to set a location](http://take.ms/mSMkm)

## License

MIT
