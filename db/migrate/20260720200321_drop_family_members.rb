class DropFamilyMembers < ActiveRecord::Migration[8.1]
  def change
    drop_table :family_members do |t|
      t.string :first_name
      t.string :last_name
      t.string :status
      t.bigint :user_id, null: false
      t.bigint :caregiver_id
      t.timestamps
    end
  end
end
