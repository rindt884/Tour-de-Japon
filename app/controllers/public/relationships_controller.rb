class Public::RelationshipsController < ApplicationController
  
  before_action :authenticate_customer!
    
    # フォローするとき
  def create
    current_customer.follow(params[:customer_id])
    @customer = Customer.find(params[:customer_id])
    # redirect_to request.referer
  end
  # フォロー外すとき
  def destroy
    current_customer.unfollow(params[:customer_id])
    @customer = Customer.find(params[:customer_id])
  end
  # フォロー一覧
  def followings
    customer = Customer.find(params[:customer_id])
    @customers = customer.followings.order(created_at: :desc).page(params[:page])
  end
  # フォロワー一覧
  def followers
    customer = Customer.find(params[:customer_id])
    @customers = customer.followers.order(created_at: :desc).page(params[:page])
  end
    
end
