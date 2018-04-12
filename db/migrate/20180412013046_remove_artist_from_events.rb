class RemoveArtistFromEvents < ActiveRecord::Migration[5.1]
  def change
    remove_column :events, :artist, :string
  end
end
