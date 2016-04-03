ShopperEngine::Engine.routes.draw do
  scope 'cart' do
    get '/' => 'cart#index', as: 'cart'
    post 'add' => 'cart#add'
    post 'update' => 'cart#update_quantity'
    post 'submit' => 'cart#place'
  end
end
