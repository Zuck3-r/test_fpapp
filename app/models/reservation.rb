class Reservation < ApplicationRecord
	extend ActiveHash::Associations::ActiveRecordExtensions
	belongs_to :planner
	belongs_to :customer, optional: true
	belongs_to :time_table
	
	validates :time_table_id, presence: true, inclusion: { in: 1..16 }
	validates :date, presence: true
end
