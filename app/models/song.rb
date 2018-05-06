class Song < ApplicationRecord
  belongs_to :artist
  has_many :setlist_songs
  has_many :setlists, through: :setlist_songs

  def as_json
    {
      id: id,
      title: title
    }
  end

end
