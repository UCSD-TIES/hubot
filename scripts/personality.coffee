# Hubot has personality, he says stuff.

module.exports = (robot) ->
  robot.hear /tired|too hard|to hard|upset|bored|lazy/i, (msg) ->
    msg.send "Stop being such a panzy."
