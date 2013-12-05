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
    get 'integrator',                       to: 'integrator#index'
    get 'integrator/orders',                 to: 'integrator#show_orders'
    get 'integrator/users',                  to: 'integrator#show_users'
    get 'integrator/products',               to: 'integrator#show_products'
    get 'integrator/return_authorizations',  to: 'integrator#show_return_authorizations'
    get 'integrator/stock_transfers',        to: 'integrator#show_stock_transfers'
  end
end
