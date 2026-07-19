class AddUserAndReadToNotifications < ActiveRecord::Migration[8.1]
  def change
    add_reference :notifications, :user, null: false, foreign_key: true
    add_column :notifications, :read, :boolean, default: false, null: false
  end
end
