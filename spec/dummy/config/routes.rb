Rails.application.routes.draw do
  mount ShopperEngine::Engine => "/shopper_engine"
  devise_for :customers

  root 'books#index'
  resources :books, only: [:index, :show]
end
