###
# Creates a helloworld hook, then spawns three helloworld children
###

Helloworld = require('hook.io-helloworld').Helloworld

myHello = new Helloworld({ name: "helloworld", debug:true })

myHello.on 'hook::ready', () ->

	###
	This will spawn up three more "helloworld" hooks with auto-configuration
	see: custom-hook-spawn.js for customized spawn settings
	###
	myHello.spawn ['helloworld', 'helloworld', 'helloworld']

myHello.start()
