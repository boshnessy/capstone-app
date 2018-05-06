class Setlist < ApplicationRecord
  belongs_to :event
  belongs_to :artist
  has_many :setlist_songs
  has_many :songs, through: :setlist_songs

  def as_json
    {
      id: id,
      songs: songs.as_json
    }
  end
end
