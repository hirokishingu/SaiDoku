class User < ActiveRecord::Base
  has_many :articles, dependent: :destroy
  has_many :friendships
  has_many :friends, through: :friendships

  before_save { self.email = email.downcase }
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 30 }
  validates :email, presence: true, length: { maximum: 105 }, uniqueness: {case_sensitive: false }

  has_secure_password

  def not_friends_with?(friend_id)
    friendships.where(friend_id: friend_id).count < 1
  end

  def except_current_user(users)
    users.reject { |user| user.id == self.id }
  end



end