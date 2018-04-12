class Event < ApplicationRecord
  has_many :forums
  has_many :setlists
  has_many :images
  has_many :artist_events
  has_many :artists, through: :artist_events
end
