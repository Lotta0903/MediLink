class Notification < ApplicationRecord
  belongs_to :medication
  belongs_to :user

  scope :unread, -> { where(read: false) }

  def message
    verb = missed? ? "missed" : "took"
    "#{medication.user.full_name} #{verb} their #{medication.name}"
  end

  def status
    missed? ? :missed : :taken
  end
end
