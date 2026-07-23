class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :medications, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :notifications, dependent: :destroy

  has_many :active_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_follows, source: :followed
  has_many :passive_follows, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_follows, source: :follower

  def follow(user)
    active_follows.create(followed: user)
  end

  def unfollow(user)
    active_follows.find_by(followed: user)&.destroy
  end

  def following?(user)
    following.include?(user)
  end

  def full_name
    if first_name.present? && last_name.present?
      "#{first_name} #{last_name}"
    else
      email.split("@").first
    end
  end

  def initials
    if first_name.present? && last_name.present?
      "#{first_name[0]}#{last_name[0]}".upcase
    else
      email[0, 2].upcase
    end
  end
end
