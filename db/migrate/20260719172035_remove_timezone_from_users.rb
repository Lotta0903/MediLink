class RemoveTimezoneFromUsers < ActiveRecord::Migration[8.1]
  def change
    remove_column :users, :timezone, :string
  end
end
