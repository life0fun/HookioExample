###
 Example to show simple emit event with data
###

Hook = require('hook.io').Hook
Helloworld = require('hook.io-helloworld').Helloworld

hook1 = new Hook({
  name: "server-hook",
  debug: true
})

#hook2 = new Hook({
hook2 = new Helloworld({
  name: "hello-hook",
  debug: true
})

hook1.on '*::hello', (data, callback) ->
	console.log 'hook1 on hello:', data, arguments, callback
	# you can not change the arguments data with default callback.
	#callback null, 'xxxx'  # if callback missing, default is emit event::result 
	hook1.emit 'hello::done', 'hook1-done...x'

hook1.on 'hook::ready', ->
	hook2.start ->
	hook2.on 'hook::ready', ->
		hook2.on 'hello::result', (data) ->  # ::result msg sent by default callback
			console.log 'hook2 on result: hello result: ', data
			console.log this.event

		hook2.on '*::*::done', (data, callback) ->
			console.log 'hook2 on done:', data
		
		hook2.emit 'hello', 'world', (err, data) ->
			console.log 'hook2 emitted hello msg got caught:', data

hook1.start()
