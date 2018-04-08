class Forum < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_many :reports
end
