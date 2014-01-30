require_relative "config"

client = Twitter::Streaming::Client.new do |config|
  config.consumer_key        = $consumer_key
  config.consumer_secret     = $consumer_secret 
  config.access_token        = $access_token
  config.access_token_secret = $access_token_secret
end

# store all arguments in a single variable
tweetArray = ARGV[0].split " "

# puts all arguments, seperated by a comma
puts tweetArray.join "',"

tweetSearch = tweetArray.join ","

topics = [tweetSearch]
begin
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
  rescue Interrupt
    puts
    puts "\n Exiting Script - Goodbye =("
    puts
  rescue Exception => e
    puts e
end
