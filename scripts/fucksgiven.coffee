# Gives number of fucks given
#
module.exports = (robot) ->
  robot.hear /don't give a fuck/i, (msg) ->
    msg.send "http://i.qkme.me/3r3ek2.jpg"