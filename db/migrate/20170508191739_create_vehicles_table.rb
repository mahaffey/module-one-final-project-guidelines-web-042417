class CreateVehiclesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicles do |t|
      t.string :lic_plate
      t.integer :year
      t.string :make
      t.string :model
      t.string :color
      t.integer :seats
      t.integer :mileage
      t.string :type
      t.string :veh_class
    end
  end
end
