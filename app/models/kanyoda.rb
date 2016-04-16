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
    original = self.get_tweet
    if original == @@last_tweet
      original = self.get_tweet(rand(1...20)) 
    else
      @@last_tweet = original
    end 
    clean_tweet = self.clean_up_tweet(original)
    new_tweet = self.yodaize(clean_tweet)
    if self.tweet_ok?(new_tweet, clean_tweet)
      return new_tweet
    else
      return self.make_tweet
    end
  end

  def self.tweet_ok?(tweet, original)
    (tweet == original || tweet.match(/<!DOCTYPE html>.*/)) ? false : true
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
    resp = HTTParty.get("https://yoda.p.mashape.com/yoda?sentence=#{sentence}", headers:{ 'X-Mashape-Key' => ENV['MASHAPE_KEY']})
    return resp.parsed_response
  end

  
end

