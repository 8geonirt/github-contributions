Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  delete 'signout', to: 'sessions#destroy', as: 'signout'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root to: 'sessions#new'
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
