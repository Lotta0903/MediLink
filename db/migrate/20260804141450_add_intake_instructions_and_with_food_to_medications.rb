class AddIntakeInstructionsAndWithFoodToMedications < ActiveRecord::Migration[8.1]
  def change
    add_column :medications, :intake_instructions, :string
    add_column :medications, :with_food, :string
  end
end
