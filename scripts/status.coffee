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

module.exports = (robot) ->
  robot.respond /status/i, (msg) ->
    msg ConnectServ

ConnectServ = require("ssh2")
c = new ConnectServ()
c.on "connect", ->  
  #console.log "Connection :: connect"

c.on "ready", ->
  #console.log "Connection :: ready"
  c.exec "uptime", (err, stream) ->
    throw err if err
    stream.on "data", (data, extended) ->
      console.log ((if extended is "stderr" then "STDERR: " else "STDOUT: ")) + data

    #    stream.on "end", ->
      #console.log "Stream :: EOF"

      #stream.on "close", ->
      #console.log "Stream :: close"

      stream.on "exit", (code, signal) ->
      #console.log "Stream :: exit :: code " + code + ", signal : " + signal
      c.end()

c.on "error", (err) ->
  console.log "Connection :: error :: " + err

  #c.on "end", ->
  console.log "Connection :: end"

  #c.on "close", (had_error) ->
  console.log "Connection :: close"

c.connect
  host: "dev1.churenshao.com"
  port: 22
  username: "test1"
  password: "nodejs"