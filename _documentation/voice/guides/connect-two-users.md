---
title: Connect two users
---

# Connect two users

As well as sending voice messages and receiving incoming calls, with the Voice API you can connect two users in a call. For example, to schedule a call between a customer and your sales team.

In this section you see how you can make a scheduled call to two users with Nexmo APIs:
* [Prerequisites](#prerequisites) - setup the Nexmo Application dedicated to this workflow
* [Connect your users](#create_ncco) - make an API request to call one user and provision the NCCO to call the other

## Prerequisites

To follow the steps in this section you need:

* [Nexmo account](tools/dashboard#setting-up-your-nexmo-account)
* [Nexmo application](tools/application-api#apps_quickstart)
* An HTTP server to provide the NCCOs
* The connection information for both users

## Connect your users

To connect two users in a voice call, your app uses Voice API to [initiate the Call](voice/voice-api/api-reference#call_create). Nexmo places the call to your customer and follows the actions in your NCCO. The *connect* action in your NCCO calls your sales team so both are in communication.  

```js_sequence_diagram
Participant answer_url
Participant Nexmo
Participant App
Participant Customer
Participant Sales team
Customer-> App: press "Call Sales"
App->Nexmo: POST Call
Nexmo->Customer: Initiate Call leg
Nexmo->answer_url: Send Call info
answer_url->Nexmo: Return NCCO with connect\n info for Sales team
Nexmo->Sales team: Initiate Call leg
Customer->Sales team: Hi.
Sales team->Customer: Hi.
```

1. When your Customer presses the Call button, your App makes an authenticated request to [POST https://api.nexmo.com/v1/calls](voice/voice-api/api-reference#call_create) and initiates the first leg of the Call:


    ```tabbed_examples
    source: '/_examples/voice/guides/connect-two-users/1'
    ```

2. Your [webhook endpoint](messaging/setup-callbacks) at `answer_url` receives the Call info and returns the `call_sales.json` NCCO with the [connect](voice/voice-api/ncco-reference#connect) action to call your sales representative:


    ```tabbed_content
    source: '/_examples/voice/guides/connect-two-users/2'
    ```

    Ensure that answer_url for your Application is pointing to the webhook endpoint providing your NCCO. If not, use the [Nexmo CLI](tools/nexmo-cli#app_update) or [Application API](tools/application-api/api-reference#update) to update answer_url.


3. Nexmo initiates the second leg of the Call and your users are connected in a Voice call.

And that is it. You have connected two of your users with a single Call.