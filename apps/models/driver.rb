class Driver < ActiveRecord::Base
  has_many :trips
  has_many :clients, through: :trips
  has_many :vehicles, through: :trips

  #@@all = []

  # def initialize(attributes)
  #   attributes.each { |key, value| self.send(("#{key}="), value) }
  #   @@all << self
  # end

end
