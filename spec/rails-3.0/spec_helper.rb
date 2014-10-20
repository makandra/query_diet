$: << File.join(File.dirname(__FILE__), "/../lib" )

# Set the default environment to sqlite3's in_memory database
ENV['RAILS_ENV'] ||= 'test'
ENV['RAILS_ROOT'] = 'app_root'

# Load the Rails environment and testing framework
require "#{File.dirname(__FILE__)}/app_root/config/environment"
require 'rspec/rails'

# Load dependencies
# require 'has_defaults'

# Require support code
# Dir["../shared/support/**/*.rb"].each {|f| require f}

FileUtils.rm(Dir.glob("#{Rails.root}/db/*.db"), :force => true)

# Run the migrations
print "\033[30m" # dark gray text
ActiveRecord::Migrator.migrate("#{Rails.root}/db/migrate")
print "\033[0m"

# For some reason the first time the SqliteAdapter fetches schema information it
# raises an error.
Movie.create rescue nil

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.use_instantiated_fixtures  = false
end
