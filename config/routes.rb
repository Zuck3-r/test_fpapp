Rails.application.routes.draw do
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get     '/choose', to: 'static_pages#choose'
  root 'static_pages#home'
  resources :planners
  resources :static_pages
end
