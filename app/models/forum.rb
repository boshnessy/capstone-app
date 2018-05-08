class Forum < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_many :reports

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
