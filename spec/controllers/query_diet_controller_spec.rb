require 'spec_helper'

describe QueryDietController do
  integrate_views

  describe 'widget' do
    it "should be automatically included in a HTML page" do
      get :two_queries
      response.body.should have_tag('div#query_diet')
    end

    it "should not be included in pages that have no body tag" do
      get :no_body_tag
      response.body.should_not have_tag('div#query_diet')
    end

    it "should not be included in pages that are not text/html" do
      get :yaml
      response.body.should_not have_tag('div#query_diet')
    end

    it "should be highlighted if the request was too intimate with the database" do
      QueryDiet::Logger.stub :bad? => true
      get :no_query
      response.body.should have_tag('div#query_diet.bad')
    end

    it "should not be highlighted if the request spent little time in the database" do
      QueryDiet::Logger.stub :bad? => false
      get :no_query
      response.body.should have_tag('div#query_diet.good')
    end

    it "should contain the number of requests and the duration spent running queries" do
      QueryDiet::Logger.stub :count => 78, :time => 43500
      get :no_query
      response.body.should have_tag('div#query_diet', :text => "78 / 43500ms")
    end
  end
end
