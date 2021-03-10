class Book < ApplicationRecord
 
  with_options presence: true do
    validates :title
    validates :review
  end

  has_many   :comments
  belongs_to :user
  has_one_attached :image
  
end
