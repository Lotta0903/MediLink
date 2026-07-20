class MedicationLogsController < ApplicationController
  before_action :authenticate_user!

  def create
    @medication = Medication.find(params[:medication_id])

    unless @medication.user == current_user
      redirect_to medications_path, alert: "Access denied." and return
    end

    @medication.medication_logs.create!(taken_at: Time.current)

    current_user.followers.each do |follower|
      Notification.create!(user: follower, medication: @medication)
    end

    redirect_to medications_path, notice: "Medication marked as taken."
  end
end
