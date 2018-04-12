class Image < ApplicationRecord
  belongs_to :artist
  belongs_to :event
end
