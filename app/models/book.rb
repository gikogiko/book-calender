class Book < ApplicationRecord
  validates :isbn, presence: true, length: { maximum: 255 }
  validates :name, presence: true, length: { maximum: 255 }
  validates :author, presence: true, length: { maximum: 255 }
  validates :value, numericality: true
  validates :url, presence: true, length: { maximum: 255 }
  validates :image_url, presence: true, length: { maximum: 255 }
  
  has_many :ownerships
  has_many :books, through: :ownerships
  
  has_many :interestings
  has_many :interesting_users, through: :interestings, class_name: 'User', source: :user
end
