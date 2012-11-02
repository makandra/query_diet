class QueryDietController < ApplicationController

  layout 'screen'

  def no_query
  end

  def two_queries
    Movie.create!
    Movie.all
  end

  def no_body_tag
    render :text => "no body tag", :content_type => "text/html"
  end

  def yaml
    render :text => { :foo => '<body></body>' }.to_yaml, :content_type => 'text/yaml'
  end

end
