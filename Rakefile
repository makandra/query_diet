require 'rake'
require 'rake/rdoctask'
require 'spec/rake/spectask'

desc "Run all specs"
Spec::Rake::SpecTask.new(:default){}

desc 'Generate documentation for the query_diet gem.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'query_diet'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "query_diet"
    gemspec.summary = "Rails database query counter that stays out of your way"
    gemspec.email = "github@makandra.de"
    gemspec.homepage = "http://github.com/makandra/query_diet"
    gemspec.description = "Rails database query counter that stays out of your way"
    gemspec.authors = ["Henning Koch"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end
