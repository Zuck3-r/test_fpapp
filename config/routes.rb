Rails.application.routes.draw do
  root 'planners#index'
  resources :planners
end
