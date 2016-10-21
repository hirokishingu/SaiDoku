class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 30 }
  validates :email, presence: true, length: { maximum: 105 }, uniqueness: {case_sensitive: false }

  has_secure_password
end