Rails.application.routes.draw do
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get     '/choose', to: 'static_pages#choose'
  get     '/planners/schedule', to: 'planners#schedule'
  post    '/planners/:id', to: 'reservations#create'
  post    '/planners/:id/edit', to: 'planners#update'
  get     '/customers/schedule', to: 'customers#schedule'
  post    '/reservations/:id', to: 'reservations#update'
  root 'static_pages#home'
  resource :planners
  resource :static_pages
  resource :customers
  resource :reservations,          only: [:create, :update, :destroy]
end
