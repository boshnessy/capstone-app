class Image < ApplicationRecord
  has_attached_file :image
  belongs_to :artist
  belongs_to :event
    
  validates_attachment :image,
    content_type: {
      content_type: ["image/jpeg", "image/gif", "image/png"]
    }
    
end
