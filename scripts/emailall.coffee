# My attempt to get Mailgun hooked up with hubot

# Nodemailer = require 'nodemailer'
mail = require 'mailer'

module.exports = (robot) ->
  robot.respond /send all (.*)$/i, (message) ->

   #smtpTransport = Nodemailer.createTransport("SMTP",
   #  host: "smtp.mailgun.org"
   #  secureConnection: false
   #  port: 587
   #  auth:
   #    user: "hubot@lewis.mailgun.org",
   #    pass: "inhaitibot"
   #)
   #mailOptions =
   # from: "InHaiti Hubot <hubot@lewis.mailgun.org>"
   #  to: "lewis.f.chung@gmail.com"
   #  subject: "#{message.message.user.name} sent everyone a message"
   #  text:"Hello, #{message.message.user.name} just sent everyone this notice message. #{message.message.user.name}: #{message.match[1]}"
   #  html:"<p>Hello, #{message.message.user.name} just sent everyone this notice message.</p><p><b>#{message.message.user.name}:</b> #{message.match[1]}</p>"

   #smtpTransport.sendMail mailOptions, (error, response) ->
   #  if error
   #    console.log error
   #  else
   #    console.log "Message sent: " + response.message
   #    message.send "Message sent: " + response.message

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
     #options.to = 'team@lewis.mailgun.org'
     options.to = 'lewis.f.chung@gmail.com'
     options.from = 'Hipchat Hubot <lewis@lewis.mailgun.org>'
     options.subject = "#{message.message.user.name} sent everyone a notice message."
     options.html = "<p>Hi #{message.message.user.name.split(" ")[0]},</p> <p>#{message.message.user.name} just sent everyone this notice message.</p><p><b>#{message.message.user.name.split(" ")[0]} #{message.message.user.name.split(" ")[1][0]}:</b> #{message.match[1]}</p>"
     mail.send options, (err, result) ->
       if (err)
         console.log err
         message.reply "Error :("
       else
         console.log result
         message.reply "Done!"


