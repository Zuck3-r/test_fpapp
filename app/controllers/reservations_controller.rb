class ReservationsController < ApplicationController
	
	def create
		@reservation = Reservation.new(reservation_params)
		@reservation.planner_id = session[:user_id]
		if @reservation.save && planner_user?
			redirect_to current_user, info: "登録出来ました"
		else
			redirect_to current_user, danger: "無効な日時が指定されました"
		end
	end
	
	private
	
	def reservation_params
		params.require(:reservation).permit(:time_table_id, :date)
	end
end
