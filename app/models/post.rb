class Post < ApplicationRecord
    
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  
  has_many_attached :image
  belongs_to :customer
    
end
