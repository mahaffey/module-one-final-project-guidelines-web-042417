class Vehicle < ActiveRecord::Base
  has_many :trips
  has_many :drivers, through: :trips
  has_many :clients, through: :trips
end
