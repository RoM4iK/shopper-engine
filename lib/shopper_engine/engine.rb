module ShopperEngine
  class Engine < ::Rails::Engine
    isolate_namespace ShopperEngine

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    initializer 'shopper_engine' do
      ActiveSupport.on_load :active_record do
        ActiveRecord::Base.send :include, ShopperEngine::ActsAsProduct
        ActiveRecord::Base.send :include, ShopperEngine::ActsAsCustomer
      end
      ActiveSupport.on_load :action_controller do
        helper ShopperEngine::ApplicationHelper
        helper ShopperEngine::CartHelper
      end
    end
  end
end
