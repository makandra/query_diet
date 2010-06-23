require 'spec_helper'

describe QueryDiet::Logger do

  before :each do
    QueryDiet::Logger.reset
  end

  describe 'count' do

    it "should return the number of queries since the last reset" do
      Movie.create
      Movie.create
      QueryDiet::Logger.count.should == 2
    end

  end

  describe 'time' do

    it "should return the number of miliseconds spent running database queries since the last reset" do
      Benchmark.should_receive(:realtime).and_return(5)
      Movie.create
      QueryDiet::Logger.time.should == 5000
    end

  end

end
