class SessionsController < ApplicationController
  def new
  end
  
  def create
    if session_params[:flag]=="0"
      redirect_to "https://www.google.com/webhp?gl=us&hl=en&gws_rd=cr&pws=0"
    elsif session_params[:flag]=="1"
      user = Planner.find_by(email: session_params[:email])
    end
    
    if user&.authenticate(session_params[:password])
      log_in(user)
      redirect_to "https://www.google.com/webhp?gl=us&hl=en&gws_rd=cr&pws=0"
    else
      flash.now[:danger] = "メールアドレス、パスワードが違います"
      "https://www.yahoo.co.jp/"
    end
  end
  
  private
  def session_params
    params.require(:session).permit(:email, :password, :flag)
  end
end
