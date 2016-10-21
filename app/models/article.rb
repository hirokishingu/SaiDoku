class Article < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 120 }


end