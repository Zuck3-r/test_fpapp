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
    if @customer == nil
      redirect_to current_user
    end
    @reservations = Reservation.all
    @reservations = @reservations.where(customer_id: nil)
    @reservations = @reservations.where('date >= ?', Date.today)
  end
  
  def schedule
    @reservations = Reservation.where(customer_id: current_user.id)
  end
  
  def search
    @planners_ids = PlannerSkill.where(skill: params[:skill_ids]).pluck(:planner_id)
    @reservations = Reservation.all
    @reservations = @reservations.where(date: params[:date])
    @reservations = @reservations.where(planner_id: @planners_ids)
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:name, :email, :password, :password_confirmation)
  end
end
