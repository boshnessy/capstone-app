class User < ApplicationRecord
  has_attached_file :image, default_url: "img/user/unknown.jpg"
  has_many :reports
  has_many :forums
  has_secure_password
  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  validates_attachment :image,
    content_type: {
      content_type: ["image/jpeg", "image/gif", "image/png"]
    }

  def as_json
    {
      id: id,
      username: username,
      email: email,
      image: image
    }
  end

end
