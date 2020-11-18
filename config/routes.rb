Rails.application.routes.draw do
  
  root 'welcome#index'
  
  # MUST REMOVE UNUSED VIEWS
  resources :users do
    resources :reports
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'  

end
