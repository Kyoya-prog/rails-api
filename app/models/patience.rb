class Patience < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :description,length: { maximum: 140 }
end
