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
  
  
end