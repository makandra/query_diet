class QueryDietController < ApplicationController

  layout 'screen'

  def no_query
  end

  def two_queries
    Movie.create!
    Movie.all
  end

end
