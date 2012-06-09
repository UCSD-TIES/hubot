request = require 'request'
querystring = require 'querystring'
url = require 'url'

mailgun_uri = url.parse('https://api.mailgun.net/v2/app3955312.mailgun.org/messages')
mailgun_uri.auth = 'api:key-8w2x33l2xsi8soop6l2wl3fdyw6fnfr0'

module.exports = (robot) ->
  robot.respond /send all (.*)$/i, (message) ->
    body = querystring.stringify(
      from: 'lewis.f.chung@gmail.com'
      to: 'lewis.f.chung@gmail.com'
      subject: 'hello'
      text: 'testing this'
      'o.testmode': 'true'
    )

    request(
      url: mailgun_uri
      method: 'POST'
      headers:
        'content-type': 'application/x-www-form-urlencoded'
      body: body
      (err, res, body) ->
        console.log res.statusCode
        console.log body
    )
