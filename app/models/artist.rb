class Artist < ApplicationRecord
  has_many :songs
  has_many :setlists
  has_many :artist_events
  has_many :events, through: :artist_events
end
