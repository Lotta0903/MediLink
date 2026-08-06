class Notification < ApplicationRecord
  belongs_to :medication
  belongs_to :user

  scope :unread, -> { where(read: false) }

  def message
    case kind
    when "reminder"
      "Time to take your #{medication.name}"
    when "missed"
      "You forgot your #{medication.name}"
    when "follower_missed"
      "#{medication.user.first_name} forgot their #{medication.name}"
    else
      verb = missed? ? "missed" : "took"
      "#{medication.user.full_name} #{verb} their #{medication.name}"
    end
  end

  def status
    case kind
    when "reminder"
      :reminder
    when "missed", "follower_missed"
      :missed
    else
      missed? ? :missed : :taken
    end
  end
end
