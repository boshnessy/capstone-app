class Report < ApplicationRecord
  belongs_to :forum
  belongs_to :user
end
