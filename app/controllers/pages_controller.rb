class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    return unless user_signed_in?

    @selected_date = parse_date_param || Date.current
    @today_medications = current_user.medications.to_a.select { |m| medication_on_date?(m, @selected_date) }
    @total_today_count = @today_medications.size
    @taken_today_count = @today_medications.count { |m| taken_on_date?(m, @selected_date) }
    @first_name = current_user.first_name.presence || current_user.email.split("@").first.capitalize
  end

  private

  def parse_date_param
    Date.parse(params[:date]) if params[:date].present?
  rescue ArgumentError, TypeError
    nil
  end

  def medication_on_date?(medication, date)
    return false if medication.start_date.present? && date < medication.start_date
    return false if medication.end_date.present? && date > medication.end_date

    return true if medication.frequency.blank?

    valid_days = %w[Mon Tue Wed Thu Fri Sat Sun]
    freq_days = medication.frequency.split(",").map(&:strip) & valid_days

    freq_days.empty? || freq_days.include?(date.strftime("%a"))
  end

  def taken_on_date?(medication, date)
    medication.medication_logs.where(taken_at: date.all_day).exists?
  end
end
