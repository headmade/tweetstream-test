class TweetHashtag < ActiveRecord::Base
  self.primary_key = :hashtag_id
  belongs_to :tweet
  belongs_to :hashtag
end
