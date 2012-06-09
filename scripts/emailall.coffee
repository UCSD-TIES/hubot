# Require request, querystring, url for handling urls
request = require 'request'
querystring = require 'querystring'
url = require 'url'

# provided message mailgun api endpoint
mailgun_uri = url.parse('https://api.mailgun.net/v2/app3955312.mailgun.org/messages')

# api key (basic http auth)
mailgun_uri.auth = 'api:key-8w2x33l2xsi8soop6l2wl3fdyw6fnfr0'

module.exports = (robot) ->
  robot.respond /send all (.*)$/i, (message) ->
    message.send("Trying to send message.")
    body = querystring.stringify(
      from: 'lewis.f.chung@app3955312.mailgun.org'
      to: 'lewis.f.chung@gmail.com'
      subject: 'hello'
      text: 'testing this'
      'o.testmode': 'true'
    )

    console.log body

    request(
      url: mailgun_uri
      method: 'POST'
      headers:
        'content-type': 'application/x-www-form-urlencoded'
      body: body
      (err, res, body) ->
        console.log res.statusCode
        if res.statusCode == 200
          message.send("Message sent.")
        console.log body
    )
