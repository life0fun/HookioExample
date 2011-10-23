
Hook = require('hook.io').Hook
SiteMonitorHook = require('hook.io-sitemonitor').SiteMonitorHook
CronHook = require('hook.io-cron').CronHook

###
cronhook = new CronHook({
  name: "mycron-hook",
  debug: true
});
cronhook.start();
###

monhook = new SiteMonitorHook({
  name: "sitemon-hook",
  debug: true
})

monhook.on 'hook::ready', () ->
  console.log 'SiteMonitorHook spawn done: cron hook'
  #cron = new CronHook( { name: "sitemonitor-cron", debug: true } );
  #cron.start();
  #monhook.spawn ['cron']
  #cronhook.start()
  
monhook.start()

###
hook = new Hook({
  name: "hook",
  debug: true,
  #hooks: ['sitemonitor']  
})
hook.on 'hook::ready', () ->
  console.log 'root hook ready'
  #cron = new CronHook( { name: "sitemonitor-cron", debug: true } );
  #cron.start();
  
hook.start()
###
