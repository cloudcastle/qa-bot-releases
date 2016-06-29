class Bot < SlackRubyBot::Bot

  match /Hi|Hello/ do |client, data|
    client.say(channel: data.channel, text: "Hi, boy!")
  end
end