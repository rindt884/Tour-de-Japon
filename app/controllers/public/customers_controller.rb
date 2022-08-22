class Public::CustomersController < ApplicationController
    before_action :ensure_correct_customer, only: [:edit, :update]
    before_action :set_customer, only: [:favorites]
    # before_action :current_customer, only: [:edit, :update]
    
    def show
      @customer = Customer.find(params[:id])
      @posts = Post.where(customer_id: [@customer.id]).order(created_at: :desc).page(params[:page])
      @today = Date.today #今日の日付を取得
      @now = Time.now     #現在時刻を取得
    end
    
    def edit
      @customer = Customer.find(params[:id])
    end
    
    def update
      @customer = Customer.find(params[:id])
      if @customer.update(customer_params)
        redirect_to public_customer_path(current_customer)
      else
        render "edit"
      end
    end
    
    def favorites
      favorites = Favorite.where(customer_id: @customer.id).pluck(:post_id)
      @posts = Post.page(params[:page]).where(id: favorites)
      @today = Date.today #今日の日付を取得
      @now = Time.now     #現在時刻を取得
    end
    
    def search
    if params[:keyword].present?
      @customers = Customer.where('name LIKE (?)', "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      redirect_to public_customer_path(@customer.id)
    end
    end
    
    private

    def customer_params
      params.require(:customer).permit(:name, :introduction, :profile_image)
    end
    
    def ensure_correct_customer
      @customer = Customer.find(params[:id])
      unless @customer == current_customer
        redirect_to public_customer_path(current_customer)
      end
    end
    
    def set_customer
      @customer = Customer.find(params[:id])
    end

end
