class CreateSetlists < ActiveRecord::Migration[5.1]
  def change
    create_table :setlists do |t|
      t.integer :event_id

      t.timestamps
    end
  end
end
