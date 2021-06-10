class Review < ApplicationRecord
  belongs_to :customer
  belongs_to :restaurant
  
  validates :score, presence:true
end
