require './lib/query_diet/version'

Gem::Specification.new "query_diet", QueryDiet::VERSION do |gem|
  gem.authors       = ["Henning Koch", "Tobias Kraze"]
  gem.email         = "github@makandra.de"
  gem.description   = "Rails database query counter that stays out of your way"
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/makandra/query_diet"
  gem.license       = 'MIT'
  gem.files         = `git ls-files README.rdoc MIT-LICENSE lib`.split($\)
  gem.required_ruby_version = '>= 2.0.0'
end

