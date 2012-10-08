# Hubot has personality, he says stuff.

module.exports = (robot) ->
  robot.hear /tired|too hard|to hard|too difficult|too much to handle|upset|bored|lazy/i, (msg) ->
    msg.send "Stop being such a panzy."
