# require_dependency 'application_controller'

already_inherited = defined?(ApplicationController)

[ActionController::Base, already_inherited ? ApplicationController : nil].compact.each do |base|
  base.class_eval do

    around_filter :query_diet_logging

    private

    def query_diet_logging
      QueryDiet::Logger.reset
      yield
      QueryDiet::Widget.render(response)
    end

  end

end
