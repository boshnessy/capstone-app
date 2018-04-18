class RenameSongToTitle < ActiveRecord::Migration[5.1]
  def change
    rename_column :songs, :song, :title
  end
end
