class CreateArtistEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :artist_events do |t|
      t.integer :artist_id
      t.integer :event_id

      t.timestamps
    end
  end
end
