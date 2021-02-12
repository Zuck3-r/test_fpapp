class Customer < ApplicationRecord
  has_many :reservations
  
  #それぞれのデータへのバリデーション
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 40 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, {presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }, length: { maximum: 255 }}
  
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
    def no_4_bytes
      if name.present?
        chars = name.each_char.select{|c| c.bytes.count >= 4}
        if chars.size > 0
          errors.add(:name, "に絵文字(#{chars.join('')})は使用できません。")
        end
      end
    end
end
