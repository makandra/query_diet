module QueryDiet
  module Rack
    class ResetLogger

      def initialize(app)
        @app = app
      end

      def call(env)
        QueryDiet::Logger.reset
        @app.call(env)
      end

    end
  end
end

if defined?(Rails::Railtie)
  class QueryDiet::Railtie < Rails::Railtie
    initializer 'query_diet.insert_middleware' do |app|
      app.config.middleware.use 'QueryDiet::Rack::ResetLogger'
    end
  end
else
  ActionController::Dispatcher.middleware.use('QueryDiet::Rack::ResetLogger')
end
