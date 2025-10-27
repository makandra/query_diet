describe QueryDiet::Logger do

  before do
    QueryDiet::Logger.reset
  end

  def mock_realtime(seconds)
    expect(QueryDiet::Benchmark).to receive(:realtime).at_least(:once).and_wrap_original do |original_method, *args, &block|
      original_method.call(*args, &block)
      seconds
    end
  end

  describe "#reset" do
    it "should reset count/time/queries" do
      QueryDiet::Logger.count.should == 0
      QueryDiet::Logger.time.should == 0
      QueryDiet::Logger.queries.should == []

      mock_realtime(5)
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
      mock_realtime(5)
      Movie.create
      QueryDiet::Logger.time.should == 5000
    end
  end

  describe "#queries" do
    it "should return the queries since last reset" do
      mock_realtime(5.1234)
      Movie.create
      QueryDiet::Logger.queries.size.should == 1
      query = QueryDiet::Logger.queries.first
      query.size.should == 2
      query[0].should include("INSERT INTO \"movies\"")
      query[1].should == 5.1234
    end
  end

  describe "#paused" do

    before do
      QueryDiet::Logger.paused = false
    end

    after do
      QueryDiet::Logger.paused = false
    end

    it "should be false by default" do
      QueryDiet::Logger.paused.should == false
    end

    it "should pause the query count" do
      Movie.create
      Movie.create
      QueryDiet::Logger.count.should == 2

      QueryDiet::Logger.paused = true
      Movie.create
      QueryDiet::Logger.count.should == 2

      QueryDiet::Logger.paused = false
      Movie.create
      QueryDiet::Logger.count.should == 3
    end

    # regression
    it "should still execute queries if paused" do
      Movie.delete_all
      QueryDiet::Logger.paused = true
      Movie.count.should == 0
      Movie.create
      Movie.count.should == 1
    end

    it "should be false by default" do
      QueryDiet::Logger.paused.should == false
    end

  end

end
