class AddNotesToMedications < ActiveRecord::Migration[8.1]
  def change
    add_column :medications, :notes, :text
  end
end
