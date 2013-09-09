class CreateHashtags < ActiveRecord::Migration
  def change
    create_table :hashtags do |t|
      t.timestamps
      t.string :text, null: false, unique: true
    end
  end
end
