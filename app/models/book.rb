class Book < ApplicationRecord
 
  with_options presence: true do
    validates :title
    validates :review
  end

  has_many   :comments, dependent: :destroy
  belongs_to :user
  has_one_attached :image
  
  def self.search(search)
    if search != ""
      Book.where('title LIKE(?)', "%#{search}%")
    else
      Book.all
    end
  end
end
