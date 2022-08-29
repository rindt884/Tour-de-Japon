class Public::CustomersController < ApplicationController
  
    before_action :authenticate_customer!
    before_action :ensure_correct_customer, only: [:edit, :update, :favorites, :unsubscribe, :withdrawal]
    before_action :set_customer, only: [:favorites]

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
        flash[:notice] = "編集しました。"
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
        @customers = Customer.none
      end
    end
    
    def unsubscribe
    end
    
    def withdrawal
      @customer = Customer.find(params[:id])
      @customer.update(is_deleted: true) # is_deletedカラムをtrueに変更することにより削除フラグを立てる
      reset_session
      flash[:notice] = "退会処理を実行いたしました"
      redirect_to new_customer_registration_path
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
