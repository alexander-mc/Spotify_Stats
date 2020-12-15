Rails.application.routes.draw do
  
  root 'welcome#index'
  
  resources :users, only: [:new, :create] do
    resources :reports
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'  
  
  get '/auth/spotify', as: 'authentication'
  get '/auth/spotify/callback', to: 'authentication#callback'
  get '/auth/failure', to: 'authentication#failure'

end
