class Patience < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :memo,length: { maximum: 140 }
end
