# frozen_string_literal: true

# Foreign key index
class AddIndexToPayments < ActiveRecord::Migration[6.0]
  def change
    add_index :payments, :schedule_id
  end
end
