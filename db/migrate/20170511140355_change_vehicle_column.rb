class ChangeVehicleColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :vehicles, :type, :type_of_veh
  end
end
