###
# Creates a helloworld hook, then spawns up a single helloworld child
###

Helloworld = require('hook.io-helloworld').Helloworld

myHello = new Helloworld({ name: "helloworld", debug:true })

myHello.on 'hook::ready', () ->

	###
	This will spawn up one "helloworld" hook with auto-configuration
	see: custom-hook-spawn.js for customized spawn settings
	###
	myHello.spawn 'helloworld'

myHello.start()
