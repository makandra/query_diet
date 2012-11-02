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

ActionController::Dispatcher.middleware.use('QueryDiet::Rack::ResetLogger')
