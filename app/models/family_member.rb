class FamilyMember < ApplicationRecord
  belongs_to :user
  belongs_to :caregiver, class_name: "User", optional: true
  has_many :medications, dependent: :destroy
end
