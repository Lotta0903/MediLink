class MedicationsController < ApplicationController
  before_action :set_medication, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :set_medication, only: %i[edit update destroy]

  def index
    @medications = current_user.medications
  end

  def new
    @medication = Medication.new
  end

  def show
    @medication = Medication.find(params[:id])
    @chats = current_user.chats
  end

  def create
    @medication = current_user.medications.new(medication_params)

    if @medication.save
      redirect_to medications_path, notice: "Medication added successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @medication.update(medication_params)
      redirect_to medications_path, notice: "Medication updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @medication.destroy
    redirect_to medications_path, notice: "Medication deleted successfully."
  end

  private

  def set_medication
    @medication = Medication.find(params[:id])

    return if @medication.user == current_user

    redirect_to medications_path, alert: "Access denied." and return
  end

  def medication_params
    params.require(:medication).permit(:name, :dosage, :frequency, :start_date, :end_date, :reminder_time)
  end
end
