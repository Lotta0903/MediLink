class Medication < ApplicationRecord
  belongs_to :user
  has_many :chats, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :medication_logs, dependent: :destroy

  def taken_today?
    medication_logs.where(taken_at: Date.current.all_day).exists?
  end

  def last_taken_time
    medication_logs.order(taken_at: :desc).first&.taken_at&.strftime("%H:%M")
  end

  # Returns true if the reminder time has passed today and medication not taken yet
  def reminder_due?
    return false if taken_today?
    return false unless reminder_time.present?
    scheduled_today = Time.zone.parse("#{Date.current} #{reminder_time}")
    Time.current >= scheduled_today
  end

  # Returns true if the medication is missed (1 min after reminder + not taken)
  def missed?
    return false if taken_today?
    return false unless reminder_time.present?
    scheduled_today = Time.zone.parse("#{Date.current} #{reminder_time}")
    Time.current >= scheduled_today + 1.minute
  end
end
