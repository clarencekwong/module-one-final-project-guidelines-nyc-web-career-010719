ENV["SINATRA_ACTIVESUPPORT_WARNING"]="false"
require 'bundler'
require 'rest-client'
require 'io/console'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = nil
require_all 'lib'

require_relative '../app/models/assignment.rb'
require_relative '../app/models/student.rb'
require_relative '../app/models/teacher.rb'
require_relative '../app/models/admin.rb'
require_relative '../app/models/event.rb'
require_relative '../app/models/api_communicator.rb'
require_relative '../app/models/command_line_interface.rb'
