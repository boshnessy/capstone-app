class AddArtistIdToSetlist < ActiveRecord::Migration[5.1]
  def change
    add_column :setlists, :artist_id, :integer
  end
end
