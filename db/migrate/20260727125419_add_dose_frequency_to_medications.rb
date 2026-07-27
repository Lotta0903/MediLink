class AddDoseFrequencyToMedications < ActiveRecord::Migration[8.1]
  def change
    add_column :medications, :dose_frequency, :string
  end
end
