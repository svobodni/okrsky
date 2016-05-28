Rails.application.routes.draw do

  get '/wards' => 'api#wards'
  get '/municipalities' => 'api#municipalities'
  get '/districts' => 'api#districts'

  # get 'welcome/index'
  #
  # get "exports/index"
  # get 'exports/regions'
  # get 'exports/municipalities'
  # get 'exports/wards'
  get '/exports/:region_id/index', to: 'exports#index', as: :export_region
  # get '/exports/:region_id/senat', to: 'exports#senat'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_for :commisaries, :controllers => {:registrations => "commisaries/registrations"}
  resources :commisaries, only: [:index, :show, :new, :destroy, :edit, :update]
  resources :events, only: [:index]
  resources :regions, only: [:index]
  resources :users, only: [:index]

  # mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  get '/users/:id' => "commisaries#index", as: "user"
  root 'welcome#index'

  get '/stats', to: 'stats#index'

  # get '/auth/:provider/callback', to: 'sessions#create'
end
