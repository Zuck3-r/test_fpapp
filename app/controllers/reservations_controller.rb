class ReservationsController < ApplicationController
	
	def create
		@reservation = Reservation.new(reservation_params)
		@reservation.planner_id = session[:user_id]
		
		if @reservation.date.wday==0
			redirect_to current_user, danger: "日曜日は仕事しないで！！"
		elsif @reservation.date < Date.today
			redirect_to current_user, danger: "過去改変は禁止されています"
			#ここはモデルのとこにバリデーション置いてもええかも？
		elsif @reservation.save && planner_user?
			redirect_to current_user, info: "登録出来ました"
		else
			redirect_to current_user, danger: "無効な日時が指定されました"
		end
	end
	
	def destroy
		@reservation = Reservation.find(params[:id])
		@reservation.destroy
		redirect_to current_user, success: '削除しました'
	end
	
	def update
		@reservation = Reservation.find(params[:id])
		if @reservation.customer_id != nil && @reservation.customer_id == current_user.id
			@reservation.update_attribute(:customer_id, nil)
			redirect_to '/customers/schedule'
		elsif @reservation.customer_id == nil
			@reservation.update_attribute(:customer_id, current_user.id)
			redirect_to current_user
		end
	end

	private
	
	def reservation_params
		params.require(:reservation).permit(:time_table_id, :date)
	end
end
