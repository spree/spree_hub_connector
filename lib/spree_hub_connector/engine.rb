module SpreeHubConnector
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_hub_connector'

    config.autoload_paths += %W(#{config.root}/app/models)
    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    def self.path_to_views
      File.expand_path("../../app/views", File.dirname(__FILE__))
    end

    initializer "spree_hub_connector.append_api_attributes" do
      if defined? Spree::Api::ApiHelpers::ATTRIBUTES
        Spree::Api::ApiHelpers.variant_attributes.push :external_ref
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
