---
title: Portfolio item number 1
excerpt: >-
  Short description of portfolio item number 1<br/><img
  src='/images/500x300.png'>
collection: portfolio
published: true
---
---
title: "Mensageiro App"
excerpt: "An Android app that enables two-way SMS messaging with the Mensageiro Platform <br/><img src='/images/mensageiro.png'>"
collection: portfolio
---

<div style="text-align: justify">
Having the ability to integrate with SMSC servers directly from your own platform has many advantages, but unfortunately it is not always trivial job and in some places it is not available and/or the SMSC access can prove to be very expensive. As such, it's important to have an alternative method for enabling two-way SMS messaging.

The "Mensageiro" App for the Mensageiro Platform, does just that by using an inexpensive Android phone. Since Android phones are essentially little computers with redundant network and power, it makes it easy for us to leverage it's GSM modem for our needs.


Mensageiro's Android app enables you to send and receive messages anywhere you can acquire a local SIM card. Simply download the Mensageiro Android application on your phone and follow the instructions to connect it to your account. When the app is active, anytime your Mensageiro Platform account sends a message, it will notify your Android phone. The phone will then send the message from your local number on your behalf. If somebody responds to that message, the phone will relay it back to your Mensageiro Platform account. You can add as many Android channels as you like, and even enable IVR (voice) functionalilty.
</div>

The Mensageiro is open source, licensed under AGPL. Copyright 2018 Abdul Meque.

[Click here to download from Play Store](http://https://play.google.com/store/apps/details?id=io.im3nsa.canalandroid)

## Features

* Authenticate number via Firebase Cloud Messaging
* Push notifications
* Network preference
* Bypass Android's 100 SMS per hour bottleneck 
* Push and Pull SMS messages to/from the server
* Detailed Log of the messages sent/received/failed

# Technologies/Tools Used

* Android Platform 26+
* Android SDK 3
* Firebase Cloud Messaging 
* Java 8
* Gradle 4
* Google PlayServices