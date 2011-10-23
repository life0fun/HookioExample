###
# Creates a helloworld hook, then spawns three helloworld children
###

Hook = require('hook.io').Hook

pingPongModule = do ->
	ping: (msg) ->
		console.log msg
		msg

myHook = new Hook({
	name: "event-map-hook",
	eventMap: {  # each hook can have a eventMap
		"*::ping"		: pingPongModule.ping,
		"*::customPing" : (msg) ->
			console.log 'custom ping with msg:', msg
			msg = 'foo ' + msg
			pingPongModule.ping msg
		},
	debug: true
	})

myHook.on 'hook::ready', () ->
	console.log 'ready'
	myHook2.start()

myHook2 = new Hook({
	name: 'trigger',
	debug: true
})

myHook2.on 'hook::ready', () ->
	myHook2.emit 'customPing', 'customPing from trigger'
	myHook2.emit 'ping', 'ping from trigger'

myHook.start()
