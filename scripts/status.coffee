# Description: 
#   An additional functionality that lets hubot communicate with servers and be able to grab system data from those servers
#
#   Dependencies:
#   SSH2 (https://github.com/mscdex/ssh2)
#
#   Configuration:
#
#   Commands:
#   hubot status stagedb - Status of staging DB
#   hubot status stagepy - Status of staging Python
#   hubot status stageq - Status of staging Queue
#   hubot status stageworkers - Status of staging workers
#   hubot status proddb - Status of production DB
#   hubot status prodpy - Status of production Python
#   hubot status prodq - Status of production Queue
#   hubot status prodworkers - Status of production workers

ConnectServ = require("ssh2")

module.exports = (robot) ->
  robot.respond /status\s?(.*)?/i, (msg) ->
    if msg.match[1] == 'stagedb'
      envhost = process.env['STAGING_SSH_HOST']
      envport = process.env['STAGING_DB_SSH_PORT']
      envuser = process.env['STAGING_DB_SSH_USER']
      envprivatekey = process.env['PRIVATEKEY']
    
    if msg.match[1] == 'stagepy'
      envhost = process.env['STAGING_SSH_HOST']
      envport = process.env['STAGING_PY_SSH_PORT']
      envuser = process.env['STAGING_PY_SSH_USER']
      envprivatekey = process.env['PRIVATEKEY']
    
     if msg.match[1] == 'stageq'
      envhost = process.env['STAGING_SSH_HOST']
      envport = process.env['STAGING_Q_SSH_PORT']
      envuser = process.env['STAGING_Q_SSH_USER']
      envprivatekey = process.env['PRIVATEKEY']

     if msg.match[1] == 'stageworkers'
      envhost = process.env['STAGING_SSH_HOST']
      envport = process.env['STAGING_WORKERS_SSH_PORT']
      envuser = process.env['STAGING_WORKERS_SSH_USER']
      envprivatekey = process.env['PRIVATEKEY']
    
    if msg.match[1] == 'proddb'
      envhost = process.env['PROD_SSH_HOST']
      envport = process.env['PROD_DB_SSH_PORT']
      envuser = process.env['PROD_DB_SSH_USER']
      envprivatekey = process.env['PRIVATEKEY']
    
     if msg.match[1] == 'prodpy'
      envhost = process.env['PROD_SSH_HOST']
      envport = process.env['PROD_PY_SSH_PORT']
      envuser = process.env['PROD_PY_SSH_USER']
      envprivatekey = process.env['PRIVATEKEY']
    
     if msg.match[1] == 'prodq'
      envhost = process.env['PROD_SSH_HOST']
      envport = process.env['PROD_Q_SSH_PORT']
      envuser = process.env['PROD_Q_SSH_USER']
      envprivatekey = process.env['PRIVATEKEY']
    
     if msg.match[1] == 'prodworkers'
      envhost = process.env['PROD_SSH_HOST']
      envport = process.env['PROD_WORKERS_SSH_PORT']
      envuser = process.env['PROD_WORKERS_SSH_USER']
      envprivatekey = process.env['PRIVATEKEY']
    

    
    moo = ""
    c = new ConnectServ()
    c.on "connect", ->

    c.on "ready", ->
      c.exec "top -n 1 -b", (err, stream) ->
       throw err if err
       stream.on "data", (data, extended) ->
         console.log ((if extended is "stderr" then "STDERR: " else "STDOUT: ")) + data
         moo = data.toString('utf-8')

        stream.on "exit", (code, signal) ->
          c.end()

    c.on "error", (err) ->
      console.log "Connection :: error :: " + err

    c.on "end", ->
      console.log "Connection :: end"

    c.on "close", (had_error) ->
      console.log "Connection :: close"
      msg.send moo

    c.connect
      host: envhost
      port: envport
      username: envuser
      privateKey: envprivatekey
    #msg.send moo
