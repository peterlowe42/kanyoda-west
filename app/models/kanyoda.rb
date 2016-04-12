class Kanyoda < ActiveRecord::Base
  include ApplicationHelper

  def self.get_tweet(rand=nil)
    tweet = $twitter.user_timeline("kanyewest").first.text
    return tweet 
  end

  def self.yodaize(tweet)
    split_tweet = tweet.split(' ')
    sentence = split_tweet.join('+')
    url = "https://yoda.p.mashape.com/yoda?sentence=" + sentence
    yoda_tweet = Unirest.get url, headers:{
      "X-Mashape-Key" => "gYgNoRwAphmshSspZHwOnOXJteTSp1sEn1JjsnHBnhXml6bCNu",
      "Accept" => "text/plain"
    }
    return yoda_tweet
  end



end
