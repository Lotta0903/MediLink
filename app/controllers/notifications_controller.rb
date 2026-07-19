class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.order(created_at: :desc).to_a
    current_user.notifications.unread.update_all(read: true)
  end

  def destroy
    current_user.notifications.find(params[:id]).destroy
    redirect_to notifications_path
  end
end
