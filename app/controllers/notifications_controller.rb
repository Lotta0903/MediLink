class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    check_and_create_reminders_and_missed
    @notifications = current_user.notifications.order(created_at: :desc).to_a
    @has_unread = @notifications.any? { |notification| !notification.read? }
    @notifications_by_day = @notifications.group_by { |notification| notification.created_at.to_date }
    current_user.notifications.unread.update_all(read: true)
  end

  def latest
    check_and_create_reminders_and_missed

    recent_notifications = current_user.notifications
      .where(read: false)
      .where("created_at >= ?", 30.seconds.ago)
      .order(created_at: :desc)
      .limit(5)

    render json: recent_notifications.map { |n|
      {
        id: n.id,
        message: n.message,
        kind: n.kind,
        created_at: n.created_at.iso8601,
        with_food: n.medication.with_food
      }
    }
  end

  def destroy
    current_user.notifications.find(params[:id]).destroy
    redirect_to notifications_path
  end

  private

  def check_and_create_reminders_and_missed
    current_user.medications.each do |medication|
      create_reminder_if_due(medication)
      create_missed_if_missed(medication)
    end

    current_user.following.each do |followed_user|
      followed_user.medications.each do |medication|
        create_follower_missed_notification(medication)
      end
    end
  end

  def create_reminder_if_due(medication)
    return unless medication.reminder_due?
    return if notification_exists_today?(current_user, medication, "reminder")

    Notification.create!(
      user: current_user,
      medication: medication,
      kind: "reminder",
      read: false
    )
  end

  def create_missed_if_missed(medication)
    return unless medication.missed?
    return if notification_exists_today?(current_user, medication, "missed")

    Notification.create!(
      user: current_user,
      medication: medication,
      kind: "missed",
      read: false
    )
  end

  def create_follower_missed_notification(medication)
    return unless medication.missed?
    return if notification_exists_today?(current_user, medication, "follower_missed")

    Notification.create!(
      user: current_user,
      medication: medication,
      kind: "follower_missed",
      read: false
    )
  end

  def notification_exists_today?(user, medication, kind)
    user.notifications
      .where(medication: medication, kind: kind)
      .where(created_at: Date.current.all_day)
      .exists?
  end
end
