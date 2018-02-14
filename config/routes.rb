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

  resources :plans
  resources :hubs
  resources :consignments
  resources :merchants
  get 'pages/about'
  root 'dashboard#index'
end
