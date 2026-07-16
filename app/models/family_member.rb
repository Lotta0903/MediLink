class FamilyMember < ApplicationRecord
  belongs_to :user
  has_many :medications, dependent: :destroy
end
