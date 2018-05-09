class Forum < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_many :reports
  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "150x150#"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def as_json
    {
      id: id,
      user_id: user_id,
      user: user.as_json,
      comment: comment,
      created_at: friendly_created_at
    }
  end

  def friendly_created_at
    created_at.strftime("%b %e, %l:%M %p")
  end

end
