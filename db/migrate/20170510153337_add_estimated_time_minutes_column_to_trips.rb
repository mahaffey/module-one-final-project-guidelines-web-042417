class AddEstimatedTimeMinutesColumnToTrips < ActiveRecord::Migration[5.0]
  def change
    add_column :trips, :estimated_time_minutes, :integer
  end
end
