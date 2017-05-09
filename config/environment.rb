require 'bundler'
Bundler.require
GOOGLE_MAPS_API_KEY="AIzaSyB9NV0DokmR74wpXN2uD38ekn54H5fT1W4"

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db', environment: 'development')
#ActiveRecord::Base.logger.level = 1

require_all 'lib'
