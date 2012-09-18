$LOAD_PATH << File.expand_path('../../lib', __FILE__)

# Set the default environment to sqlite3's in_memory database
ENV['RAILS_ENV'] ||= 'in_memory'

# Load the Rails environment and testing framework
require File.expand_path('../app_root/config/environment', __FILE__)
require 'query_diet'

MissingSourceFile::REGEXPS << [/^cannot load such file -- (.+)$/i, 1] # Ruby 1.9 vs Rails 2.3 fix

require 'spec/rails'

# Undo changes to RAILS_ENV
silence_warnings {RAILS_ENV = ENV['RAILS_ENV']}

# Run the migrations
ActiveRecord::Migration.verbose = false
ActiveRecord::Migrator.migrate("#{Rails.root}/db/migrate")

Spec::Runner.configure do |config|
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
end
