class SpecApp < Rails::Application
end

Rails.application = SpecApp.instance

if defined?(Rails.application.secrets)
  Rails.application.secrets.secret_key_base = 'the_secret'
  Rails.application.secrets.secret_token = 'the_secret'
end

class ActionController::Base
  def _routes
    Rails.application.routes
  end
end
