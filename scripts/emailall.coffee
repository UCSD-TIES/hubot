API_KEY = 'key-8w2x33l2xsi8soop6l2wl3fdyw6fnfr0'
API_URL = 'https://api.mailgun.net/v2'

module.exports = (robot) ->
  robot.respond /send all (.*)$/i, (message) ->
    message.http("https://api:key-8w2x33l2xsi8soop6l2wl3fdyw6fnfr0@api.mailgun.net/v2/lists")
      .query(
        from: "admin@wehave-weneed.org",
        # to: 'team@app3955312.mailgun.org'
        to: 'lewis.f.chung@gmail.com',
        subject: "#{message.message.user} on Hipchat sent a message to everyone!",
        text: "#{message.message.user}: #{message.match[1]}",
        html: "<b>#{message.message.user}:</b> #{message.match[1]}",
      )
      .headers({ 'Content-Length': 0, 'Authorization': 'auth' })
      .post({}) (err, res, body) ->
        console.log body
        message.send("Message sent.")