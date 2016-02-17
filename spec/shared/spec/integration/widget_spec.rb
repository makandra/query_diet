require 'spec_helper'

describe 'The widget', type: :feature do

  it "should be included via a helper" do
    visit '/query_diet/two_queries'
    page.should have_css('div#query_diet')
  end

  it 'should show the correct number of queries' do
    visit '/query_diet/no_query'
    page.should have_css('#query_diet', :text => '0 /')
    visit '/query_diet/two_queries'
    page.should have_css('#query_diet', :text => '2 /')
  end

  it 'should reset the queries after each request' do
    visit '/query_diet/two_queries'
    visit '/query_diet/two_queries'
    page.should have_css('#query_diet', :text => '2 /')
  end

end
