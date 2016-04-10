ShopperEngine::Engine.routes.draw do
  scope 'cart' do
    get '/' => 'cart#index', as: 'cart'
    post 'add' => 'cart#add', as: 'add_to_cart'
    post 'update' => 'cart#update_quantity', as: 'cart_update_quantity'
    post 'submit' => 'cart#place', as: 'cart_submit'
  end
  resources :checkout, only: [:index, :show, :update]
end
