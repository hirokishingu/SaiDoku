class Article < ActiveRecord::Base
  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories
  validates :title, presence: true, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 120 }
  validates :user_id, presence: true

end