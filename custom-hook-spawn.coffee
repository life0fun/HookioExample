###
# Custom Hook-io Spawn
###

Helloworld = require('hook.io-helloworld').Helloworld

myHello = new Helloworld({name:"a", debug:true})

myHello.on 'hook::ready', () ->
	myHello.spawn [
		{
			type: 'helloworld',
			name: 'b',
			foo: "bar"
		},
		{
			type: 'helloworld',
			name: 'c',
			beep: "boop"
		},
		{
			type: 'helloworld',
			name: 'd'
		}
	]

myHello.start()
