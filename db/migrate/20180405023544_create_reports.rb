class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.integer :forum_id
      t.integer :user_id
      t.string :reported_for
      t.string :status, default: "pending"

      t.timestamps
    end
  end
end
