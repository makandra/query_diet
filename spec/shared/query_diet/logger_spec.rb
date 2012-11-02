require 'spec_helper'

describe QueryDiet::Logger do
  before do
    QueryDiet::Logger.reset
  end

  describe "#reset" do
    it "should reset count/time/queries" do
      QueryDiet::Logger.count.should == 0
      QueryDiet::Logger.time.should == 0
      QueryDiet::Logger.queries.should == []

      Benchmark.should_receive(:realtime).and_return(5)
      Movie.create

      QueryDiet::Logger.count.should > 0
      QueryDiet::Logger.time.should > 0
      QueryDiet::Logger.queries.size.should > 0
    end
  end

  describe "#count" do
    it "should return the number of queries since the last reset" do
      Movie.create
      Movie.create
      QueryDiet::Logger.count.should == 2
    end
  end

  describe "#time" do
    it "should return the number of miliseconds spent running database queries since the last reset" do
      Benchmark.should_receive(:realtime).and_return(5)
      Movie.create
      QueryDiet::Logger.time.should == 5000
    end
  end

  describe "#queries" do
    it "should return the queries since last reset" do
      Benchmark.should_receive(:realtime).and_return(5.1234)
      Movie.create
      QueryDiet::Logger.queries.size.should == 1
      query = QueryDiet::Logger.queries.first
      query.size.should == 2
      query[0].should include("INSERT INTO \"movies\"")
      query[1].should == 5.1234
    end
  end
end
