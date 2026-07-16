# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[8.1]
  def change
    create_table :messages do |t|
      t.text :content
      t.string :role
      t.references :chat, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
