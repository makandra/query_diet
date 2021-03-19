require File.expand_path('../boot', __FILE__)

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
# require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
# require 'action_mailbox/engine'
# require 'action_text/engine'
require 'action_view/railtie'
# require 'action_cable/engine'
# require 'sprockets/railtie'
require 'rails/test_unit/railtie'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)


module HasDefaultSpecApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    config.encoding = "utf-8"

    config.cache_classes = true
    config.whiny_nils = true

    config.consider_all_requests_local       = true
    config.action_controller.perform_caching = false

    config.action_dispatch.show_exceptions = false

    config.action_controller.allow_forgery_protection    = false

    config.action_mailer.delivery_method = :test

    config.active_support.deprecation = :stderr

    # config.active_record.sqlite3.represent_boolean_as_integer = true

    config.root = File.expand_path('../..', __FILE__)

    # railties.plugins << Rails::Plugin.new(File.expand_path('../../../../..', __FILE__))
  end
end
