class UsersController < ApplicationController
  def say_hi_to(user)
    user = user.delete('<').delete('>').delete('@')
    if User.where(slack_id: user).exists?
      text = "Welcome home boy <@#{user}>!:tada:"
    else
      User.create!(slack_id: user)
      text = "Nice to meet to <@#{user}> for very first time!:tada:"
    end
    text
  end
  def subscribe_user(user, resource)
    if User.where(slack_id: user).exists?
      if Resource.where(name: resource).exists?
        u = User.where(slack_id: user).first
        u.resources_ids << Resource.where(name: resource).first.id
        u.resources_ids.uniq!
        if u.save
          [{
               color: "#36a64f",
               title: "You are subscribed on:",
               text: (User.where(slack_id: user).first.resources_ids.collect { |s| Resource.find(s).name }).join("\n")
           }]
        end
      else
        [{ color: "#f50000",
           title: "Resource #{resource} doesn't exists!" }]
      end
    else
      [{ color: "#f50000",
         title: "User #{user} doesn't exists!" }]
    end
  end
  def unsubscribe_user(user, resource)
    if User.where(slack_id: user).exists?
      u = User.where(slack_id: user).first
      if Resource.where(name: resource).first.exists? && u.resources_ids.include?(Resource.where(name: resource).first.id)
        u.resources_ids = u.resources_ids - [Resource.where(name: resource).first.id]
        if u.save
          s = User.where(slack_id: user).first.resources_ids.collect { |s| Resource.find(s).name }
          if s.empty?
            [{ color: "#f50000",
               title: "You haven't subscribes"
             }]
          else
            [{ color: "#36a64f",
               title: "You are subscribed on:",
               text: s.join("\n")
             }]
          end
        end
      else
        [{ color: "#f50000",
           title: "Resource doesn't exists or you're not subscribed on the resource"
         }]
      end
    else
      [{ color: "#f50000",
         title: "User #{user} doesn't exists!"
       }]
    end
  end
  def show_all_users
    [{ color: "#36a64f",
       title: "Users list",
       text: (User.all.collect { |u| "<@#{u.slack_id}> #{u.slack_id}" }).join("\n")
     }]
  end
  def show_subscribes(user)
    if User.where(slack_id: user).exists?
      s = User.where(slack_id: user).first.resources_ids.collect { |s| Resource.find(s).name }
      if s.empty?
        [{ color: "#f50000",
           title: "You haven't subscribes"
         }]
      else
        [{ color: "#36a64f",
           title: "Here is a list of your subscribes",
           text: s.join("\n")
         }]
      end
    end
  end
end
