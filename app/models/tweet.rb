class Tweet < ActiveRecord::Base

  def self.count_for_last(seconds)
     self.where( "created_at > NOW() + INTERVAL '? seconds'", Time.now.utc_offset() - seconds ).count
  end
end
