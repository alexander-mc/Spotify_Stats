Rails.application.routes.draw do
  
  root 'welcome#index'
  
  # MUST REMOVE UNUSED VIEWS
  resources :users, only: [:new, :create] do
    resources :reports # , only: [:index, :show, :new]
  end

  #resources :reports

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'  

  get '/auth/spotify', as: 'authentication'
  get '/auth/spotify/callback', to: 'authentication#callback'
  # get '/auth/failure', to: 'authentication#failure'
  # post '/authorize/cancel', to: 'authentication#failure'
  get '/auth/failure', to: 'authentication#failure'


end
