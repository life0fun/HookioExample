###
# custom spawn child
###

Hook = require('hook.io').Hook

hook = new Hook({
  name: "hook",
  hooks: [
     {
       type: 'helloworld',
       name: 'b',
       debug: true,
       foo: "bar"
     },
     {
       type: 'helloworld',
       name: 'c',
       debug: true,
       beep: "boop"
     },
     {
       type: 'helloworld',
       name: 'd',
       debug: true,
     }
   ]
})

hook.on 'hook::ready', () ->
  console.log 'hook ready'

hook.start()
