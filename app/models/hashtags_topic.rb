class HashtagsTopic < ActiveRecord::Base
  self.primary_key = :topic_id
  belongs_to :topic
  belongs_to :hashtag
end
