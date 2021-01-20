class StaticPagesController < ApplicationController
  
  def home
    #ログインしていたら本人のマイページに移動
    if logged_in?
      redirect_to current_user
    end
  end
  
  def choose
  end

  def help
  end
end
