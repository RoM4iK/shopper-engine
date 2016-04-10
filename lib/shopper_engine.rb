require 'wicked'
require 'haml'
require 'byebug'

require "shopper_engine/engine"
require "shopper_engine/model_methods/acts_as_product"
require "shopper_engine/model_methods/acts_as_customer"


module ShopperEngine
  CONFIG = {}
  def self.set_devise_scope(scope)
    ShopperEngine::CONFIG[:devise_scope] = scope
  end

  def self.devise_scope
    ShopperEngine::CONFIG[:devise_scope]
  end
  PRODUCT_CLASSES = []
end
