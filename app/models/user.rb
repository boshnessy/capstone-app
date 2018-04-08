class User < ApplicationRecord
  has_many :reports
  has_many :forums
  has_secure_password
  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
end
