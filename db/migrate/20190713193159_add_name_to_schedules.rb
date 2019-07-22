# frozen_string_literal: true

# Decided to add a name to schedules to tell them apart on calendar
class AddNameToSchedules < ActiveRecord::Migration[6.0]
  def change
    add_column :schedules, :name, :string
  end
end
