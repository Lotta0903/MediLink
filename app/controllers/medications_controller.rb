class MedicationsController < ApplicationController
  before_action :set_medication, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :set_medication, only: %i[edit update destroy]

  def index
    @medications = current_user.medications
  end

  def calendar
    @medications = current_user.medications
    @following = current_user.following
    @user = current_user

    window_start = Date.current.prev_month.beginning_of_month
    window_end   = Date.current.next_month.end_of_month

    @medications_by_date = medications_by_date_hash(@medications.to_a, window_start, window_end)

    following_medications = Medication.where(user_id: @following.map(&:id)).group_by(&:user_id)
    @following_medications_by_user = @following.each_with_object({}) do |followed_user, hash|
      hash[followed_user.id] = medications_by_date_hash(following_medications[followed_user.id] || [], window_start, window_end)
    end

    @modal_medications = @medications.to_a + following_medications.values.flatten
  end

  def new
    @medication = Medication.new(start_date: Date.today, end_date: Date.today + 30.days)
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
    params.require(:medication).permit(:name, :dosage, :frequency, :dose_frequency, :start_date, :end_date,
                                       :reminder_time, :notes, :intake_instructions, :with_food)
  end

  def medications_by_date_hash(medications, range_start, range_end)
    taken_dates = taken_dates_lookup(medications, range_start, range_end)

    (range_start..range_end).each_with_object({}) do |date, hash|
      day_meds = medications.select { |m| medication_on_date?(m, date) }
      next if day_meds.empty?

      hash[date.iso8601] = day_meds.map { |m| medication_json(m, date, taken_dates) }
    end
  end

  def taken_dates_lookup(medications, range_start, range_end)
    return {} if medications.empty?

    MedicationLog
      .where(medication_id: medications.map(&:id), taken_at: range_start.beginning_of_day..range_end.end_of_day)
      .pluck(:medication_id, :taken_at)
      .each_with_object({}) { |(medication_id, taken_at), hash| (hash[medication_id] ||= []) << taken_at.to_date }
  end

def medication_on_date?(medication, date)
    return false if medication.start_date.present? && date < medication.start_date
    return false if medication.end_date.present? && date > medication.end_date

    return true if medication.frequency.blank?

    valid_days = %w[Mon Tue Wed Thu Fri Sat Sun]
    freq_days = medication.frequency.split(",").map(&:strip) & valid_days

    freq_days.empty? || freq_days.include?(date.strftime("%a"))
  end

  def medication_json(medication, date, taken_dates)
    {
      id: medication.id,
      name: medication.name,
      dosage: medication.dosage,
      reminder_time: medication.reminder_time,
      frequency: medication.frequency,
      status: medication_status(medication, date, taken_dates)
    }
  end

  def medication_status(medication, date, taken_dates)
    return "taken" if taken_dates[medication.id]&.include?(date)
    return "upcoming" if date > Date.current

    if date < Date.current
      "missed"
    elsif medication.reminder_time.present?
      scheduled = Time.zone.parse("#{date} #{medication.reminder_time}")
      Time.current >= scheduled ? "missed" : "upcoming"
    else
      "upcoming"
    end
  end
end
