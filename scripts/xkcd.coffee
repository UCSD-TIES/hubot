#Description:
#   Grab XKCD comic image urls
#
# Dependencies:
#   None
# 
# Configuration:
#   None
#
# Commands:
#   hubot xkcd - The latest XKCD comic
#   hubot xkcd <num> - XKCD comic <num>
#
# Author:
#   twe4ked
module.exports = (robot) ->
  robot.respond /xkcd\s?(\d+)?/i, (msg) ->
    if msg.match[1] == undefined
      num = ''
      cat = '1'
    else if msg.match[1] == 'random'
      num = ''
      cat = '31337'
    else
      num = "#{msg.match[1]}/"
      cat = '1'

      msg.http("http://xkcd.com/#{num}info.0.json")
        .get() (err, res, body) ->
          if res.statusCode == 404
            msg.send 'Comic not found.'
          else
            object = JSON.parse(body)
            if cat == 31337
              rand = Math.floor(Math.random() * (object.num)) + 1
              msg.http("http://xkcd.com/#{rand}info.0.json")
                .get() (err, res, body) -> 
                  if res.statusCode == 404
                    msg.send 'Comic not found.'
                  else
                    object2 = JSON.parse(body)
                    msg.send object2.title, object2.img, object2.alt
              else  
                msg.send object.title, object.img, object.alt