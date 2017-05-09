require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db', environment: 'development')
ActiveRecord::Base.logger.level = 1

require_all 'lib'
