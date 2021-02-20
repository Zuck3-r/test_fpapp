class PlannersController < ApplicationController
  before_action :login_required, only: [:edit, :update, :show]
  
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
    @reservations = Reservation.where(planner_id: @planner.id)
    @reservations = @reservations.where('date >= ?', Date.today)
  end
  
  def edit
    @planner = Planner.find(current_user.id)
  end
  
  def update
    @planner = Planner.find(current_user.id)
    @planner.update_attribute(:skill_ids, params[:planner][:skill_ids])
    redirect_to root_url
  end
  
  def schedule
    @reservations = Reservation.where(planner_id: current_user.id)
    #@reservations = @reservations.where('date >= ?', Date.today)
    @reservations = @reservations.where.not(customer_id: nil)
  end

  private
  
  def planner_params
    params.require(:planner).permit(:name, :email, :password, :password_confirmation, skill_ids: [])
  end
  
end
