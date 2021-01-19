class PlannersController < ApplicationController
  
  def index
    @planners = Planner.all
  end
  
  def new
    @planner = Planner.new
  end
  
  def create
    @planner = Planner.new(planner_params)
    
    if @planner.save
      redirect_to root_url, success: "登録完了　ログインしてください"
    else
      render 'new'
    end
  end


  private
  def planner_params
    params.require(:planner).permit(:name, :email, :password, :password_confirmation)
  end
  
end
