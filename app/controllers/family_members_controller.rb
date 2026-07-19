class FamilyMembersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_family_member, only: %i[edit update destroy]

  def index
    @family_members = current_user.family_members
  end

  def new
    @family_member = current_user.family_members.new
  end

  def create
    attrs = family_member_params
    caregiver_email = attrs.delete(:caregiver_email)
    @family_member = current_user.family_members.new(attrs)
    assign_caregiver(caregiver_email)

    if @family_member.errors.empty? && @family_member.save
      redirect_to family_members_path, notice: "Family member added successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    attrs = family_member_params
    caregiver_email = attrs.delete(:caregiver_email)
    @family_member.assign_attributes(attrs)
    assign_caregiver(caregiver_email)

    if @family_member.errors.empty? && @family_member.save
      redirect_to family_members_path, notice: "Family member updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @family_member.destroy
    redirect_to family_members_path, notice: "Family member deleted successfully."
  end

  private

  def set_family_member
    @family_member = current_user.family_members.find(params[:id])
  end

  def assign_caregiver(email)
    return if email.blank?

    caregiver = User.find_by(email: email)
    if caregiver
      @family_member.caregiver = caregiver
    else
      @family_member.errors.add(:caregiver_email, "doesn't match any MediLink user")
    end
  end

  def family_member_params
    params.require(:family_member).permit(:first_name, :last_name, :status, :caregiver_email)
  end
end
