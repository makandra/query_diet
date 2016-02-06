$: << File.join(File.dirname(__FILE__), "/../lib" )

# Set the default environment to sqlite3's in_memory database
ENV['RAILS_ENV'] ||= 'test'
ENV['RAILS_ROOT'] = 'app_root'

# Load the Rails environment and testing framework
require "#{File.dirname(__FILE__)}/../app_root/config/environment"
require 'rspec/rails'
require 'database_cleaner'

FileUtils.rm(Dir.glob("#{Rails.root}/db/*.db"), :force => true)

# Run the migrations
ActiveRecord::Schema.verbose = false
ActiveRecord::Migrator.migrate("#{Rails.root}/db/migrate")

# For some reason the first time the SqliteAdapter fetches schema information it
# raises an error
Movie.create rescue nil

# Movie.reset_column_information

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.use_instantiated_fixtures  = false
  config.raise_errors_for_deprecations!
  config.infer_spec_type_from_file_location!
  config.before { DatabaseCleaner.clean }
end
