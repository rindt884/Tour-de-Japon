class Public::PostsController < ApplicationController
    
    def new
      @post = Post.new
    end
    
    def index
    end
    
    def show
    end
    
    def edit
    end
    
    def create
    end
    
    def destroy
    end
    
    def update
    end
    
    private
    
    def post_params
      params.require(:post).permt(:customer_id, :image, :title, :body, :rideday, :runtime, :mileage)
    end
    
end
