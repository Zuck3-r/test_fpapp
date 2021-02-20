class ReservationsController < ApplicationController
	before_action :login_required
	before_action :check_planner, only: [:create, :destroy]
	before_action :check_customer, only: [:update ]
	
	def create
		@reservation = Reservation.new(reservation_params)
		@reservation.planner_id = session[:user_id]
		if @reservation.invalid?
			redirect_to current_user
		elsif @reservation.date <= Date.today
			redirect_to current_user, danger: "過去には戻れんのや..."
			#ここはモデルのとこにバリデーション置いてもええかも？
		elsif @reservation.date.wday==0
			redirect_to current_user, danger: "日曜日は仕事しないで！！"
		elsif @reservation.date.wday==6 && [*3..10].exclude?(@reservation.time_table_id)
			redirect_to current_user, danger: "土曜のその時間は働けねぇよ！"
		elsif @reservation.save && planner_user?
			redirect_to current_user, info: "登録出来ました"
		else
			redirect_to current_user, danger: "無効な日時が指定されました"
		end
	end
	
	def destroy
		@reservation = Reservation.find(params[:id])
		if @reservation.customer_id != nil
			redirect_to request.referer, danger: '予約入ってんぞ～'
		else
			@reservation.destroy
			redirect_to current_user, success: '削除しました'
		end
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
