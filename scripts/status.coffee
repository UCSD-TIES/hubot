# Description: 
#   An additional functionality that lets hubot communicate with servers and be able to grab system data from those servers
#
#   Dependencies:
#   SSH2 (https://github.com/mscdex/ssh2)
#
#   Configuration:
#
#   Commands:
#   hubot status - replies with uptime of staging (for now)
ConnectServ = require("ssh2")

module.exports = (robot) ->
  robot.respond /status\s?(.*)?/i, (msg) ->
    if msg.match[1] == 'stagedb'
      envhost = process.env['STAGING_DB_SSH_HOST']
      envport = process.env['STAGING_DB_SSH_PORT']
      envuser = process.env['STAGING_DB_SSH_USER']
      envprivatekey = process.env['STAGING_PRIVATEKEY']
    
    if msg.match[1] == 'stagingpy'
      envhost = process.env['STAGING_PY_SSH_HOST']
      envport = process.env['STAGING_PY_SSH_PORT']
      envuser = process.env['STAGING_PY_SSH_USER']
      envprivatekey = process.env['STAGING_PRIVATEKEY']
    
     if msg.match[1] == 'stagingq'
      envhost = process.env['STAGING_Q_SSH_HOST']
      envport = process.env['STAGING_Q_SSH_PORT']
      envuser = process.env['STAGING_Q_SSH_USER']
      envprivatekey = process.env['STAGING_PRIVATEKEY']

     if msg.match[1] == 'stagingworkers'
      envhost = process.env['STAGING_WORKERS_SSH_HOST']
      envport = process.env['STAGING_WORKERS_SSH_PORT']
      envuser = process.env['STAGING_WORKERS_SSH_USER']
      envprivatekey = process.env['STAGING_PRIVATEKEY']
    
    
    moo = ""
    c = new ConnectServ()
    c.on "connect", ->

    c.on "ready", ->
      c.exec "uptime", (err, stream) ->
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
