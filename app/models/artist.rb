class Artist < ApplicationRecord
  has_many :songs
  has_many :setlists
  has_many :images
  has_many :artist_events
  has_many :events, through: :artist_events

  def as_json
    {
      id: id,
      name: name
    }
  end
end
