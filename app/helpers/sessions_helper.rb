module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
    case user.class.name
    when 'Planner'
      session[:role] = 'Planner'
    when 'Customer'
      session[:role] = 'Customer'
    end
  end
  
  def log_out
    session.delete(:user_id)
    session.delete(:role)
    @current_user = nil
  end

  def current_user
    if session[:role] == 'Planner'
      @current_user ||= Planner.find_by(id: session[:user_id])
    elsif session[:role] == 'Customer'
      @current_user ||= Customer.find_by(id: session[:user_id])
    end
  end
  
  def login_required
    redirect_to root_url, danger: "ログインしてくれYO！" unless current_user
  end
  

  def logged_in?
    !current_user.nil?
  end
  
  def session_planner?
    session[:role]=="Planner"
  end

  def session_customer?
    session[:role]=="Customer"
  end
  
  def check_planner
    redirect_to root_url, danger: "そのページは開けないよ！" unless session_planner?
  end
  
  def check_customer
    redirect_to root_url, danger: "そのページは開けないよ！" unless session_customer?
  end
  
end

