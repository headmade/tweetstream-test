class CreateTweets < ActiveRecord::Migration
  def change

    create_table :tweets do |t|
      t.timestamps
      t.string :tweet, null: false
      t.text   :raw,   null: false
    end

    create_table :tweet_hashtags do |t|
      t.integer :tweet_id,   null: false
      t.integer :hashtag_id, null: false
    end

  end
end
