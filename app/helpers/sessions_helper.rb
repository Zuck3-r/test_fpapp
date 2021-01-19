module SessionsHelper
	#ログイン処理セッションにユーザID付与
	def log_in(user)
		session[:user_id] = user.id
	end

end