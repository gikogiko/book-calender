class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :ownerships
  has_many :books, through: :ownerships
  
  has_many :interestings
  has_many :interesting_books, through: :interestings, class_name: 'Book', source: :book

  def interesting(book)
    self.interestings.find_or_create_by(book_id: book.id)
  end
  
  def uninteresting(book)
    interesting = self.interestings.find_by(book_id: book.id)
    interesting.destroy if interesting
  end
  
  def interesting?(book)
    self.interesting_books.include?(book)
  end
end

