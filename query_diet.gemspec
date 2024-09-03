$:.push File.expand_path("../lib", __FILE__)
require "query_diet/version"

Gem::Specification.new do |gem|
  gem.name          = 'query_diet'
  gem.version       = QueryDiet::VERSION
  gem.authors       = ["Henning Koch", "Tobias Kraze"]
  gem.email         = "github@makandra.de"
  gem.homepage      = "https://github.com/makandra/query_diet"
  gem.summary   = "Rails database query counter that stays out of your way"
  gem.description       = gem.summary
  gem.license       = 'MIT'

  gem.required_ruby_version = '>= 2.0.0'
  gem.metadata      = {
    'source_code_uri' => gem.homepage,
    'bug_tracker_uri' => gem.homepage + '/issues',
    'changelog_uri' => gem.homepage + '/blob/master/CHANGELOG.md',
    'rubygems_mfa_required' => 'true',
  }

  gem.files = `git ls-files README.md MIT-LICENSE lib`.split($\)
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ["lib"]
end

