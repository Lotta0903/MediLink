class Medication < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :family_member, optional: true
  has_many :chats, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :medication_logs, dependent: :destroy

  validate :user_or_family_member_present

  private

  def user_or_family_member_present
    if user_id.blank? && family_member_id.blank?
      errors.add(:base, "doit appartenir à un utilisateur ou à un membre de la famille")
    elsif user_id.present? && family_member_id.present?
      errors.add(:base, "ne peut pas appartenir à la fois à un utilisateur et à un membre de la famille")
    end
  end
end
