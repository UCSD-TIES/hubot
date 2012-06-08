API_KEY = 'key-8w2x33l2xsi8soop6l2wl3fdyw6fnfr0'
API_URL = 'https://api.mailgun.net/v2'

module.exports = (robot) ->
  robot.respond /(send all)? (.*)/i, (msg) ->
    msg
      .http("#{API_URL}/lists")
      .auth("api:#{API_KEY}")
      .query(
        from: msg.message.user,
        # to: 'team@app3955312.mailgun.org'
        to: 'lewis.f.chung@gmail.com',
        subject: "#{msg.message.user} on Hipchat sent a message to everyone!",
        text: "#{msg.message.user}: #{msg.match[1]}",
        html: "<b>#{msg.message.user}:</b> #{msg.match[1]}",
      )
      .header('Content-Length', 0)
      .post() (err, res, body) ->
        json = JSON.parse(body)
        if json.success == true
          msg.send("Message sent.")
        else
          msg.send("Error sending message. (dealwithit)")
