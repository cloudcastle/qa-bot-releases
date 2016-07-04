module BotHelpers
  def say_hi(user)
    if User.where(slack_id: user).exists?
      text = "Come home boy <@#{data[:user]}>!:tada:"
    else
      User.create!(slack_id: user)
      text = "Nice to meet to <@#{user}> for very first time!:tada:"
    end
    text
  end
end