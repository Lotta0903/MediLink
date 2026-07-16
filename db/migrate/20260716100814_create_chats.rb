# frozen_string_literal: true

class CreateChats < ActiveRecord::Migration[8.1]
  def change
    create_table :chats do |t|
      t.string :title
      t.references :medication, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
