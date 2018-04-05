class CreateForums < ActiveRecord::Migration[5.1]
  def change
    create_table :forums do |t|
      t.text :comment
      t.integer :user_id
      t.integer :event_id

      t.timestamps
    end
  end
end
