# Description: 
#   A script that allows hubot to make a dump of the database and send it to a public access folder.
#
#   Dependencies:
#   SSH2 (https://github.com/mscdex/ssh2)
#
#   Configuration:
#
#   Commands:
#   hubot dbdump stage - creates a dump of the db from the staging database
#   hubot dbdump prod - creates a dump of the db from the production database
ConnectServ = require("ssh2")

module.exports = (robot) ->
  robot.respond /dbdump\s?(.*)?/i, (msg) ->
    if msg.match[1] == 'stage'
      version = 'stage'
      envhost = process.env['STAGING_SSH_HOST']
      envport = process.env['STAGING_DB_SSH_PORT']
      envuser = process.env['STAGING_DB_SSH_USER']
      envprivatekey = process.env['PRIVATEKEY']
    
    if msg.match[1] == 'prod'
      version = 'prod'
      envhost = process.env['PROD_SSH_HOST']
      envport = process.env['PROD_DB_SSH_PORT']
      envuser = process.env['PROD_DB_SSH_USER']
      envprivatekey = process.env['PRIVATEKEY']
    
    moo = ""
    c = new ConnectServ()
    c.on "connect", ->

    c.on "ready", ->
      c.exec "pg_dump whwn | gzip > whwn.gz; scp whwn.gz robot@dev1.churenshao.com:~/public_html/whwn.gz", (err, stream) ->
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
      msg.send "DB Dump Complete, download at dev1.churenshao.com/~robot/whwn.gz"

    c.connect
      host: envhost
      port: envport
      username: envuser
      privateKey: envprivatekey
