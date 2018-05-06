class Forum < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_many :reports

  def as_json
    {
      id: id,
      user_id: user_id,
      user: user.as_json,
      comment: comment
    }
  end

end
