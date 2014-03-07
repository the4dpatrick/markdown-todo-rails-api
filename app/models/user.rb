class User < ActiveRecord::Base
  has_many :api_keys

  has_secure_password
  validate :password, presence: true
  validate :email, presence: true
end
