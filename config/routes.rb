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
    get :integrator, :to => 'integrator#index'
  end
end

