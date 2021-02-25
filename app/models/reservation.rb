class Reservation < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :planner
  belongs_to :customer, optional: true
  belongs_to :time_table

  validates :time_table_id, presence: true, inclusion: { in: 1..16 }
  validates :date, presence: true, date: true
  validates :planner_id, uniqueness: { scope: %i[time_table_id date] }
  validates :customer_id, numericality: { only_integer: true }, allow_nil: true
  validate :saturday_time

  def saturday_time
    return unless date.present?
    return unless time_table_id.present?

    errors.add(:time_table_id, '時間外です') if date.saturday? && [*3..10].exclude?(time_table_id)
  end
end