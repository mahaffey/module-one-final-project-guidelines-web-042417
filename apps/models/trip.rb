class Trip < ActiveRecord::Base
  belongs_to :client
  belongs_to :vehicle
  belongs_to :driver
end
