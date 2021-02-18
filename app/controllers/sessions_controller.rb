class SessionsController < ApplicationController
  def new
  end
  
  def create
    if session_params[:flag]=="0"
      @user = Customer.find_by(email: session_params[:email])
    elsif session_params[:flag]=="1"
      @user = Planner.find_by(email: session_params[:email])
    end
    
    if @user&.authenticate(session_params[:password])
      log_in(@user)
      redirect_to current_user, info: 'ログインしました'
    else
      redirect_to login_path, danger: "メールアドレス、パスワードが違います"
    end
  end
  #ログアウト処理
  def destroy
    log_out if logged_in?
    redirect_to root_url, danger: "ログアウトしました"
  end
  
  private
  def session_params
    params.require(:session).permit(:email, :password, :flag)
  end
end
