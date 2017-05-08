class Client < ActiveRecord::Base
  has_many :trips
  has_many :drivers, through: :trips
  has_many :vehicles, through: :trips

  def initialize(attributes)
    attributes.each {|key, value| self.send(("#{key}="), value)}
  end
end
