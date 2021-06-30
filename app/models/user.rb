class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :email,presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
  validates :email,uniqueness: {case_sensitive: true}
end
