# frozen_string_literal: true

class CreateFamilyMembers < ActiveRecord::Migration[8.1]
  def change
    create_table :family_members do |t|
      t.string :first_name
      t.string :last_name
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
