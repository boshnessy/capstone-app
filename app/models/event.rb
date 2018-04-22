class Event < ApplicationRecord
  has_many :forums
  has_many :setlists
  has_many :images
  has_many :artist_events
  has_many :artists, through: :artist_events

  def as_json
    {
      date: date,
      venue: venue,
      city: city,
      state: state,
      artists: artists.as_json,
      forums: forums.as_json,
      setlists: setlists.as_json,
      images: images
    }
  end
end
