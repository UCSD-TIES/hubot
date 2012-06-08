API_KEY = 'key-8w2x33l2xsi8soop6l2wl3fdyw6fnfr0'
API_URL = 'https://api.mailgun.net/v2'

module.exports = (robot) ->
  robot.respond /(send all)? (.*)/i, (msg) ->
    msg
      .http(API_URL + '/lists')
      .auth(api+ ':' + API_KEY)
      .query
        from: msg.message.user
        # to: 'team@app3955312.mailgun.org'
        to: 'lewis.f.chung@gmail.com'
        subject: msg.message.user + ' on Hipchat sent a message to everyone!'
        text: msg.message.user + ': ' + msg.message.text
        html: '<b>' + msg.message.user + ':</b> ' + msg.message.text
      .headers
        'Accept-Language': 'en-us,en;q=0.5',
        'Accept-Charset': 'utf-8',
        'User-Agent': "Mozilla/5.0 (X11; Linux x86_64; rv:2.0.1) Gecko/20100101 Firefox/4.0.1"
      .get() (err, res, body) ->
        json = eval("(#{body})")
        msg.send json.rhs || 'Could not compute.'

        
    
