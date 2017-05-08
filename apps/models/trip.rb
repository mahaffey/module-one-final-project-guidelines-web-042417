class Trip < ActiveRecord::Base
  attr_accessor :price, :miles, :num_of_pass, :pickup_time, :pickup_loc, :dropoff_time, :dropoff_loc
  attr_reader :driver_id, :vehicle_id, :client_id

  belongs_to :client
  belongs_to :vehicle
  belongs_to :driver

  @@all = []
  @@active_trips = []
  @@archived_trips = []

  def initialize(attributes,client_name)
    attributes.each { |key, value| self.send(("#{key}="), value) }
    Client.find_or_create_by(client_name)
    @@all << self
    @@active_trips << self
  end

  def self.all
    @@all
  end

  def self.active
    @@active_trips
  end

  def self.archived
    @@archived_trips
  end

end
