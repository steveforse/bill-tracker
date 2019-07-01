# frozen_string_literal: true

# Creates the schedules table
class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.integer :payee_id
      t.date :start_date
      t.date :end_date
      t.string :frequency
      t.boolean :autopay
      t.decimal :minimum_payment, precision: 10, scale: 2

      t.timestamps
    end
  end
end
