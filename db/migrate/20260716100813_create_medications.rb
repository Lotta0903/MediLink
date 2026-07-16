# frozen_string_literal: true

class CreateMedications < ActiveRecord::Migration[8.1]
  def change
    create_table :medications do |t|
      t.string :name
      t.string :dosage
      t.string :reminder_time
      t.string :frequency
      t.date :start_date
      t.date :end_date
      t.references :user, null: true, foreign_key: true
      t.references :family_member, null: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
