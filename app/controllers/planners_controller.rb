class PlannersController < ApplicationController
  before_action :login_required, only: [:edit, :update, :show, :schedule]
  before_action :check_planner, only: [:edit, :update, :show, :schedule]
  
  def new
    @planner = Planner.new
    @skills  = Skill.all
  end
  
  def create
    @planner = Planner.new(planner_params)
    
    if @planner.save
      redirect_to login_path, success: "登録完了　ログインしてください"
    else
      render 'new'
    end
  end
  
  def show
    @planner = Planner.find(current_user.id)
    @skills = @planner.skills
    @reservation = Reservation.new
    @reservations = Reservation.where(planner_id: @planner.id, customer_id: nil)
    @reservations = @reservations.where('date >= ?', Date.today)
  end
  
  def edit
    @planner = Planner.find(current_user.id)
  end
  
  def update
    @planner = Planner.find(current_user.id)
    @planner.update_attribute(:skill_ids, params[:planner][:skill_ids])
    redirect_to current_user, success: 'スキルの更新に成功しました'
  end
  
  def schedule
    @reservations = Reservation.where(planner_id: current_user.id)
    @reservations = @reservations.where('date >= ?', Date.today)
    @reservations = @reservations.where.not(customer_id: nil)
    return unless @reservations.empty?

    redirect_to current_user, info: '現在、予約されている枠はありません'
  end

  private
  
  def planner_params
    params.require(:planner).permit(:name, :email, :password, :password_confirmation, skill_ids: [])
  end
  
end
