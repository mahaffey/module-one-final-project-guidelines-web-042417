class Client < ActiveRecord::Base
  has_many :trips
  has_many :drivers, through: :trips
  has_many :vehicles, through: :trips

end
