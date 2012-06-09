# My attempt to get Mailgun hooked up with hubot

# Nodemailer = require 'nodemailer'
mail = require 'mailer'

module.exports = (robot) ->
  robot.respond /send all (.*)$/i, (message) ->

   # smtpTransport = Nodemailer.createTransport("SMTP",
   #   host: "smtp.mailgun.org"
   #   secureConnection: true
   #   port: 587
   #   auth:
   #     user: "postmaster@lewis.mailgun.org",
   #     pass: "2le7c33xsl53"
   # )

   # mailOptions =
   #   from: "InHaiti Hubot <postmaster@lewis.mailgun.org>"
   #   to: "lewis.f.chung@gmail.com"
   #   subject: "Testing"
   #   text: "Wow"
   #   html: "<b>Wow</b>"

   # smtpTransport.sendMail mailOptions, (error, response) ->
   #   if error
   #     console.log error
   #   else
   #     console.log "Message sent: " + response.message
   #     message.send "Message sent: " + response.message

    options = {
      host            : "smtp.mailgun.org"
      port            : 587
      ssl             : false
      domain          : "lewis.mailgun.org"
      authentication  : "login"
      username        : "hubot@lewis.mailgun.org"
      password        : "inhaitibot"
    }

    if (options.host)
      options.to = 'lewis.f.chung@gmail.com'
      options.from = 'lewis@lewis.mailgun.org'
      options.subject = "#{message.message.user.name} sent a message to inhaiti team"
      options.body = "#{message.match[1]}"

      mail.send options, (err, result) ->
        console.log err
        if (err)
          message.reply "Error :("
        else
          message.reply "Done!"


