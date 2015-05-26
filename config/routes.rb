Rails.application.routes.draw do
  get 'notifications/index'
    scope '/portal' do
      devise_for :users
    end

  resources :users do
    member do
      patch :activate
      patch :deactivate
    end
  end

  resources :tenants do 
    member do
      get :permitted_roles
    end
  end
  resources :customers
  resources :site_roles
  resources :sites
  
  root 'home#index'

  get '/templates', to: 'home#templates'
  get '/vouchers', to: 'home#vouchers'
  get '/analytics', to: 'home#analytics'
  get '/reports', to: 'home#reports'
  get '/radius_config', to: 'home#radius_configurations'
  get '/access_points', to: 'home#access_points'
  get '/time_policy', to: 'home#time_policy'
  get '/guests', to: 'home#guests'
  get '/sms_gateway', to: 'home#sms_gateway'
end
