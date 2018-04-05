class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :date
      t.string :artist
      t.string :venue
      t.string :city

      t.timestamps
    end
  end
end
