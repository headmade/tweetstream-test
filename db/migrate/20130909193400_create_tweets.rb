class CreateTweets < ActiveRecord::Migration
  def change

    create_table :tweets do |t|
      t.timestamps
      t.string :tweet, null: false
      t.text   :raw,   null: false
    end

    add_index :tweets, :created_at

    create_table :tweet_hashtags do |t|
      t.integer :tweet_id,   null: false
      t.integer :hashtag_id, null: false
    end

    add_index :tweet_hashtags, :tweet_id
    add_index :tweet_hashtags, :hashtag_id

  end
end
