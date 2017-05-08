class Vehicle < ActiveRecord::Base
  has_many :trips
  has_many :drivers, through: :trips
  has_many :clients, through: :trips

  @@all = []

  def initialize(attributes)
    attributes.each { |key, value| self.send(("#{key}="), value) }
      @@all << self
    end
  end

end
