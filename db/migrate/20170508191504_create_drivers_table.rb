class CreateDriversTable < ActiveRecord::Migration[5.0]
  def change
    create_table :drivers do |t|
      t.string :name
      t.integer :age
      t.integer :experience
      t.string :phone
      t.string :email
      t.string :address
      t.string :lic_state
      t.integer :lic_number
      t.string :lic_class
    end
  end
end
