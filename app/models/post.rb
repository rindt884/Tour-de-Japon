class Post < ApplicationRecord
    
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  has_many :favorites, dependent: :destroy
  has_many_attached :images
  belongs_to :customer
  has_many :comments, dependent: :destroy
  
  validates :images, :prefecture_id, :title, :body, :rideday, :mileage, :runtime, presence: true
  validate :images_length
  
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end
  
  private
  
  def images_length
    if images.length > 4
      errors.add(:images, "は4枚以内にしてください")
    end
  end
    
end
