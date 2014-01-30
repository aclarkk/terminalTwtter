require_relative "config"

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = $consumer_key
  config.consumer_secret     = $consumer_secret 
  config.access_token        = $access_token
  config.access_token_secret = $access_token_secret
end

# get new tweet from a bash argument
newTweet = ARGV[0]

puts "tweeting '#{newTweet}' now. "
# client.update("#{newTweet} -- ");

puts "all done, goodbye."
exit
