class Reservation < ApplicationRecord
	extend ActiveHash::Associations::ActiveRecordExtensions
	belongs_to :planner
	belongs_to :customer, optional: true
	belongs_to :time_table
	
	validates :time_table_id, presence: true, inclusion: { in: 1..16 }
	validates :date, presence: true, date: true
	validates :planner_id, uniqueness: { scope: [:time_table_id, :date ] }
	validate :saturday_time
	
	def saturday_time
		return unless date.present?
		return unless time_table_id.present?
		
		if date.saturday? && [*3..10].exclude?(time_table_id)
			errors.add(:time_table_id, "土曜のその時間は働けねぇよ！")
		end
	end
end
