
module.exports = (robot) ->
  robot.respond /send all (.*)$/i, (message) ->
    message.http("https://api:key-8w2x33l2xsi8soop6l2wl3fdyw6fnfr0@api.mailgun.net/v2/app3955312.mailgun.org/messages")
      .query(
        from: 'lewis@app3955312.mailgun.org'
        to: 'lewis.f.chung@gmail.com'
        subject: 'Testing Mailgun API'
        text: 'testing this')
      .headers('Content-Type': 'application/x-www-form-urlencoded')
      .post({}) (err, res, body) ->
        if err
          message.send "#{err}"
          return
        else
          message.send "#{body}"
