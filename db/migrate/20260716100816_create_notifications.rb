# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[8.1]
  def change
    create_table :notifications do |t|
      t.datetime :schedule_to
      t.boolean :sent, default: false, null: false
      t.references :medication, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
