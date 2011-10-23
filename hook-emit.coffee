###
# Example to show simple emit event with data
# Hook can only emit event after 'hook::ready' is done, i.e. 
# The receiver hook must be 'hook::ready', i.e., it has successfully 
# connected to the hook hub(the first hook binds to 5000).
# Otherwise, the msg will just get lost
###

Hook = require('hook.io').Hook

hook1 = new Hook({
  name: "server-hook",
  debug: true
})

hook2 = new Hook({
  name: "callback-hook",
  debug: true
})

hook3 = new Hook({
  name: "hook3",
  debug: true
})

hook4 = new Hook({
  name: "hook4",
  debug: true
})


hook1.on '*::hello', (data, callback) ->
	console.log 'hook1 on hello:', data, callback
	callback null, data  # if callback missing, default is emit event::result 
	hook1.emit 'hello::done', 'hook1-done'

hook1.on 'hook::ready', ->
	hook2.start()
	#hook3.start()
	#hook4.start()   # start cause hook connect and hook ready
	
	# the recver must be successfully connected.
	#hook1.emit 'hello', 'world', (err, data) ->
	#	console.log 'hook1 emitted hello msg got caught:', data

hook2.on 'hook::ready', ->
		hook2.on '*::hello', (data, cb) ->
			console.log 'hook2 caught:', data
			cb 'no err', 'caught by hook2'

		hook2.on 'hello::result', (data) ->
			console.log 'hook2 on hello result: ', data
			console.log this.event

		hook2.on '*::*::done', (data, callback) ->
			console.log 'hook2 on done:', data

		hook1.emit 'hello', 'world', (err, data) ->
			console.log 'hook1 emitted hello msg got caught:', data

hook3.on 'hook::ready', ->
	hook3.on '*::h-hello', (data) ->
		console.log 'hook3 on h-hello: ', data
		msg = this.event + '::3::hook'
		console.log this.event, msg
		this.emit msg, {from: 'hook3 emit'}

	hook3.on '*hook', (data, callback) ->
		console.log 'hook3 on * hook:', data

	# must be exact match to catch namespaced msg
	hook3.on '*::*::*::*::hook', (data, callback) ->
		console.log 'hook3 on **** hook:', this.event, data
		
	hook3.emit 'h-hello', {from: 'hook3 emitted'}

hook4.on 'hook::ready', ->
	hook4.on '*::h-hello', (data) ->
		console.log 'hook4 on h-hello: ', data
		msg = this.event + '::4::hook'
		console.log 'event:', this.event, 'msg:', msg
		this.emit msg, {from: 'hook4 emit'}

	hook4.on '*::*::hook', (data, callback) ->
		console.log 'hook4 on **hook:', data

hook1.start()
