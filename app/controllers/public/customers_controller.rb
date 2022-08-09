class Public::CustomersController < ApplicationController
    
    before_action :ensure_correct_user, only: [:edit, :update]
    
    def show
      @customer = Customer.find(params[:id])
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
    
    private

    def customer_params
      params.require(:customer).permit(:name, :introduction, :profile_image)
    end

end
