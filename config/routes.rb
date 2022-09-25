Rails.application.routes.draw do
  get 'health', to: 'health#health'
  
  resources :shorteners, ony: [:create]

  get '/david/:short_code', to: 'shorteners#show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
