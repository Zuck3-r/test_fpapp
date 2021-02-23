class ReservationsController < ApplicationController
	before_action :login_required
	before_action :check_planner, only: [:create, :destroy]
	before_action :check_customer, only: [:update ]
	
	def create
		@reservation = Reservation.new(reservation_params)
		@reservation.planner_id = session[:user_id]
		if @reservation.save
			redirect_to current_user, info: "登録出来ました"
		else
			redirect_to current_user, danger: "無効な値が指定されています"
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
		# if @reservation.customer_id != nil && @reservation.customer_id == current_user.id
		if @reservation.customer_id != nil && right_customer?
			@reservation.update_attribute(:customer_id, nil)
			redirect_to customers_schedule_url, info: '予約をキャンセルしました'
		elsif @reservation.customer_id == nil
			@reservation.update_attribute(:customer_id, current_user.id)
			redirect_to '/customers/schedule', info: '予約出来ました'
		else
			redirect_to '/customers/schedule', danger: '先約があります'
		end
	end

	private
	
	def reservation_params
		params.require(:reservation).permit(:time_table_id, :date)
	end
	
	def right_customer?
		@reservation.customer_id == current_user.id
	end
end
