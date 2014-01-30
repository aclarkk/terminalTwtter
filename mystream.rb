require_relative "config"

client = Twitter::Streaming::Client.new do |config|
  config.consumer_key        = $consumer_key
  config.consumer_secret     = $consumer_secret 
  config.access_token        = $access_token
  config.access_token_secret = $access_token_secret
end
begin
  client.user do |object|
    case object
    when Twitter::Tweet
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
    when Twitter::Streaming::StallWarning
      warn "Falling behind!"
    end
  end
rescue Interrupt
    puts
    puts "\n Exiting Script - Goodbye =("
    puts
rescue Exception => e
    puts e
end
