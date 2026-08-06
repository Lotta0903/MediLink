class MedicationLogsController < ApplicationController
  before_action :authenticate_user!

  def create
    @medication = Medication.find(params[:medication_id])

    unless @medication.user == current_user
      redirect_to medications_path, alert: "Access denied." and return
    end

    @medication.medication_logs.create!(taken_at: Time.current)


    current_user.notifications
      .where(medication: @medication, kind: ["reminder", "missed"])
      .where(created_at: Date.current.all_day)
      .destroy_all


    current_user.followers.each do |follower|
      follower.notifications
        .where(medication: @medication, kind: "follower_missed")
        .where(created_at: Date.current.all_day)
        .destroy_all
    end


    current_user.followers.each do |follower|
      Notification.create!(user: follower, medication: @medication)
    end

    redirect_to medications_path, notice: "Medication marked as taken."
  end
end
