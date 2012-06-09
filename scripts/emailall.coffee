# My attempt to get Mailgun hooked up with hubot

module.exports = (robot) ->
  robot.respond /send all (.*)$/i, (message) ->
    message.http("https://api:key-8w2x33l2xsi8soop6l2wl3fdyw6fnfr0@api.mailgun.net/v2/app3955312.mailgun.org/messages")
      .query(
        from: 'lewis@app3955312.mailgun.org'
        to: 'lewis.f.chung@gmail.com'
        subject: 'Testing Mailgun API'
        text: 'testing this')
      .headers('Content-Type': 'application/x-www-form-urlencoded', 'Content-Length': 500)
      .post({}) (err, res, body) ->
        if err
          message.send "#{err}"
          return
        else
          message.send "#{body}"
