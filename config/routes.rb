Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :orders do
      resources :events, :only => :index
    end

    match 'integration'            => 'integration#show'
    match 'integration/register'   => 'integration#register'
    match 'integration/connect'    => 'integration#connect'
    match 'integration/disconnect' => 'integration#disconnect'
    match 'integration/*backbone'  => 'integration#show'
  end

  namespace :api, :defaults => { :format => 'json' } do

    scope 'integrator' do
      get '',                       to: 'integrator#index'
      get 'orders',                 to: 'integrator#show_orders'
      get 'carts',                  to: 'integrator#show_carts'
      get 'users',                  to: 'integrator#show_users'
      get 'products',               to: 'integrator#show_products'
      get 'return_authorizations',  to: 'integrator#show_return_authorizations'
      get 'stock_transfers',        to: 'integrator#show_stock_transfers'
    end
  end
end

