###
# example to spawn many child with constructor
###

Hook = require('hook.io').Hook

hook = new Hook({
  name: "hook",
  debug: true,
  hooks: ["helloworld", "helloworld", "helloworld", "helloworld"]
})

hook.on 'hook::ready', () ->
	console.log 'hook ready'

hook.start()
