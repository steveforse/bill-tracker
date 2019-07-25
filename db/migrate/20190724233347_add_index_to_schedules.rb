# frozen_string_literal: true

# Adds foreign key index
class AddIndexToSchedules < ActiveRecord::Migration[6.0]
  def change
    add_index :schedules, :payee_id
  end
end
