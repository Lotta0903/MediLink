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
end
