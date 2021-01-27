class CustomersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :show]
  before_action :correct_user,   only: [:edit, :update, :show]
  
  def index
  end

  def new
    @customer = Customer.new
  end
  
  def create
    @customer = Customer.new(customer_params)
    
    if @customer.save
      redirect_to login_path, success: "登録完了　ログインしてください"
    else
      render 'new'
    end
  end

  def show
    @customer = Customer.find(params[:id])
    @reservations = Reservation.all
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:name, :email, :password, :password_confirmation)
  end
end
