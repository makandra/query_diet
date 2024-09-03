# Set the default environment to sqlite3's in_memory database
ENV['RAILS_ENV'] ||= 'test'

# Runtime dependencies
require 'rails/all'
require_relative './support/app'
require 'rspec/rails'

# Development dependencies
require 'database_cleaner'
require 'gemika'

# Gem under test
require 'query_diet'

# Require all files in spec/support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each {|f| require f}

# For some reason the first time the SqliteAdapter fetches schema information it
# raises an error
Movie.create rescue nil

Gemika::RSpec.configure_should_syntax

Gemika::RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = :should }
  config.mock_with(:rspec) { |c| c.syntax = :should }

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
