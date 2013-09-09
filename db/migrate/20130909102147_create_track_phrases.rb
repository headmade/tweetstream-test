class CreateTrackPhrases < ActiveRecord::Migration
  def change
    create_table :track_phrases do |t|
      t.timestamps
      t.string :text, null: false, unique: true
    end
  end
end
