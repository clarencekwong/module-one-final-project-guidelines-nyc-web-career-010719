require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'

require_relative '../app/models/assignment.rb'
require_relative '../app/models/student.rb'
require_relative '../app/models/teacher.rb'
require_relative '../app/models/command_line_interface.rb'
