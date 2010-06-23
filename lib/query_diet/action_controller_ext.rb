require_dependency 'application_controller'

ApplicationController.class_eval do

  around_filter :query_diet_logging

  private

  def query_diet_logging
    QueryDiet::Logger.reset
    yield
    QueryDiet::Widget.render(response)
  end

end
