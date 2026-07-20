
class MigrateMedicationsToUser < ActiveRecord::Migration[8.1]
  # Local models scoped to this migration, so we don't depend on app classes
  # that will be removed in later migrations
  class MigrationMedication < ActiveRecord::Base
    self.table_name = "medications"
  end

  class MigrationFamilyMember < ActiveRecord::Base
    self.table_name = "family_members"
  end

  def up
    MigrationMedication.reset_column_information

    MigrationMedication.where(user_id: nil).find_each do |medication|
      family_member = MigrationFamilyMember.find_by(id: medication.family_member_id)
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
