Rails.application.routes.draw do
  resources :articles
  resources :comments
  resource  :dashboard
  resource  :account, :only => [:show] do
    get :work
  end

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  namespace :api do
    namespace :v1 do
      resources :articles, only: [:show, :index]
    end
  end

  root to: 'dashboard#show'
end
