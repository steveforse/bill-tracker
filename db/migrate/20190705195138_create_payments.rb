# frozen_string_literal: true

# Add the payments table
class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.integer :schedule_id
      t.decimal :amount, precision: 10, scale: 2
      t.date :date
      t.text :comment
      t.date :due_date

      t.timestamps
    end
  end
end
