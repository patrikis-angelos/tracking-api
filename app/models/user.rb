class User < ApplicationRecord
  has_secure_password
  has_many :measurements

  validates :name, presence: true, uniqueness: true
  validates :password_digest, presence: true
end
