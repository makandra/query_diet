require 'spec_helper'

describe 'The widget', :type => :integration do

  it "should be included via a helper" do
    get 'query_diet/two_queries'
    response.body.should have_tag('div#query_diet')
  end

  it 'should show the correct number of queries' do
    get 'query_diet/no_query'
    response.body.should have_tag('#query_diet', /0 \/ \d+ms/)
    get 'query_diet/two_queries'
    response.body.should have_tag('#query_diet', /2 \/ \d+ms/)
  end

  it 'should reset the queries after each request' do
    get 'query_diet/two_queries'
    get 'query_diet/two_queries'
    response.body.should have_tag('#query_diet', /2 \/ \d+ms/)
  end

end
