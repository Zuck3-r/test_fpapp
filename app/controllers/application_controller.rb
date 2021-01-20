class ApplicationController < ActionController::Base
	include SessionsHelper
	add_flash_types :success, :info, :warning, :danger
	
	private
	
	def login_required
		redirect_to root_url unless current_user
	end
	
end
