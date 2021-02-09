module SessionsHelper
  
  #ログイン処理セッションにユーザID付与
  def log_in(user)
    session[:user_id] = user.id
	  if user.class.name =="Planner"
	    session[:role]="Planner"
	  elsif user.class.name == "Customer"
	    session[:role]="Customer"
	  end
  end
	
	#ログイン中のユーザを定義
  def current_user
    if session[:user_id] && session[:role]=="Planner"
      @current_user ||= Planner.find_by(id: session[:user_id]) 
    elsif session[:user_id] && session[:role]=="Customer"
      @current_user ||= Customer.find_by(id: session[:user_id]) 
    end
  end
  
  #現在のユーザに値があるか
  def logged_in?
    !current_user.nil?
  end
  #現在のユーザがプランナーなら真
  def planner_user?
    session[:role]=="Planner"
  end
  
  #現在のユーザがカスタマーなら真
  def customer_user?
    session[:role]=="Customer"
  end
  #渡された値がログインユーザなら真
  def current_user?(user)
    user == current_user
  end

  #現在ログインしているユーザからログアウト
  def log_out
    session.delete(:user_id)
    session.delete(:role)
    @current_user = nil
  end
  
  def logged_in_user
    unless logged_in?
      flash[:danger] = "ログインしてください！"
      redirect_to login_url
    end
  end

  def correct_user
    if session[:user_id] && session[:role]=="Planner"
      if Planner.exists?(id: params[:id])
        @user = Planner.find(params[:id])
        redirect_to(root_url) unless @user == current_user
      else
        redirect_to(root_url)
      end
    elsif session[:user_id] && session[:role]=="Customer"
      if Customer.exists?(id: params[:id])
        @user = Customer.find(params[:id])
        redirect_to(root_url) unless @user == current_user
      else
        redirect_to(root_url)
      end
    end
  end
  
end