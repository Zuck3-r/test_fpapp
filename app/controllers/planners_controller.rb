class PlannersController < ApplicationController
  
  def index
    @planners = Planner.all
  end
  
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
    @planner = Planner.find(params[:id])
    @skills = @planner.skills
    @reservations = Reservation.where(planner_id: params[:id])
    #@reservations = []
  end


  private
  def planner_params
    params.require(:planner).permit(:name, :email, :password, :password_confirmation, skill_ids: [])
  end
  
end
