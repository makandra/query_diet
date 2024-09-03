# Set the default environment to sqlite3's in_memory database
ENV['RAILS_ENV'] ||= 'test'

# Runtime dependencies
require 'rails/all'
require_relative './support/app'
require 'rspec/rails'

require 'gemika'
require 'byebug'
require 'query_diet'

# Require all files in spec/support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each {|f| require f}

Gemika::RSpec.configure_clean_database_before_example

Gemika::RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = [:should, :expect] }
  config.mock_with(:rspec) { |c| c.syntax = [:should, :expect] }
end
