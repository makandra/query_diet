require 'spec_helper'

describe QueryDiet::Widget::Helper, :type => :helper do

  it "should be highlighted if the request was too intimate with the database" do
    visualizer = QueryDiet::Widget::Visualizer.new
    visualizer.stub(:bad? => true)
    QueryDiet::Widget::Visualizer.stub :new => visualizer
    helper.query_diet_widget.should have_selector('div#query_diet.bad')
  end

  it "should not be highlighted if the request spent little time in the database" do
    visualizer = QueryDiet::Widget::Visualizer.new
    visualizer.stub(:bad? => false)
    QueryDiet::Widget::Visualizer.stub :new => visualizer
    helper.query_diet_widget.should have_selector('div#query_diet.good')
  end

  it "should contain the number of queries" do
    QueryDiet::Logger.stub :count => 78
    helper.query_diet_widget.should have_selector('div#query_diet', :content => "78 queries")
    QueryDiet::Logger.stub :count => 1
    helper.query_diet_widget.should have_selector('div#query_diet', :content => "1 query")
  end

  it 'should allow to set the base queries' do
    QueryDiet::Logger.stub :count => 4
    helper.query_diet_widget.should have_selector('div#query_diet.good')
    helper.query_diet_widget(:base_queries => 3).should have_selector('div#query_diet.bad')
  end

end
