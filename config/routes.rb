Rails.application.routes.draw do
  resources :articles
  resources :students
  get 'pages/about'
  root 'dashboard#index'
end
