class Admin::PostsController < ApplicationController
  
  before_action :authenticate_admin!
    
  def index
    @posts = Post.all.page(params[:page])
  end
  
  def show
    @post = Post.find(params[:id])
    @today = Date.today #今日の日付を取得
    @now = Time.now     #現在時刻を取得
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:alert] = "削除しました"
    redirect_to admin_posts_path
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to admin_post_path(@post)
    else
      render :edit
    end
  end
  
  private
  
  def post_params
    params.require(:post).permit(:customer_id, :title, :body, :rideday, :runtime, :mileage, :prefecture_id, :profile_image, images: [])
  end
  
end
