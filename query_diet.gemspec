# -*- encoding: utf-8 -*-
$: << File.expand_path('../lib', __FILE__)
require 'query_diet/version'

Gem::Specification.new do |gem|
  gem.authors       = ["Henning Koch", "Tobias Kraze"]
  gem.email         = "github@makandra.de"
  gem.description   = "Rails database query counter that stays out of your way"
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/makandra/query_diet"
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "query_diet"
  gem.require_paths = ["lib"]
  gem.version       = QueryDiet::VERSION

  gem.post_install_message = "Remember to put <%= query_diet_widget %> into your app layout."
end

