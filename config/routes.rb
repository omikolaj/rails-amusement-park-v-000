Rails.application.routes.draw do
    root 'application#home'
    
    get '/signin', to: 'sessions#new'
    post '/signin', to: 'sessions#create'
    delete '/signout', to: 'sessions#destroy' 

    resources :users
    resources :attractions

    post '/rides/new', to: 'rides#new'
    
end