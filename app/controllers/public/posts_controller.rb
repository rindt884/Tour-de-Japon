class Public::PostsController < ApplicationController
  
    before_action :authenticate_customer!
    before_action :correct_customer, only: [:edit, :update, :destroy, :create
    ]
    
    def new
      @post = Post.new
    end
    
    def index
      @posts = Post.where.not(customer_id: [current_customer.id]).order(created_at: :desc).page(params[:page])
      @today = Date.today #今日の日付を取得
      @now = Time.now     #現在時刻を取得
    end
    
    def show
      @post = Post.find(params[:id])
      @customer = current_customer
      @comment = Comment.new
      @comments = Comment.all
      @today = Date.today #今日の日付を取得
      @now = Time.now     #現在時刻を取得
    end
    
    def edit
      @post = Post.find(params[:id])
    end
    
    def create
      @post = Post.new(post_params)
      @post.customer_id = current_customer.id
      if @post.save
        flash[:notice] = "投稿しました！"
        redirect_to public_post_path(@post)
      else
        render :new
      end
    end
    
    def destroy
      @post = Post.find(params[:id])
      @post.destroy
      flash[:alert] = "削除しました"
      redirect_to public_posts_path
    end
    
    def update
      @post = Post.find(params[:id])
      if @post.update(post_params)
        flash[:notice] = "更新しました！"
        redirect_to public_post_path(@post)
      else
        render :edit
      end
    end
    
    def search
      @posts = Post.all
      if params[:keyword].present?
        @posts = @posts.where('title LIKE (?) OR body LIKE (?)', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
        @keyword = params[:keyword]
      else
        @posts = @posts.where(prefecture_id: params[:prefecture_id])
      end
      @posts = @posts.order(created_at: :desc).page(params[:page])
      @today = Date.today #今日の日付を取得
      @now = Time.now     #現在時刻を取得
    end
    
    private
    
    def correct_customer
      @post = Post.find(params[:id])
      unless @post.customer == current_customer
        redirect_to public_post_path(@post)
      end
    end
    
    def post_params
      params.require(:post).permit(:customer_id, :title, :body, :rideday, :runtime, :mileage, :prefecture_id, :profile_image, images: [])
    end
    
end