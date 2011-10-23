###
 Creates a hook and spawns a helloworld child both with an additional CouchDB transport
###

#Hook = require('hook.io').Hook
Hook = require('/Users/e51141/macsrc/nodejs/hook.io/lib/hookio').Hook

myHook = new Hook({
	name: "event-transport-hook",
	debug: true,
	transports: [
		{
			"type" : "couchdb",
			"options": {
				"host": "localhost",
				"port": 5984,
				"db": "mydatabase"
			}
		}
	]
})

myHook2 = new Hook({
	name: "event-transport-hook2",
	debug: true,
	eventMap: {
		"hook::ready" : () ->
			myHook2.emit 'ready', {'hook2':'ready'}

		"*::someevent": (data) ->
			console.log 'hook2 handle someevent:', data
	},
	transports: [
		{
			"type" : "couchdb",
			"options": {
				"host": "localhost",
				"port": 5984,
				"db": "mydatabase"
			}
		}
	]
})

myHook.on 'hook::ready', () ->
	myHook.spawn [{
		name: "event-transport-hook-child",
		type: "hook",
		debug: true,
		eventMap: {   # spawn does not inheritance eventMap
			"*::someevent": (data) ->
				console.log 'hook spawned child handle someevent:', data
		},
		transports: [
			{
				"type" : "couchdb",
				"options": {
					"host": "localhost",
					"port": 5984,
					"db": "mydatabase"
				}
			}
		]
	}]
	myHook2.start()
  
	myHook.on 'children::ready', () ->
		###
		  Remark: Since we have set couch as an transport,
		  the event will be copied and also sent to CouchDB
		###
		console.log 'handle spawned children ready.'
		myHook.emit 'someevent', { "foo": "bar" }

myHook.start()
