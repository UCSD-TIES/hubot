API_KEY = 'key-8w2x33l2xsi8soop6l2wl3fdyw6fnfr0'
API_URL = 'https://api.mailgun.net/v2'

mailgun = new Mailgun(API_KEY)


module.exports = (robot) ->
  robot.respond /send all (.*)$/i, (message) ->
    mailgun.sendText('lewis.f.chung@gmail.com',
         ['lewis.f.chung@gmail.com'],
         'Behold the wonderous power of email!',
         {},
         function(err) { err && console.log(err) });
    message.send("Gotcha!")