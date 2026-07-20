class FollowsController < ApplicationController
  before_action :authenticate_user!

  def index
    @following = current_user.following
    @followers = current_user.followers
  end

  def create
    followed = User.find_by(email: params[:email])

    if followed.nil?
      redirect_to follows_path, alert: "No MediLink user found with that email."
      return
    end

    follow = current_user.follow(followed)

    if follow.persisted?
      redirect_to follows_path, notice: "You are now following #{followed.email}."
    else
      redirect_to follows_path, alert: follow.errors.full_messages.to_sentence
    end
  end

  def destroy
    current_user.unfollow(User.find(params[:id]))
    redirect_to follows_path, notice: "Unfollowed successfully."
  end
end
