class Setlist < ApplicationRecord
  belongs_to :event
  belongs_to :artist
  has_many :setlist_songs
  has_many :songs, through: :setlist_songs
end