class CustomersController < ApplicationController
  before_action :login_required, only: [:edit, :update, :show, :schedule, :search]
  before_action :check_customer, only: [:edit, :update, :show, :schedule, :search]
  
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
    @customer = Customer.find(current_user.id)
    @reservations = Reservation.all
    @reservations = @reservations.where(customer_id: nil)
    @reservations = @reservations.where('date >= ?', Date.today)
  end
  
  def schedule
      @reservations = Reservation.where(customer_id: current_user.id)
      @reservations = @reservations.where('date >= ?', Date.today)
      nil_reservations('現在の予約日程はございません', 'info')
  end
  
  def search
    if before_today?
      redirect_to current_user, danger: '明日以降の予約枠しか検索できません'
    else
      @planners_ids = PlannerSkill.where(skill: params[:skill_ids]).pluck(:planner_id)
      @reservations = Reservation.where(date: params[:date], planner_id: @planners_ids)
      nil_reservations('一致する予約可能な枠がありません', 'danger')
    end
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:name, :email, :password, :password_confirmation)
  end
  
  def before_today?
    params[:date].to_date <= Date.today
  end
  
  def nil_reservations(message, label)
    return unless @reservations.empty?
        
    flash.now[:"#{label}"] = message
    render 'show'
  end
  
end
