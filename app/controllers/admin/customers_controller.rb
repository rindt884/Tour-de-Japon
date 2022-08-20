class Admin::CustomersController < ApplicationController
    
  def index
    @customers = Customer.all.page(params[:page])
  end
  
  def show
    @customer = Customer.find(params[:id])
  end
    
end
