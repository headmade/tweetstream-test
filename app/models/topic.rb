class Topic < ActiveRecord::Base
  has_many :hashtags_topics
  has_many :hashtags, through: :hashtags_topics
  has_many :tweets, through: :hashtags
end
