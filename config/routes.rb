Rails.application.routes.draw do
  
  root 'welcome#home'
  
  # MUST REMOVE UNUSED VIEWS
  resources :users do
    resources :reports
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'  

end
