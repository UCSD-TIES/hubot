# My attempt to get Mailgun hooked up with hubot

nodemailer = require("nodemailer")

module.exports = (robot) ->

  robot.respond /send all (.*)$/i, (msg) ->
    transport = nodemailer.createTransport("SMTP", {
      host: 'smtp.sendgrid.net'
      port: process.env.MAILGUN_SMTP_PORT or 587
      secureConnection: false
      auth: {
          user:     process.env.SENDGRID_USERNAME
          password: process.env.SENDGRID_PASSWORD
      }
      debug: true
    })

    message = {
      from: 'Hipchat Hubot <hubot@wehaveweneed.mailgun.org>'
      to: 'team@lewis.mailgun.org'
      subject: "#{msg.message.user.name} sent everyone a notice message."
      html: "<p>Hi #{msg.message.user.name.split(" ")[0]},</p> <p><a href='https://www.hipchat.com/members/#{msg.message.user.id}'>#{msg.message.user.name}</a> just sent everyone this notice message.</p><p><b>#{msg.message.user.name.split(" ")[0]} #{msg.message.user.name.split(" ")[1][0]}:</b> #{msg.match[1]}</p>"
      text: "Hi #{msg.message.user.name.split(" ")[0]}, #{msg.message.user.name} just sent everyone this notice message. #{msg.message.user.name.split(" ")[0]} #{msg.message.user.name.split(" ")[1][0]}: #{msg.match[1]}"
    }

    console.log('Sending Mail')

    transport.sendMail(message, (error) ->
      if error
        console.log 'Error occured'
        console.log error.message
        msg.send 'Error occured: ' + error.message
        return
      else 
        console.log 'Message sent successfully!'
        msg.send 'Message sent successfully!'
    )
