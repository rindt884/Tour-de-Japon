class Post < ApplicationRecord
    
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  
  has_one_attached :images
  has_many_attached :main_images
  belongs_to :customer
    
end
