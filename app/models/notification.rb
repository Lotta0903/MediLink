class Notification < ApplicationRecord
  belongs_to :medication
  belongs_to :user

  scope :unread, -> { where(read: false) }

  def message
    owner_name = medication.user.email.split("@").first
    "#{owner_name} took their #{medication.name}"
  end
end
