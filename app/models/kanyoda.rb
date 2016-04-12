class Kanyoda < ActiveRecord::Base

  def self.get_tweet
    tweet = $twitter.user_timeline("kanyewest").first.text
    return tweet 
  end

end
