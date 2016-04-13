class Kanyoda < ActiveRecord::Base
  include ApplicationHelper
  attr_accessor :last_tweet

  @@last_tweet = nil


  def self.tweet
    tweet = self.make_tweet
    $twitter.update(tweet)
  end

private

  def self.make_tweet
    origional = self.get_tweet
    if origional == @@last_tweet
      origional = self.get_tweet(rand(0..20)) 
    else
      @@last_tweet = origional
    end 
    clean_tweet = self.clean_up_tweet(origional)
    return self.yodaize(clean_tweet)
  end

  def self.clean_up_tweet(tweet)
    new_tweet = tweet.dup
    # remove non ASCII
    new_tweet.gsub!(/\P{ASCII}/, '')
    # revmove image urls 
    new_tweet.gsub!(/https.*/, '')

    return new_tweet
  end


  def self.get_tweet(rand=nil)
    if rand.nil?
      tweet = $twitter.user_timeline("kanyewest").first.text
    else
      tweet = $twitter.user_timeline("kanyewest")[rand].text
    end
    return tweet 
  end


  def self.yodaize(tweet)
    new_string = tweet.dup
    sentence = new_string.gsub! /\s+/, '+'
    p sentence
    resp = HTTParty.get("https://yoda.p.mashape.com/yoda?sentence=#{sentence}", headers:{ 'X-Mashape-Key' => ENV['MASHAPE_KEY']})
    return resp.parsed_response
  end

  
end

# All respect prayers and love to Phife’s family    Thank you for so much inspiration