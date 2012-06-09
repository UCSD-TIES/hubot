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
      ssl             : true
      domain          : "lewis.mailgun.org"
      authentication  : "login"
      username        : "postmaster@lewis.mailgun.org"
      password        : "2le7c33xsl53"
    }

    if (options.host)
      options.to = 'lewis.f.chung@gmail.com'
      options.from = 'postmaster@lewis.mailgun.org'
      options.subject = "Testing this"
      options.body = "Testing this."

      mail.send options, (err, result) ->
        console.log err
        if (err)
          message.reply "Error :("
        else
          message.reply "Done!"


