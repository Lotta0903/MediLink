class AddCaregiverToFamilyMembers < ActiveRecord::Migration[8.1]
  def change
    add_reference :family_members, :caregiver, null: true, foreign_key: { to_table: :users }
  end
end
