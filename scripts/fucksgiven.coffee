# Gives number of fucks given
#
module.exports = (robot) ->
  robot.hear /don't give a fuck/i, (msg) ->
    msg.send "http://i.qkme.me/3r3ek2.jpg"
  
  robot.hear /gg/i, (msg) ->
    msg.send "http://cdn.shopify.com/s/files/1/0057/8602/products/Red03_1024x1024.jpg?0"