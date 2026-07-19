class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :family_members, dependent: :destroy
  has_many :medications, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :cared_family_members, class_name: "FamilyMember", foreign_key: "caregiver_id"
end
