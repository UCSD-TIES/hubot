# My attempt to get Mailgun hooked up with hubot

Nodemailer = require 'nodemailer'

module.exports = (robot) ->
  robot.respond /send all (.*)$/i, (message) ->
    message.send "Okay."
    smtpTransport = Nodemailer.createTransport("SMTP",
      host: "smtp.mailgun.org"
      secureConnection: true
      port: 587
      auth:
        user: "postmaster@lewis.mailgun.org",
        pass: "2le7c33xsl53"
    )

    mailOptions =
      from: "InHaiti Hubot <postmaster@lewis.mailgun.org>"
      to: "lewis.f.chung@gmail.com"
      subject: "Testing"
      text: "Wow"
      html: "<b>Wow</b>"

    smtpTransport.sendMail mailOptions, (error, response) ->
      if error
        console.log error
      else
        console.log "Message sent: " + response.message
        message.send "Message sent: " + response.message
        return

