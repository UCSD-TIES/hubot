# My attempt to get Mailgun hooked up with hubot

nodemailer = require("nodemailer")

module.exports = (robot) ->

  robot.respond /send all (.*)$/i, (message) ->
    @transport = nodemailer.createTransport("SMTP", {
      host: process.env.MAILGUN_SMTP_SERVER
      port: process.env.MAILGUN_SMTP_PORT
      secureConnection: false
      auth: {
          user:     process.env.MAILGUN_SMTP_LOGIN
          password: process.env.MAILGUN_SMTP_PASSWORD
      }
    })

    @mess = {
      from: 'Hipchat Hubot <hubot@wehaveweneed.mailgun.org>'
      to: 'team@lewis.mailgun.org'
      subject: "#{message.message.user.name} sent everyone a notice message."
      html: "<p>Hi #{message.message.user.name.split(" ")[0]},</p> <p><a href='https://www.hipchat.com/members/#{message.message.user.id}'>#{message.message.user.name}</a> just sent everyone this notice message.</p><p><b>#{message.message.user.name.split(" ")[0]} #{message.message.user.name.split(" ")[1][0]}:</b> #{message.match[1]}</p>"
      text: "Hi #{message.message.user.name.split(" ")[0]}, #{message.message.user.name} just sent everyone this notice message. #{message.message.user.name.split(" ")[0]} #{message.message.user.name.split(" ")[1][0]}: #{message.match[1]}"
    }

    console.log('Sending Mail')

    @transport.sendMail(@mess, (error) ->
      if error
        console.log 'Error occured'
        console.log error.message
        message.send 'Error occured: ' + error.message
        return
      console.log 'Message sent successfully!'
      message.send 'Message sent successfully!'
    )
