###
# Creates a hook, spawns up three custom hooks, then queries the hook cloud for information
###

#Hook = require('hook.io').Hook
Hook = require('/Users/e51141/macsrc/nodejs/hook.io/lib/hookio').Hook

hook1 = new Hook({
	name: "server-hook",
	debug: true
})

hook1.on 'hook::ready', () ->
	hook1.on 'children::ready', () ->
		###
		# Remark: Get all hooks of generic type "hook" with a callback
		###
		hook1.emit 'query', { "type": "hook" }, (err, result) ->
			console.log 'hook query callback result:'.green.bold.underline + ' ' + JSON.stringify(result, true, 2).grey

		###
		# Remark: Get all hooks of generic type "hook" with an emitter
		###
		hook1.on 'query::out', (result) ->
			console.log 'hook query emit result:'.green.bold.underline + ' ' + JSON.stringify(result, true, 2).grey

		hook1.emit 'query', { "type":"hook" }
	
	###
	 Remark: Spawn up three child hooks with custom options
	###
	hook1.spawn [
		{
			type: 'hook',
			name: 'b',
			foo: "bar"
		},
		{
			type: 'hook',
			name: 'c',
			beep: "boop"
		},
		{
			type: 'hook',
			name: 'd'
		}
	]
  
hook1.start()
