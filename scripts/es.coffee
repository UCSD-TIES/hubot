# Description:
#   Check elasticsearch uptime. 
#
# Commands:
#   hubot check es - Check the to see if elasticsearch is running.

module.exports = (robot) ->
  robot.respond /check es$/i, (msg) ->
    msg.http('http://ec2-184-169-193-129.us-west-1.compute.amazonaws.com:9200/')
      .get() (err, res, body) ->
        json = JSON.parse(body)
          console.log json
