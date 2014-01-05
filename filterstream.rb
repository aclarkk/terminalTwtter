require_relative "gems"
require_relative "config"

client = Twitter::Streaming::Client.new do |config|
  config.consumer_key        = $consumer_key
  config.consumer_secret     = $consumer_secret 
  config.access_token        = $access_token
  config.access_token_secret = $access_token_secret
end

topics = ["html5", "css3"]
client.filter(:track => topics.join(",")) do |object|
    if object.is_a?(Twitter::Tweet)
      puts "#{ object.user.name} (@#{object.user.screen_name}): ".green
      puts "#{object.text}"
      
      #format date by parsing object.created_at
      date = DateTime.parse("#{object.created_at}")
      formatted_date = date.strftime('%a %b %d, %Y -  %H:%M ')
      puts formatted_date
   
      puts "#{object.url}".blue 
       #if object.is_a?(Twitter::Tweet)
      puts
    end
end
