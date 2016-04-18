class Kanyoda < ActiveRecord::Base
  include ApplicationHelper
  attr_accessor :last_tweet

  def self.tweet
    tweet = self.make_tweet
    $twitter.update(tweet)
  end

private

  def self.make_tweet
    original = self.get_tweet
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


  def self.get_tweet
      hour_ago = (Time.now.utc) - 1.hours
      tweet = $twitter.user_timeline("kanyewest").first
      if tweet.created_at < hour_ago 
        tweet = $twitter.user_timeline("kanyewest",{count: 200, include_rts: true})[rand(1...200)]
      end 
    return tweet.text
  end


  def self.yodaize(tweet)
    new_string = tweet.dup
    sentence = new_string.gsub! /\s+/, '+'
    resp = HTTParty.get("https://yoda.p.mashape.com/yoda?sentence=#{sentence}", headers:{ 'X-Mashape-Key' => ENV['MASHAPE_KEY']})
    return resp.parsed_response
  end

  
end

