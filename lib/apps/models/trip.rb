class Trip < ActiveRecord::Base
  belongs_to :client
  belongs_to :vehicle
  belongs_to :driver
  before_save :google_directions_init

  def google_directions_init
    if self.pickup_loc && self.dropoff_loc
      info = GoogleDirections.new(self.pickup_loc, self.dropoff_loc)
      get_trip_distance_miles(info)
      get_trip_time_minutes(info)
      get_dropoff_time(info)
      pricing
    end
  end

  def get_dropoff_time(info)
    self.dropoff_time = self.pickup_time + get_trip_time_minutes(info)*60
  end

  def get_trip_distance_miles(info)
    self.miles = info.distance_text.split(" ")[0].to_f
  end

  def get_trip_time_minutes(info)
    self.estimated_time_minutes = info.drive_time_in_minutes
  end

  def pricing
    self.price = 5 + self.miles * 2 + self.estimated_time_minutes
  end

  def price_string
    "$#{self.price}0"
  end

end
