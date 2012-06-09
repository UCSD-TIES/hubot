API_KEY = 'key-8w2x33l2xsi8soop6l2wl3fdyw6fnfr0'
API_URL = 'https://api.mailgun.net/v2'

module.exports = (robot) ->
  robot.respond /send all (.*)$/i, (message) ->
    message.http("#{API_URL}/lists")
      .auth("api:#{API_KEY}")
      .query(
        from: message.message.user,
        # to: 'team@app3955312.mailgun.org'
        to: 'lewis.f.chung@gmail.com',
        subject: "#{message.message.user} on Hipchat sent a message to everyone!",
        text: "#{message.message.user}: #{message.match[1]}",
        html: "<b>#{message.message.user}:</b> #{message.match[1]}",
      )
      .header('Content-Length', 0)
      .post({}) (err, res, body) ->
        console.log err
        console.log res
        console.log body
        if json.success == true
          message.send("Message sent.")
        else
          message.send("Error sending message. (dealwithit)")
