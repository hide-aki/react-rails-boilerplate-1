Rails.application.routes.draw do
  resources :plans
  # ========================================
  #                user
  # ========================================
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

  resources :students
  get 'pages/about'
  root 'dashboard#index'
end
