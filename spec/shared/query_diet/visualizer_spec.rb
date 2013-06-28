require 'spec_helper'

describe QueryDiet::Widget::Visualizer do

  describe 'bad?' do

    it 'should return true when the base queries are exceeded' do
      visualizer = QueryDiet::Widget::Visualizer.new(:base_queries => 10)
      visualizer.stub(:count => 12)
      visualizer.send(:bad?).should be_true
    end

    it 'should return false when the base queries are not exceeded' do
      visualizer = QueryDiet::Widget::Visualizer.new(:base_queries => 10)
      visualizer.stub(:count => 10)
      visualizer.send(:bad?).should be_false
    end

  end

  describe 'font_size_by_query_count' do

    it 'should return the default font size when the base queries are not exceeded' do
      visualizer = QueryDiet::Widget::Visualizer.new(:base_queries => 10)
      visualizer.stub(:count => 10)
      visualizer.send(:font_size_by_query_count).should == 16
    end

    it 'should add the growth per query for each query' do
      visualizer = QueryDiet::Widget::Visualizer.new(:base_queries => 10, :growth_per_query => 2)
      visualizer.stub(:count => 12)
      visualizer.send(:font_size_by_query_count).should == 20
    end

  end

end
