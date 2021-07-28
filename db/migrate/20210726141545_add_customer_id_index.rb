# frozen_string_literal: true

class AddCustomerIdIndex < ActiveRecord::Migration[6.1]
  def change
    add_index :users, :customer_id, unique: true
  end
end
