class Public::PostsController < ApplicationController
    
    def new
      @post = Post.new
    end
    
    def index
      @posts = Post.all
      @today = Date.today #今日の日付を取得
      @now = Time.now     #現在時刻を取得
    end
    
    def show
      @post = Post.find(params[:id])
    end
    
    def edit
    end
    
    def create
      @post = Post.new(post_params)
      @post.customer_id = current_customer.id
      @post.save
      redirect_to public_post_path(@post)
    end
    
    def destroy
    end
    
    def update
    end
    
    private
    
    def post_params
      params.require(:post).permit(:customer_id, :title, :body, :rideday, :runtime, :mileage, :prefecture_id, images: [])
    end
    
end
