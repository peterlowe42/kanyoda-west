desc "This task is called by the Heroku scheduler add-on"

task :post_tweet => :environment do
  puts "Sending feed..."
  Kanyoda.tweet
  puts "done."
end