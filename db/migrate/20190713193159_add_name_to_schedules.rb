class AddNameToSchedules < ActiveRecord::Migration[6.0]
  def change
    add_column :schedules, :name, :string
  end
end
