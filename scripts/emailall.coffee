# My attempt to get Mailgun hooked up with hubot

# nodemailer = require("nodemailer")
# 
# module.exports = (robot) ->
# 
#   robot.respond /send all (.*)$/i, (message) ->
#     transport = nodemailer.createTransport("SMTP", {
#       host: process.env.MAILGUN_SMTP_SERVER or "smtp.mailgun.org"
#       port: process.env.MAILGUN_SMTP_PORT or 587
#       secureConnection: false
#       auth: {
#           user:     process.env.MAILGUN_SMTP_LOGIN or "hubot@wehaveweneed.mailgun.org"
#           password: process.env.MAILGUN_SMTP_PASSWORD or "inhaiti2012"
#       }
#     })
# 
#     mess = {
#       from: 'Hipchat Hubot <hubot@wehaveweneed.mailgun.org>'
#       to: 'team@lewis.mailgun.org'
#       subject: "#{message.message.user.name} sent everyone a notice message."
#       html: "<p>Hi #{message.message.user.name.split(" ")[0]},</p> <p><a href='https://www.hipchat.com/members/#{message.message.user.id}'>#{message.message.user.name}</a> just sent everyone this notice message.</p><p><b>#{message.message.user.name.split(" ")[0]} #{message.message.user.name.split(" ")[1][0]}:</b> #{message.match[1]}</p>"
#       text: "Hi #{message.message.user.name.split(" ")[0]}, #{message.message.user.name} just sent everyone this notice message. #{message.message.user.name.split(" ")[0]} #{message.message.user.name.split(" ")[1][0]}: #{message.match[1]}"
#     }
# 
#     console.log('Sending Mail')
# 
#     transport.sendMail(mess, (error) ->
#       if error
#         console.log 'Error occured'
#         console.log error.message
#         message.send 'Error occured: ' + error.message
#         return
#       console.log 'Message sent successfully!'
#       message.send 'Message sent successfully!'
#     )

Mailgun = require("mailgun").Mailgun

mg = new Mailgun(process.env.MAILGUN_API_KEY)
console.log "Created Mailgun instance: " + mg

module.exports = (robot) ->
  
  robot.respond /send all (.*)/i, (message) ->
    
    mg.sendRaw('hubot@wehaveweneed.mailgun.org',
            'team@lewis.mailgun.org',
            'From: Hipchat Hubot <hubot@wehaveweneed.mailgun.org>' +
              '\nTo: ' + 'team@lewis.mailgun.org' +
              '\nContent-Type: text/html; charset=utf-8' +
              '\nSubject: ' + '#{message.message.user.name} sent everyone a message.' +
              '\n\n<p>Hi #{message.message.user.name.split(" ")[0]},</p> <p><a href="https://www.hipchat.com/members/#{message.message.user.id}">#{message.message.user.name}</a> just sent everyone this notice message.</p><p><b>#{message.message.user.name.split(" ")[0]} #{message.message.user.name.split(" ")[1][0]}:</b> #{message.match[1]}</p>',
              'wehaveweneed.mailgun.org',
              (err) ->
                message.send 'Error occured: ' + err
                return
          )
