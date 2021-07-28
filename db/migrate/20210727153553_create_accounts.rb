# frozen_string_literal: true

class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.text :data
      t.references :connection, null: false, foreign_key: true

      t.timestamps
    end
  end
end
