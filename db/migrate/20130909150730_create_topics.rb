class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.integer :tweets_count
      t.timestamps
    end
  end
end
