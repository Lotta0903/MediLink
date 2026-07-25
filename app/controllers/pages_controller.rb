class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    return unless user_signed_in?

    @today_medications = current_user.medications.to_a
    @total_today_count = @today_medications.size
    @taken_today_count = @today_medications.count(&:taken_today?)
    @first_name = current_user.first_name.presence || current_user.email.split("@").first.capitalize
  end
end
