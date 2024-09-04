$: << File.join(File.dirname(__FILE__), "/../lib" )

# Set the default environment to sqlite3's in_memory database
ENV['RAILS_ENV'] ||= 'test'

# Load the Rails environment and testing framework
require "#{File.dirname(__FILE__)}/../config/environment"
require 'rspec/rails'
require 'database_cleaner'

FileUtils.rm(Dir.glob("#{Rails.root}/db/*.db"), :force => true)

# Run the migrations
ActiveRecord::Schema.verbose = false
ActiveRecord::MigrationContext.new("#{Rails.root}/db/migrate").migrate

# For some reason the first time the SqliteAdapter fetches schema information it
# raises an error
Movie.create rescue nil

# Movie.reset_column_information

RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = :should }
  config.mock_with(:rspec) { |c| c.syntax = :should }
  config.before { DatabaseCleaner.clean }
end
