require 'spec_helper'

describe 'The widget', :type => defined?(RSpec) ? :request : :integration do

  it "should be included via a helper" do
    get 'query_diet/two_queries'
    response.should have_selector('div#query_diet')
  end

  it 'should show the correct number of queries' do
    get 'query_diet/no_query'
    response.should have_selector('#query_diet', :content => '0 queries')
    get 'query_diet/two_queries'
    response.should have_selector('#query_diet', :content => '2 queries')
  end

  it 'should reset the queries after each request' do
    get 'query_diet/two_queries'
    get 'query_diet/two_queries'
    response.should have_selector('#query_diet', :content => '2 queries')
  end

end
