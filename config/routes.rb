Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :orders do
      resources :events, :only => :index
    end

    match 'integration' => 'integration#show', via: [:get,:post]
    match 'integration/register' => 'integration#register', via: [:get,:post]
    match 'integration/connect' => 'integration#connect', via: [:get,:post]
    match 'integration/disconnect' => 'integration#disconnect', via: [:get,:post]
    match 'integration/*backbone' => 'integration#show', via: [:get,:post], as: :integration_backbone
  end

  namespace :api, :defaults => { :format => 'json' } do
    get 'integrator',                       to: 'integrator#index'
    get 'integrator/orders',                 to: 'integrator#show_orders'
    get 'integrator/carts',                  to: 'integrator#show_carts'
    get 'integrator/users',                  to: 'integrator#show_users'
    get 'integrator/products',               to: 'integrator#show_products'
    get 'integrator/return_authorizations',  to: 'integrator#show_return_authorizations'
    get 'integrator/stock_transfers',        to: 'integrator#show_stock_transfers'
    get 'integrator/taxons',                 to: 'integrator#show_taxons'
  end
end
