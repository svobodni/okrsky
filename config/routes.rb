Okrsky::Application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  root 'signup#index'

  resources :signup
  get '/stats', to: 'stats#index'
end
