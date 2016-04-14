$twitter = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV['CONSUMER_KEY']
  p "consumer_key: #{config.consumer_key}"
  config.consumer_secret = ENV['CONSUMER_SECRET']
  p "consumer_secret: #{config.consumer_secret}"
  config.access_token = ENV['ACCESS_TOKEN']
  p "access_token: #{config.access_token}"
  config.access_token_secret = ENV['ACCESS_SECRET']
  p "access_token_secret #{config.access_token_secret}"
end

