class Driver < ActiveRecord::Base
  has_many :trips
  has_many :clients, through: :trips
  has_many :vehicles, through: :trips
end
