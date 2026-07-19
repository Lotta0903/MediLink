class Notification < ApplicationRecord
  belongs_to :medication
  belongs_to :user

  scope :unread, -> { where(read: false) }

  def message
    owner_name = if medication.family_member.present?
      medication.family_member.first_name.presence || "Family member"
    else
      medication.user.email.split("@").first
    end

    "#{owner_name} took their #{medication.name}"
  end
end
