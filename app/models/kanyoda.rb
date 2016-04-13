require 'unirest'

class Kanyoda < ActiveRecord::Base
  include ApplicationHelper

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
    sentence = new_string.gsub! /\s+/, '%20'
    p sentence
    resp = HTTParty.get("http://api.funtranslations.com/translate/yoda.json?text=#{sentence}.", headers:{ 'X-FunTranslations-Api-Secret' => ENV['FUNTRANSLATION_KEY']})
    return resp
  end



end

