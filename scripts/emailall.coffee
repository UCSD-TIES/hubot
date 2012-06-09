# My attempt to get Mailgun hooked up with hubot

module.exports = (robot) ->
  robot.respond /send all (.*)$/i, (message) ->
    message.send "Okay."
    message.http("https://api:key-8w2x33l2xsi8soop6l2wl3fdyw6fnfr0@api.mailgun.net/v2/lewis.mailgun.org/messages")
      .query(
        from: 'postmaster@lewis.mailgun.org'
        to: 'lewis.f.chung@gmail.com'
        subject: 'Testing Mailgun API'
        text: 'testing this')
      .headers('Content-Type': 'application/x-www-form-urlencoded', 'Content-Length': 0)
      .post({}) (err, res, body) ->
        console.log "#{res}"
        if err
          console.log "#{err}"
          message.send "#{err}"
          return
        else
          console.log "#{body}"
          message.send "#{body}"
          return
