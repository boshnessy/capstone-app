class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :url
      t.integer :artist_id
      t.integer :event_id

      t.timestamps
    end
  end
end
