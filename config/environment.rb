require 'bundler'
Bundler.require
require_relative '../apps/models/client.rb'
require_relative '../apps/models/driver.rb'
require_relative '../apps/models/trip.rb'
require_relative '../apps/models/vehicle.rb'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
