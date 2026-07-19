class MedicationLogsController < ApplicationController
  before_action :authenticate_user!

  def create
    @medication = Medication.find(params[:medication_id])

    unless @medication.user == current_user || @medication.family_member&.user == current_user
      redirect_to medications_path, alert: "Access denied." and return
    end

    @medication.medication_logs.create!(taken_at: Time.current)

    if @medication.family_member&.caregiver
      Notification.create!(user: @medication.family_member.caregiver, medication: @medication)
    end

    redirect_to medications_path, notice: "Medication marked as taken."
  end
end
