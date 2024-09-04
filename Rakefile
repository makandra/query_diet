require 'bundler/setup'
require 'bundler/gem_tasks'

desc 'Default: Run all specs.'
task :default => ['all:bundle:install', 'all:spec']

namespace :all do
  desc "Run specs on all spec apps"
  task :spec do
    each_rails_version do |directory|
      env = "SPEC=../../#{ENV['SPEC']} " if ENV['SPEC']
      sh("cd #{directory} && #{env} bundle exec rake spec")
    end
  end

  namespace :bundle do
    desc "Bundle all spec apps"
    task :install do
      each_rails_version do |directory|
        sh("cd #{directory} && (bundle check || bundle install --quiet)")
      end
    end

    desc "Update a gem given by the GEM environment variable"
    task :update do
      gem = ENV['GEM'] or raise "Name the gem you wish to update by setting a environment variable GEM"
      each_rails_version do |directory|
        sh("cd #{directory} && bundle update #{gem}")
      end
    end
  end
end

def each_rails_version
  Dir['spec/rails-*'].sort.each do |directory|
    rails_version = /spec\/rails-(\d+\.\d+)/.match(directory)[1].to_f
    if rails_version >= 7.2 && RUBY_VERSION < "3.1.0"
      puts "Skipping #{directory} since rails 7.2+ is not supported on ruby #{RUBY_VERSION}"
    elsif rails_version >= 7.0 && RUBY_VERSION < "2.7.0"
      puts "Skipping #{directory} since rails 7+ is not supported on ruby #{RUBY_VERSION}"
    elsif rails_version < 5.0 && RUBY_VERSION >= "2.7.0"
      puts "Skipping #{directory} since rails < 5 is not supported on ruby #{RUBY_VERSION}"
    elsif rails_version < 6.0 && RUBY_VERSION >= "3.0.0"
      puts "Skipping #{directory} since rails < 6 is not supported on ruby #{RUBY_VERSION}"
    else
      puts '', "\033[44m#{directory}\033[0m", ''
      unbundled_env_method = Bundler.respond_to?(:with_unbundled_env) ? :with_unbundled_env : :with_clean_env
      Bundler.send(unbundled_env_method) { yield directory }
    end
  end
end
