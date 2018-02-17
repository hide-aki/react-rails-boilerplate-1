Rails.application.routes.draw do
  # Custom devise
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      confirmations: 'users/confirmations'
  }, path: '/', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      # password: 'secret',
      # confirmation: 'verification',
      sign_up: 'signup',
      edit: 'edit/profile'
  }

  # Users registration, edit, update
  # resources :user_registrations, only: [] do
  get '/users', to: 'user_registrations#index', as: :users
  get '/user/:id', to: 'user_registrations#show', as: :user_details
  get '/users/new', to: 'user_registrations#new', as: :new_user
  post '/users', to: 'user_registrations#create'
  get '/user/:id/edit', to: 'user_registrations#edit', as: :edit_user
  # patch '/user/:id', to: 'user_registrations#update'
  put '/user/:id/edit', to: 'user_registrations#update'
  get '/user/:id/edit_password', to: 'user_registrations#edit_password', as: :edit_password
  put '/user/:id/edit_password', to: 'user_registrations#update_password'
  # end

  resources :plans
  resources :hubs
  resources :consignments
  resources :merchants
  get 'pages/about'
  root 'dashboard#index'
end
