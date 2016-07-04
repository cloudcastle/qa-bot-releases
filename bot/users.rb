require 'slack-ruby-bot'

class QABot < SlackRubyBot::Bot
 # help do
 #   command 'Hi or Hello' do
 #     desc "Bot will say you hi and add you to database if you don't exist"
 #   end

#    command "Say hi to <user>" do
#      desc "Bot will say hi to <user> and add <user> to database if <user> doesn't exists"
#    end
#  end

  match /Hi|Hello/ do |client, data|
   client.say(channel: data.channel, text: UsersController.new.say_hi_to(data[:user]))
  end

  match /Say hi to (?<user>.*)/ do |client, data, match|
   client.say(channel: data.channel, text: UsersController.new.say_hi_to(match[:user]))
  end

  match /Subscribe me on (?<resource>.*)/ do |client, data, match|
    client.web_client.chat_postMessage(
        channel: data.channel,
        as_user: true,
        attachments: UsersController.new.subscribe_user(data[:user], match[:resource])
    )
  end

  match /Unsubscribe me from (?<resource>.*)/ do |client, data, match|
    client.web_client.chat_postMessage(
        channel: data.channel,
        as_user: true,
        attachments: UsersController.new.unsubscribe_user(data[:user], match[:resource])
    )
  end

  command 'Show me all users' do |client, data|
    client.web_client.chat_postMessage(
        channel: data.channel,
        as_user: true,
        attachments: UsersController.new.show_all_users
    )
  end

  command 'Show my subscribes' do |client, data|
    client.web_client.chat_postMessage(
        channel: data.channel,
        as_user: true,
        attachments: UsersController.new.show_subscribes(data[:user])
    )
  end
end