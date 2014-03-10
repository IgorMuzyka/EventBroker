
###About

EventBroker is wrapper of EventEmitter which provides you to have levels/namespaces of messages to listen to.

So imagine few listeners: lets start with ``` NewYork ```.
It is message by now but also namespace or level or whatever you like to call it.
In fact some listener like that ``` NewYork:SomeAvenue ``` is also a message but we wrap it like it is namespace.

So if you listen to ``` NewYork:SomeAvenue ``` you will recieve only what goes there and if you have namespace ``` NewYork:SomeAvenue:AvenueNumber ``` it will not be emitted to ``` NewYork:SomeAvenue ```, but if you listen to ``` NewYork:SomeAvenue:* ``` you will.
And if you listen to ``` NewYork:* ``` you will get all the messages emitted to any namespace inside ``` NewYork ``` eg ``` NewYork:SomeAvenue ```, ``` NewYork:SomeAvenue:AvenueNumber ```.

---

###Example

Require it in your main file and create an instance (i'll put it into global)
```LiveScript
EventBroker = require "EventBroker"

global.broker = new EventBroker
```

Then in any other file do something like this
```LiveScript
global.broker.on "NewYork", (message) ->
    console.log "Listen to message to the NewYork"

global.broker.on "NewYork:CentralPark", (message) ->
    console.log "Listen to message to the CentralPark in NewYork"

global.broker.on "NewYork:StarbucksOnBroadway", (message) ->
    console.log "Listen to message to the StarbucksOnBroadway in NewYork"

global.broker.on "NewYork:CentralPark:Bench", (message) ->
    console.log "Listen to message to the Bench in CentralPark in NewYork"


global.broker.on "NewYork:*", (namespace, message) ->
    console.log "Listen to message to anyone in NewYork"

global.broker.on "London:*", (namespace, message) ->
    console.log "Listen to message to anyone in London"

global.broker.on "*", (namespace, message) ->
    console.log "Listen to any message in any namespace"

global.broker.any (namespace, message) ->
    console.log "Listen to any message in any namespace"
```

And then in main file
```LiveScript
slavefile = require "./yourAnotherFile"

global.broker.emit "NewYork", "Hello NewYork and everyone in it who listens to me"
global.broker.emit "London", "Hello London and everyone in it who listens to me"
global.broker.emit "NewYork:CentralPark", "Hello guys in Central Park who listens to me"
global.broker.emit "NewYork:CentralPark:Bench", "Hello beautiful girl right there who listens to me"

```
