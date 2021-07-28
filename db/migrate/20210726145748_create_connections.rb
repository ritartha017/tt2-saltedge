# frozen_string_literal: true

class CreateConnections < ActiveRecord::Migration[6.1]
  def change
    create_table :connections do |t|
      t.text :data

      t.timestamps
    end
  end
end
