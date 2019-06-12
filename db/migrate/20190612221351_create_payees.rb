class CreatePayees < ActiveRecord::Migration[6.0]
  def change
    create_table :payees do |t|
      t.string :name
      t.string :alternative_name
      t.string :website
      t.string :phone_number
      t.text :description

      t.timestamps
    end
    add_index :payees, :name, unique: true
  end
end
