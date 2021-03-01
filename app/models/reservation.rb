class Reservation < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :planner
  belongs_to :customer, optional: true
  belongs_to :time_table

  validates :time_table_id, presence: true, inclusion: { in: 1..16 }
  validates :date, presence: true
  validates :planner_id, uniqueness: { scope: %i[time_table_id date], message: 'に同じ時間の予約枠が存在します' }, presence: true
  validates :customer_id, numericality: { only_integer: true }, allow_nil: true
  validate :not_sunday
  validate :not_before_today
  validate :saturday_time

  START_TIME_ID = 3
  END_TIME_ID = 10

  scope :after_today, -> { where('date >= ?', Date.today) }

  def saturday_time
    return unless date.present?
    return unless time_table_id.present?

    errors.add(:time_table_id, '範囲外です') if date.saturday? && [*START_TIME_ID..END_TIME_ID].exclude?(time_table_id)
  end

  def not_sunday
    return unless date.present?

    errors.add(:date, '日曜日は働いちゃダメです！') if date.sunday?
  end

  def not_before_today
    return unless date.present?

    errors.add(:date, '明日以降の日付を登録して下さい') if date <= Date.today
  end
end
