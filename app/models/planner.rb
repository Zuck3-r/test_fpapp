class Planner < ApplicationRecord
  #保存する前に小文字化
  before_save { self.email = email.downcase }
  
  
  validates :name, presence: true, length: { maximum: 40 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, {presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }, length: { maximum: 255 }}
  
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
