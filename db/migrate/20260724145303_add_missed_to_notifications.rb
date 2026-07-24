class AddMissedToNotifications < ActiveRecord::Migration[8.1]
  def change
    add_column :notifications, :missed, :boolean, default: false, null: false
  end
end
