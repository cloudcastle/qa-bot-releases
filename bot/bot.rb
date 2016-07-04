require 'open-uri'
require 'slack-ruby-bot'

class QABot < SlackRubyBot::Bot
 # help do
 #   title 'QA Bot'
 #   desc 'This bot will notify you about updates of yur favorite tools'

 #   command 'Show me all resources' do
 #     desc "SHow you list of avaliable resources"
 #   end

 #   command "Add <resource_name> on <resource_url> by scheme <scheme_type>" do
 #     desc "Bot will add new resource to data base with name <resource_name> and url <resource_url> and scheme <scheme_type>"
 #     long_desc "<resource_name> is uniq\n<resource_url> - url to resource (please use raw in case of git)\n<scheme_type> - now avaliable only changelog typ"
 #   end
 # end

  command 'Show me all resources' do |client, data|
    client.say(channel: data.channel, text: "*Here is the list of known resources:*\n#{(Resource.all.collect { |r| ":small_orange_diamond: #{r.name.titleize}" }).join("\n")}" )
  end

  match /Add (?<name>\w*) on (?<source>\w*.*) by scheme (?<scheme_type>\w*)/ do |client, data, match|
    begin
      Resource.create!(name:match[:name],
                       source: match[:name].delete('<').delete('>'),
                       current: open(match[:source].delete('<').delete('>')).read,
                       scheme_type: match[:scheme_type])
    rescue => e
      text = "*#{match[:name].titleize}* is not saved!:vot_eto_povorot: because of \n```#{e}```"
    else
      text = "*#{match[:name].titleize}* is saved!:ok_hand:"
    ensure
      client.say(channel: data.channel, text: text)
    end
  end
end