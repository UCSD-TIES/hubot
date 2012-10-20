# My attempt to get Mailgun hooked up with hubot

nodemailer = require("nodemailer")

module.exports = (robot) ->

  robot.respond /send all (.*)$/i, (msg) ->
    transport = nodemailer.createTransport("SMTP", {
      host: process.env.MAILGUN_SMTP_SERVER
      port: process.env.MAILGUN_SMTP_PORT
      secureConnection: false
      name: 'wehaveweneed.mailgun.org'
      auth: {
          user:     process.env.MAILGUN_SMTP_LOGIN
          pass:     process.env.MAILGUN_SMTP_PASSWORD
      }
      debug: true
    })

    console.log process.env.MAILGUN_SMTP_SERVER
    console.log process.env.MAILGUN_SMTP_PORT
    console.log process.env.MAILGUN_SMTP_LOGIN
    console.log process.env.MAILGUN_SMTP_PASSWORD

    message = {
      from: 'WeHaveWeNeed Hubot <postmaster@wehaveweneed.mailgun.org>'
      to: 'team@wehaveweneed.mailgun.org'
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
