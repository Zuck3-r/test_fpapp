Rails.application.routes.draw do
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get     '/choose', to: 'static_pages#choose'
  post    '/planners/:id', to: 'reservations#create'
  post    '/planners/:id/edit', to: 'planners#update'
  root 'static_pages#home'
  resources :planners
  resources :static_pages
  resources :customers
  resources :reservations,          only: [:create, :update, :destroy]
end
