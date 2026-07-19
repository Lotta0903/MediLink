class MedicationsController < ApplicationController
  before_action :set_medication, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :set_medication, only: %i[edit update destroy]
  before_action :set_family_member, only: %i[index new create]

  def index
    @medications = @family_member ? @family_member.medications : current_user.medications
  end

  def new
    @medication = Medication.new
  end

  def show
    @medication = Medication.find(params[:id])
    @chats = current_user.chats
  end

  def create
    @medication = Medication.new(medication_params)

    if @family_member
      @medication.family_member = @family_member
    else
      @medication.user = current_user
    end

    if @medication.save
      redirect_to medications_path(family_member_id: @family_member&.id), notice: "Medication added successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @medication.update(medication_params)
      redirect_to medications_path(family_member_id: @medication.family_member_id),
                  notice: "Medication updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    family_member_id = @medication.family_member_id
    @medication.destroy
    redirect_to medications_path(family_member_id: family_member_id), notice: "Medication deleted successfully."
  end

  private

  def set_family_member
    @family_member = current_user.family_members.find(params[:family_member_id]) if params[:family_member_id].present?
  end

  def set_medication
    @medication = Medication.find(params[:id])

    return if @medication.user == current_user || @medication.family_member&.user == current_user

    redirect_to medications_path, alert: "Access denied." and return
  end

  def medication_params
    params.require(:medication).permit(:name, :dosage, :frequency, :start_date, :end_date, :reminder_time)
  end
end
