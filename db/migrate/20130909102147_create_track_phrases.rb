class CreateTrackPhrases < ActiveRecord::Migration
  def change
    create_table :track_phrases do |t|
      t.text :text

      t.timestamps
    end
  end
end
