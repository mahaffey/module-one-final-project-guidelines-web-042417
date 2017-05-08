class CreateTripsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :trips do |t|
      t.references :driver
      t.references :vehicle
      t.references :client
      t.float :price
      t.integer :miles
      t.integer :num_of_pass
      t.datetime :pickup_time
      t.string :pickup_loc
      t.datetime :dropoff_time
      t.string :dropoff_loc
      t.timestamps
    end
  end
end
