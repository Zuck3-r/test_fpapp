Rails.application.routes.draw do
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get     '/choose', to: 'static_pages#choose'
  get     '/planners/schedule', to: 'planners#schedule'
  post    '/planners/:id', to: 'reservations#create'
  post    '/planners/:id/edit', to: 'planners#update'
  get     '/customers/schedule', to: 'customers#schedule'
  get     '/customers/search', to: 'customers#search'
  post    '/reservations/:id', to: 'reservations#update'
  root 'static_pages#home'
  resources :planners, only: %i[new create show edit update destroy search]
  resources :customers, only: %i[new create show edit update destroy search]
  resource :static_pages
  resources :reservations,          only: [:create, :update, :destroy]
end
