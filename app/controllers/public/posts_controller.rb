class Public::PostsController < ApplicationController
  
    before_action :correct_customer, only: [:edit, :update]
    
    def new
      @post = Post.new
    end
    
    def index
      @posts = Post.where.not(customer_id: [current_customer.id]).order(created_at: :desc).page(params[:page])
      @today = Date.today #今日の日付を取得
      @now = Time.now     #現在時刻を取得
      # @q = Post.ransack(params[:q])
      # @posts = @q.result(distinct: true)
      # @post_prefecture_id = Prefecture.all
    end
    
    def show
      @post = Post.find(params[:id])
      @customer = current_customer
      @comment = Comment.new
      @comments = Comment.all
    end
    
    def edit
      @post = Post.find(params[:id])
    end
    
    def create
      @post = Post.new(post_params)
      @post.customer_id = current_customer.id
      if @post.save
        redirect_to public_post_path(@post)
      else
        render :new
      end
    end
    
    def destroy
      @post = Post.find(params[:id])
      @post.destroy
      redirect_to public_posts_path
    end
    
    def update
      @post = Post.find(params[:id])
      if @post.update(post_params)
        redirect_to public_post_path(@post)
      else
        render :edit
      end
    end
    
    def search
      if params[:keyword].present?
        @posts = Post.where('title LIKE (?) OR body LIKE (?)', "%#{params[:keyword]}%", "%#{params[:keyword]}%").page(params[:page])
        @keyword = params[:keyword]
        # binding.pry
        @today = Date.today #今日の日付を取得
        @now = Time.now     #現在時刻を取得
      else
        redirect_to public_posts_path, notice: "キーワードが見つかりませんでした"
      end
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
