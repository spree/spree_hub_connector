# Run Coverage report
require 'simplecov'
SimpleCov.start do
  add_group 'Controllers', 'app/controllers'
  add_group 'Helpers', 'app/helpers'
  add_group 'Mailers', 'app/mailers'
  add_group 'Models', 'app/models'
  add_group 'Views', 'app/views'
  add_group 'Libraries', 'lib'
end

# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require File.expand_path('../dummy/config/environment.rb',  __FILE__)

require 'rspec/rails'
require 'ffaker'
require 'vcr'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each { |f| require f }

# Requires factories defined in spree_core
require 'spree/core/testing_support/factories'
require 'spree/core/testing_support/controller_requests'
require 'spree/core/testing_support/authorization_helpers'
require 'spree/core/url_helpers'

require 'spree/api/testing_support/helpers'
require 'spree/api/testing_support/setup'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include Spree::Api::TestingSupport::Helpers, :type => :controller
  config.extend Spree::Api::TestingSupport::Setup, :type => :controller

  # == URL Helpers
  #
  # Allows access to Spree's routes in specs:
  #
  # visit spree.admin_path
  # current_path.should eql(spree.products_path)
  config.include Spree::Core::UrlHelpers
  config.mock_with :rspec
  config.color = true
  config.use_transactional_fixtures = true

  config.fail_fast = ENV['FAIL_FAST'] || false

  VCR.configure do |c|
    c.cassette_library_dir = 'spec/fixtures/cassettes'
    c.hook_into :webmock
  end
end
