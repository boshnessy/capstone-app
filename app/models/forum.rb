class Forum < ApplicationRecord
  has_attached_file :image
  belongs_to :event
  belongs_to :user
  has_many :reports
  validates_attachment :image,
    content_type: {
      content_type: ["image/jpeg", "image/gif", "image/png"]
    }

  def as_json
    {
      id: id,
      user_id: user_id,
      user: user.as_json,
      comment: comment,
      created_at: friendly_created_at,
      image: image
    }
  end

  def friendly_created_at
    created_at.strftime("%b %e, %l:%M %p")
  end

end
