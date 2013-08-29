require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
require 'spree/core/testing_support/common_rake'
require 'json'
require 'httparty'

RSpec::Core::RakeTask.new

task :default => [:spec]

desc 'Generates a dummy app for testing'
task :test_app do
  ENV['LIB_NAME'] = 'spree_hub_connector'
Rake::Task['common:test_app'].invoke
end
