class RemoveTimezoneFromUsers < ActiveRecord::Migration[8.1]
  def change
    if column_exists?(:users, :timezone)
      remove_column :users, :timezone, :string
    end
  end
end
