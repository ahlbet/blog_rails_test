class Post < ApplicationRecord
  validates :name, presence: true
  validates :title, presence: true
  validates :content, presence: true
  
  belongs_to :user

  has_many :posts_categories
  has_many :categories, :through => :posts_categories

  accepts_nested_attributes_for :categories

end
