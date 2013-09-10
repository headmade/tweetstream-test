class CreateJoinTableTopicHashtag < ActiveRecord::Migration
  def change
    create_join_table :topics, :hashtags do |t|
      t.index :topic_id, primary: true
      # t.index [:hashtag_id, :topic_id]
    end
  end
end
