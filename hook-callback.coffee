###
 Example to show emit event with data and callback
###

Hook = require('hook.io').Hook
# pingPongModule = require('../../test/fixtures/pingPongModule.js')

hook1 = new Hook({
	name: "server-hook",
})

hook2 = new Hook({
	name: "callback-hook",
})

hook1.on '*::hello', (data, callback) ->
	###
	 callback is the callback for this event,
	 should it exist
	###
	result = {
		"text": "Why hello there!"
	}
	result.data = data
	
	callback null, result  # no err, with result obj

hook1.on 'hook::ready', () ->
  
	hook2.start()
  
	hook2.on 'hook::ready', () ->
		###
		Event with data
		event, data, callback
		###
		hook2.emit 'hello', 'data1', (err, data) ->
			console.log 'callback1 ', err, data

		###
		Event with data
		event, data, callback
		###
		hook2.emit 'hello', {"foo":"bar"}, (err, data) ->
			console.log 'callback2 ', err, data

		###
		Event with no data
		event, callback
		###
		hook2.emit 'hello', (err, data) ->
			console.log 'callback3 ', err, data

hook1.start()
