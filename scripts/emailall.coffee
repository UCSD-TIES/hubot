# My attempt to get Mailgun hooked up with hubot

mail = require 'mailer'

module.exports = (robot) ->
  robot.respond /send all (.*)$/i, (message) ->

  options = {
    host            : "smtp.mailgun.org"
    port            : 587
    ssl             : false
    domain          : "lewis.mailgun.org"
    authentication  : "login"
    username        : "hubot@wehaveweneed.mailgun.org"
    password        : "inhaitihubot"
  }

  if (options.host)
    options.to = 'team@lewis.mailgun.org'
    options.from = 'Hipchat Hubot <hubot@wehaveweneed.mailgun.org>'
    options.subject = "#{message.message.user.name} sent everyone a notice message."
    options.html = "<p>Hi #{message.message.user.name.split(" ")[0]},</p> <p><a href='https://www.hipchat.com/members/#{message.message.user.id}'>#{message.message.user.name}</a> just sent everyone this notice message.</p><p><b>#{message.message.user.name.split(" ")[0]} #{message.message.user.name.split(" ")[1][0]}:</b> #{message.match[1]}</p>"
    mail.send options, (err, result) ->
      if (err)
        console.log err
        message.reply "Error :("
      else
        console.log result
        message.reply "Done!"
