# FamilyMember is being replaced by user-to-user follows. FamilyMember records
# themselves aren't migrated (this is a demo project, no real user data at stake) -
# we only backfill medications.user_id from the family member's owning user, so
# every medication keeps a valid owner before family_member_id is removed.
class MigrateMedicationsToUser < ActiveRecord::Migration[8.1]
  def up
    Medication.reset_column_information

    Medication.where(user_id: nil).find_each do |medication|
      family_member = FamilyMember.find_by(id: medication.family_member_id)
      medication.update_column(:user_id, family_member.user_id) if family_member
    end

    remove_column :medications, :family_member_id, :bigint
    change_column_null :medications, :user_id, false
  end

  def down
    add_column :medications, :family_member_id, :bigint
    add_index :medications, :family_member_id
    change_column_null :medications, :user_id, true
  end
end
