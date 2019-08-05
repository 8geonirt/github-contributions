# frozen_string_literal: true

Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  delete 'signout', to: 'sessions#destroy', as: 'signout'
  get 'sessions/new', as: 'login'
  get 'contributions/:project_id', to: 'contributions#index', as: 'contributions'
  get 'projects/:user_id', to: 'projects#index', as: 'projects'
  get 'sessions/create'
  get 'sessions/destroy'
  root to: 'home#index'
end
