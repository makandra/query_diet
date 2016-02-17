require 'spec_helper'

describe QueryDiet::Widget::Helper, :type => :helper do

  it "should be highlighted if the request was too intimate with the database" do
    QueryDiet::Logger.stub :bad? => true
    helper.query_diet_widget.should have_selector('div#query_diet.bad')
  end

  it "should not be highlighted if the request spent little time in the database" do
    QueryDiet::Logger.stub :bad? => false
    helper.query_diet_widget.should have_selector('div#query_diet.good')
  end

  it "should contain the number of requests and the duration spent running queries" do
    QueryDiet::Logger.stub :count => 78, :time => 43500
    helper.query_diet_widget.should have_selector('div#query_diet', :text => "78 / 43500ms")
  end

  it 'should allow to set the request threshold' do
    QueryDiet::Logger.stub :count => 4, :time => 1000
    helper.query_diet_widget.should have_selector('div#query_diet.good')
    helper.query_diet_widget(:bad_count => 3).should have_selector('div#query_diet.bad')
  end

  it 'should allow to set the request threshold' do
    QueryDiet::Logger.stub :count => 2, :time => 3000
    helper.query_diet_widget.should have_selector('div#query_diet.good')
    helper.query_diet_widget(:bad_time => 2000).should have_selector('div#query_diet.bad')
  end

end
