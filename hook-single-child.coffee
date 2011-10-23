
###
 single child hook constructor
###

Hook = require('hook.io').Hook

hook = new Hook({
	name: "hook",
	debug: true,
	hooks: ["helloworld"]
})

hook.on 'hook::ready', () ->
  console.log 'hook ready'

hook.start()
