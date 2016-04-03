class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  Devise.setup do |config|
    config.parent_controller = 'ShopperEngine::ApplicationController'
  end
end
