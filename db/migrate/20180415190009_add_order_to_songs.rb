class AddOrderToSongs < ActiveRecord::Migration[5.1]
  def change
    add_column :songs, :order, :integer
  end
end
